"""Render a Buttondown email source into the two browser-preview HTML files.
Run after editing the .md so previews stay in sync.

    jac run --no-serve tools/render_previews.jac 006   # email/006.md -> 006.html + 006-preview.html
    jac run --no-serve tools/render_previews.jac 004-jachacks-sf   # any stem works

--no-serve is required. [project] kind is "web-app", and since jaclang 0.37 a
named file resolves the project kind too, so a bare `jac run <file>` here starts
the dev server and hangs instead of executing the script.

This lives in tools/ rather than next to the sources it renders. A .jac file
inside email/ makes Jac register that directory as a package named `email`,
which shadows the Python stdlib `email` package and breaks every `jac` command
in the repo with "ModuleNotFoundError: No module named 'email.utils'".
"""

import re;
import sys;
import from pathlib { Path }
import from re { Match }

# The .md sources and .html outputs live in email/, one level up from tools/.
glob HERE = Path(__file__ as str).parent.parent / "email";

glob FONT_IMPORT = "@import url('https://fonts.googleapis.com/css2?family=Kaushan+Script&display=swap');";
glob INTER = "@font-face{font-family:'Inter';font-style:normal;font-weight:100 900;font-display:swap;"
             "src:url('https://rsms.me/inter/font-files/InterVariable.woff2?v=4.0') format('woff2');}";

glob CODE_STYLE = "background:#f0ece3;padding:1px 5px;border-radius:4px;font-size:0.9em;"
                  "font-family:'SFMono-Regular',Consolas,monospace;";

# Tags that never carry a matching close tag in the source .md.
glob VOID_TAGS = ("img", "hr", "br", "meta", "input");


# ---- inline markdown: **bold**, [text](url), `code` ----

"""re.sub callback: `code` -> a styled <code> span (named, per repo idiom)."""
def:priv _code_repl(m: Match[str]) -> str {
    return '<code style="%s">%s</code>' % (CODE_STYLE, m.group(1));
}


def:priv inline(s: str, fmt: str) -> str {
    s = re.sub(r"`([^`]+)`", _code_repl, s);
    s = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", s);
    if fmt == "email" {
        s = re.sub(
            r"\[([^\]]+)\]\(([^)]+)\)",
            r'<a href="\2" style="color:#c0531f;text-decoration:underline;">\1</a>',
            s
        );
    } else {
        s = re.sub(r"\[([^\]]+)\]\(([^)]+)\)", r'<a href="\2">\1</a>', s);
    }
    return s;
}


def:priv h2(text: str, fmt: str) -> str {
    if fmt == "email" {
        return ('<h2 style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:22px;font-weight:700;'
                'text-transform:uppercase;letter-spacing:-0.01em;color:#160f0a;margin:34px 24px 10px;padding-top:18px;">%s</h2>' % text);
    }
    return "<h2>%s</h2>" % text;
}


def:priv h3(text: str, fmt: str) -> str {
    m = re.`match(r"\[([^\]]+)\]\(([^)]+)\)", text);
    label = m.group(1) if m else text;
    url = m.group(2) if m else "#";
    if fmt == "email" {
        return ('<h3 style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:17px;font-weight:700;'
                'line-height:1.3;color:#160f0a;margin:20px 24px 6px;"><a href="%s" style="color:#160f0a;text-decoration:none;">%s</a></h3>' % (url, label));
    }
    return '<h3><a href="%s">%s</a></h3>' % (url, label);
}


def:priv para(text: str, fmt: str) -> str {
    if fmt == "email" {
        return ('<p style="font-family:\'Inter\',\'Helvetica Neue\',Arial,sans-serif;font-size:15px;line-height:1.6;'
                'color:#1f160e;margin:14px 24px;">%s</p>' % inline(text, fmt));
    }
    return "<p>%s</p>" % inline(text, fmt);
}


"""Split the leading <style> block off the source: returns (css, rest).

The Buttondown source opens with a <style> block carrying the font @import and
the .desk/.mob/.stack media query. That belongs in <head>, not in the rendered
body, and it spans several lines, so it is matched with DOTALL rather than by
the line-at-a-time loop in render_body (which looks for a close tag at column 0
and would otherwise swallow the whole file).
"""
def:priv split_head_css(source: str) -> tuple[str, str] {
    m = re.`match(r"(?s)\s*<style>(.*?)</style>\s*", source);
    if m {
        return (m.group(1).strip(), source[m.end():]);
    }
    return ("", source);
}


