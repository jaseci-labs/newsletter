"""Jaseci Digest backend: subscribe walker.

This module exposes a single :pub walker (Subscribe) that becomes a REST
endpoint via jac-scale. The walker handles single-opt-in subscription to
Buttondown plus a custom per-subscriber welcome email.
"""

import os;
import json;
import re;
import time;
import uuid;
import yaml;
import markdown as md;
import from datetime { date as date_cls }
import from pathlib { Path }
import from urllib.request { Request, urlopen }
import from urllib.error { HTTPError, URLError }

cl {
    def:pub app(props: any) -> JsxElement {
        can with entry {
            document.title = "Jaseci Digest · biweekly newsletter for the Jaseci & Jac ecosystem";
            existing = document.querySelector("link[rel='icon']");
            if not existing {
                icon = document.createElement("link");
                icon.rel = "icon";
                icon.type = "image/png";
                icon.href = "/logo.png";
                document.head.appendChild(icon);
            }
        }
        return <>{props.children}</>;
    }
}


glob EMAIL_RE = re.compile(r"^[^\s@]+@[^\s@]+\.[^\s@]+$");
glob BUTTONDOWN_SUBSCRIBERS_URL = "https://api.buttondown.email/v1/subscribers";
glob BUTTONDOWN_EMAILS_URL = "https://api.buttondown.email/v1/emails";

glob WELCOME_SUBJECT = "Welcome to Jaseci Digest";
glob WELCOME_BODY = "Hey,\n\nThanks for subscribing to **Jaseci Digest**, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.\n\n**What to expect**\n\n- **One issue every other Tuesday.** Releases, articles, JacHacks projects, talks, RFCs, and the occasional deep dive.\n- **No spam.** Unsubscribe anytime. Every email has a one-click link at the bottom.\n- **Worth your time.** Nothing goes out until it clears the editor's bar.\n\n**Before the first issue lands, a few things to explore**\n\n- Check out [jaseci.org](https://www.jaseci.org)\n- Join the [Jaseci Discord](https://discord.gg/jaseci). Most of the ecosystem conversation lives there.\n\nGot something we should cover? Just reply to this email. It lands in the editor's inbox.\n\nThanks,\nThe Jaseci Digest team";

glob ACTIVE_SUBSCRIBER_TYPES = {"regular", "unactivated", "gifted"};
glob ISSUES_DIR = "src/content/issues";


def:priv format_date(date_str: str) -> str {
    try {
        parsed = date_cls.fromisoformat(date_str);
        return parsed.strftime("%B %d, %Y").upper();
    } except Exception {
        return date_str.upper();
    }
}


def:priv format_date_long(date_str: str) -> str {
    try {
        parsed = date_cls.fromisoformat(date_str);
        return parsed.strftime("%B %d, %Y");
    } except Exception {
        return date_str;
    }
}


def:priv _add_md_attr(m: any) -> str {
    tag = m.group(1);
    attrs = m.group(2) or "";
    return "<" + str(tag) + str(attrs) + ' markdown="1">';
}


def:priv inject_markdown_attr(body: str) -> str {
    return re.sub(r"<(div|figure|a)(\s+[^>]*)?>", _add_md_attr, body);
}


def:priv parse_issue_file(path: Path) -> dict | None {
    try {
        text = path.read_text(encoding="utf-8");
    } except Exception {
        return None;
    }

    if not text.startswith("---") {
        return None;
    }

    parts = text.split("---", 2);
    if len(parts) < 3 {
        return None;
    }

    frontmatter_text = parts[1];
    body = inject_markdown_attr(parts[2].strip());

    try {
        meta = yaml.safe_load(frontmatter_text);
    } except Exception {
        return None;
    }

    if not isinstance(meta, dict) {
        return None;
    }

    if meta.get("draft", False) {
        return None;
    }

    raw_date = str(meta.get("date", ""));
    return {
        "slug": path.stem,
        "number": int(meta.get("number", 0)),
        "title": str(meta.get("title", "")),
        "date": raw_date,
        "date_formatted": format_date(raw_date),
        "date_long": format_date_long(raw_date),
        "description": str(meta.get("description", "")),
        "body": body,
    };
}


walker:pub GetIssues {
    can get with Root entry {
        dir_path = Path(ISSUES_DIR);
        if not dir_path.exists() {
            report {"issues": []};
            return;
        }

        items = [];
        for path in sorted(dir_path.glob("*.md")) {
            if path.name.startswith("_") {
                continue;
            }
            parsed = parse_issue_file(path);
            if parsed is None {
                continue;
            }
            items.append({
                "slug": parsed["slug"],
                "number": parsed["number"],
                "title": parsed["title"],
                "date": parsed["date"],
                "date_long": parsed["date_long"],
                "description": parsed["description"],
            });
        }

        items.sort(key=lambda x: dict -> int { return x["number"]; }, reverse=True);
        report {"issues": items};
    }
}


walker:pub GetIssue {
    has slug: str = "";

    can get with Root entry {
        if not self.slug {
            report {"ok": False, "error": "missing slug"};
            return;
        }

        path = Path(ISSUES_DIR) / f"{self.slug}.md";
        if not path.exists() {
            report {"ok": False, "error": "not found"};
            return;
        }

        parsed = parse_issue_file(path);
        if parsed is None {
            report {"ok": False, "error": "could not parse"};
            return;
        }

        html = md.markdown(
            parsed["body"],
            extensions=["fenced_code", "codehilite", "tables", "attr_list", "md_in_html"],
        );

        report {
            "ok": True,
            "slug": parsed["slug"],
            "number": parsed["number"],
            "title": parsed["title"],
            "date": parsed["date"],
            "date_formatted": parsed["date_formatted"],
            "description": parsed["description"],
            "html": html,
        };
    }
}


def:priv http_post(url: str, api_key: str, body: dict) -> tuple[int, dict] {
    payload = json.dumps(body).encode("utf-8");
    req = Request(url, data=payload, method="POST");
    req.add_header("Authorization", f"Token {api_key}");
    req.add_header("Content-Type", "application/json");
    req.add_header("X-Buttondown-Live-Dangerously", "true");
    try {
        resp = urlopen(req, timeout=10);
        raw = resp.read().decode("utf-8");
        parsed = json.loads(raw) if raw else {};
        return (resp.status, parsed);
    } except HTTPError as e {
        raw = e.read().decode("utf-8") if e.fp else "";
        parsed = {};
        try {
            parsed = json.loads(raw) if raw else {};
        } except Exception {
            parsed = {"detail": raw};
        }
        return (e.code, parsed);
    } except URLError as e {
        return (0, {"detail": str(e)});
    }
}


def:priv http_get(url: str, api_key: str) -> tuple[int, dict] {
    req = Request(url, method="GET");
    req.add_header("Authorization", f"Token {api_key}");
    try {
        resp = urlopen(req, timeout=10);
        raw = resp.read().decode("utf-8");
        parsed = json.loads(raw) if raw else {};
        return (resp.status, parsed);
    } except HTTPError as e {
        raw = e.read().decode("utf-8") if e.fp else "";
        parsed = {};
        try {
            parsed = json.loads(raw) if raw else {};
        } except Exception {
            parsed = {"detail": raw};
        }
        return (e.code, parsed);
    } except URLError as e {
        return (0, {"detail": str(e)});
    }
}


def:priv send_welcome_email(api_key: str, email: str, welcome_token: str) -> None {
    body = f"{WELCOME_BODY}\n\n<!-- welcome:{email}:{int(time.time() * 1000)} -->";
    payload = {
        "subject": WELCOME_SUBJECT,
        "body": body,
        "email_type": "private",
        "status": "about_to_send",
        "filters": {
            "filters": [
                {
                    "field": "subscriber.metadata.welcome_token",
                    "operator": "equals",
                    "value": welcome_token,
                }
            ],
            "groups": [],
            "predicate": "and",
        },
    };
    (status, _resp) = http_post(BUTTONDOWN_EMAILS_URL, api_key, payload);
    if status >= 400 {
        print(f"[subscribe] welcome email failed: {status}");
    }
}


walker:pub Subscribe {
    has email: str = "";

    can subscribe with Root entry {
        addr = self.email.strip();
        if not addr or not EMAIL_RE.match(addr) or len(addr) > 254 {
            report {"ok": False, "error": "Please enter a valid email address."};
            return;
        }

        api_key = os.environ.get("BUTTONDOWN_API_KEY", "");
        if not api_key {
            print("[subscribe] BUTTONDOWN_API_KEY is not set");
            report {"ok": False, "error": "Subscription is temporarily unavailable."};
            return;
        }

        welcome_token = str(uuid.uuid4());
        (status, resp) = http_post(BUTTONDOWN_SUBSCRIBERS_URL, api_key, {
            "email_address": addr,
            "type": "regular",
            "metadata": {
                "source": "jaseci-digest-site",
                "welcome_token": welcome_token,
            },
        });

        if 200 <= status < 300 {
            send_welcome_email(api_key, addr, welcome_token);
            report {"ok": True};
            return;
        }

        code = str(resp.get("code", "")) if isinstance(resp, dict) else "";
        detail = str(resp.get("detail", "")) if isinstance(resp, dict) else "";

        if code == "email_already_exists" or "already" in detail.lower() {
            # Disambiguate: previously-unsubscribed users also show as duplicates.
            url = f"{BUTTONDOWN_SUBSCRIBERS_URL}/{addr}";
            (_lookup_status, sub) = http_get(url, api_key);
            current = str(sub.get("type", "")) if isinstance(sub, dict) else "";
            if current in ACTIVE_SUBSCRIBER_TYPES {
                report {"ok": True, "alreadySubscribed": True};
                return;
            }
            report {
                "ok": False,
                "error": "This email previously unsubscribed and can't be resubscribed automatically. If this was a mistake, email us and we'll sort it out.",
            };
            return;
        }

        if code == "subscriber_suppressed" {
            report {
                "ok": False,
                "error": "This email previously unsubscribed and can't be resubscribed automatically. If this was a mistake, email us and we'll sort it out.",
            };
            return;
        }

        print(f"[subscribe] buttondown error status={status} code={code} detail={detail}");
        report {"ok": False, "error": "Something went wrong. Please try again."};
    }
}