def:priv render_body(source: str, fmt: str) -> str {
    lines = source.split("\n");
    out: list[str] = [];
    i = 0;
    n = len(lines);
    while i < n {
        s = lines[i].rstrip("\n");
        if s.strip() == "" {
            i += 1;
            continue;
        }
        if s.lstrip().startswith("<!--") {
            # HTML comment: pass through verbatim, consume until the closer.
            # Without this the tag matcher below finds no tag name and swallows
            # the rest of the file looking for a close tag that never comes.
            block = [s];
            i += 1;
            while "-->" not in block[-1] and i < n {
                block.append(lines[i].rstrip("\n"));
                i += 1;
            }
            out.append("\n".join(block));
        } elif s[0] == "<" {  # raw HTML block at column 0
            m = re.`match(r"<(\w+)", s);
            tag = m.group(1) if m else "";
            block = [s];
            single = ("</%s>" % tag) in s or s.rstrip().endswith("/>") or tag in VOID_TAGS;
            i += 1;
            if not single {
                while i < n {
                    l2 = lines[i].rstrip("\n");
                    block.append(l2);
                    i += 1;
                    if l2.startswith("</%s>" % tag) {
                        break;
                    }
                }
            }
            out.append("\n".join(block));
        } elif s.startswith("## ") {
            out.append(h2(s[3:].strip(), fmt));
            i += 1;
        } elif s.startswith("### ") {
            out.append(h3(s[4:].strip(), fmt));
            i += 1;
        } else {  # markdown paragraph (accumulate)
            para_lines = [s];
            i += 1;
            while i < n {
                l2 = lines[i].rstrip("\n");
                if l2.strip() == "" or l2.startswith("<") or l2.startswith("#") {
                    break;
                }
                para_lines.append(l2);
                i += 1;
            }
            out.append(para(" ".join(para_lines), fmt));
        }
    }
    return "\n".join(out);
}


def:priv build_email(body: str, issue_no: str, head_css: str) -> str {
    # The source's own <style> already carries the @import, so it stands in for
    # FONT_IMPORT when present. It goes first: CSS ignores a late @import.
    css = head_css if head_css else FONT_IMPORT;
    head = ('<!DOCTYPE html><html lang="en"><head><meta charset="utf-8">'
            '<meta name="viewport" content="width=device-width, initial-scale=1">'
            '<meta name="x-apple-disable-message-reformatting"><style>\n%s%s\n</style>'
            '<title>Jaseci Digest · Issue N.%s</title></head>' % (css, INTER, issue_no));
    open_ = ('<body style="margin:0;padding:0;background:#e6e0d4;-webkit-text-size-adjust:100%;'
             "font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             '<table role="presentation" width="100%" cellpadding="0" cellspacing="0" border="0" '
             "style=\"background:#e6e0d4;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             '<tr><td align="center" style="padding:24px 12px;">'
             '<table role="presentation" width="600" cellpadding="0" cellspacing="0" border="0" '
             "style=\"width:600px;max-width:600px;background:#ffffff;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">"
             "<tr><td style=\"font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;\">");
    close = "</td></tr></table></td></tr></table></body></html>";
    return head + open_ + body + close;
}


def:priv build_preview(body: str, head_css: str) -> str {
    css = head_css if head_css else FONT_IMPORT;
    head = ('<!DOCTYPE html><html><head><meta charset="utf-8"><style>\n%s%s\n</style>'
            "<style>body{margin:0;background:#cfc8ba;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;}"
            ".wrap{max-width:600px;margin:24px auto;background:#ffffff;padding:0 0 8px;font-family:'Inter','Helvetica Neue',Arial,sans-serif;color:#1f160e;}"
            ".wrap h2{font-size:22px;text-transform:uppercase;margin:32px 24px 12px;padding-top:18px;}"
            ".wrap h3{font-size:17px;margin:20px 24px 6px;}.wrap h3 a{color:#160f0a;text-decoration:none;}"
            ".wrap p,.wrap ul{margin:10px 24px;font-size:15px;line-height:1.55;}.wrap a{color:#c0531f;}</style></head>" % (css, INTER));
    return head + '<body><div class="wrap">' + body + "</div></body></html>";
}


def:priv localize_images(html: str) -> str {
    # Previews load images from the local repo so not-yet-deployed assets
    # (public/ mirrors the deployed site root) still show up. Only <img src>
    # is rewritten; links keep pointing at the live site.
    return re.sub(r'src="https://newsletter\.jaseci\.org/', 'src="../public/', html);
}


"""Render one stem to its two HTML siblings. Returns a status line."""
def:pub render(stem: str) -> str {
    # Issue number for the <title>: leading digits of the stem, else 03.
    # `0*(\d+)` matches exactly when the stem starts with a digit, so narrowing
    # on the match is equivalent to the Python original's separate `\d` guard.
    lead = re.`match(r"0*(\d+)", stem);
    issue_no = lead.group(1).zfill(2) if lead else "03";
    # 003 keeps its "-preview" sibling name; numeric-only stems use "NNN-preview".
    preview_stem = "%s-preview" % stem.split("-")[0];

    src = HERE / ("%s.md" % stem);
    source = src.read_text(encoding="utf-8");
    # The leading <style> block is hoisted into <head>; the rest is the body.
    split = split_head_css(source);
    head_css = split[0];
    body_src = split[1];

    email_out = HERE / ("%s.html" % stem);
    preview_out = HERE / ("%s.html" % preview_stem);
    email_out.write_text(
        localize_images(build_email(render_body(body_src, "email"), issue_no, head_css)),
        encoding="utf-8"
    );
    preview_out.write_text(
        localize_images(build_preview(render_body(body_src, "preview"), head_css)),
        encoding="utf-8"
    );
    return "regenerated %s and %s from %s" % (email_out.name, preview_out.name, src.name);
}


with entry:__main__ {
    print(render(sys.argv[1] if len(sys.argv) > 1 else "003-agentic-ai-with-jac"));
}
