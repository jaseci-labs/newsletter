sv import from ..main { Subscribe, GetIssues }

cl import from "@jac/runtime" { Link }

cl {
    def:pub page() -> JsxElement {
        has email: str = "";
        has status_message: str = "";
        has status_kind: str = "";
        has submitting: bool = False;
        has issues: list = [];

        async can with entry {
            try {
                result = root spawn GetIssues();
                if result.reports and len(result.reports) > 0 {
                    issues = result.reports[0]["issues"];
                }
            } except Exception {
                # Silent fail — page still works without latest-issue card
            }
        }

        async def handle_submit(event: any) -> None {
            event.preventDefault();
            status_message = "";
            status_kind = "";
            addr = email.strip();
            if not addr {
                status_message = "Please enter your email address.";
                status_kind = "error";
                return;
            }
            submitting = True;
            try {
                result = root spawn Subscribe(email=addr);
                data: any = {};
                if result.reports and len(result.reports) > 0 {
                    data = result.reports[0];
                }
                if data["ok"] {
                    if data["alreadySubscribed"] {
                        status_message = "You're already on the list. See you Tuesday.";
                    } else {
                        status_message = "You're in. The next issue lands on Tuesday.";
                    }
                    status_kind = "success";
                    email = "";
                } else {
                    status_message = str(data["error"]);
                    status_kind = "error";
                }
            } except Exception {
                status_message = "Network error. Check your connection and try again.";
                status_kind = "error";
            }
            submitting = False;
        }

        latest = issues[0] if len(issues) > 0 else None;
        previous = issues[1:4] if len(issues) > 1 else [];

        return <>
            <section className="hero">
                <p className="eyebrow">A biweekly digest · Jaseci & Jac</p>
                <h1 className="display">Build with Jac.<br />Stay in the loop.</h1>
                <p className="lede">
                    Releases, articles, talks, and community highlights from the Jaseci open-source
                    ecosystem, delivered to your inbox every other Tuesday.
                </p>
            </section>

            <section id="subscribe">
                <form className="subscribe" onSubmit={handle_submit} noValidate>
                    <label className="eyebrow" htmlFor="bd-email">
                        Subscribe. Biweekly, free, no spam.
                    </label>
                    <div className="row">
                        <input
                            id="bd-email"
                            type="email"
                            name="email"
                            placeholder="you@example.com"
                            autoComplete="email"
                            required
                            value={email}
                            onChange={lambda e: any -> None { email = e.target.value; }}
                        />
                        <button type="submit" className="cta-pill" disabled={submitting}>
                            {submitting and "Subscribing…" or "Subscribe"}
                        </button>
                    </div>
                    <p className="small muted form-help">
                        By subscribing you'll receive Jaseci Digest every other Tuesday. Unsubscribe anytime.
                    </p>
                    {status_message and (
                        <p className="form-status" data-kind={status_kind}>{status_message}</p>
                    )}
                </form>
            </section>

            {latest and (
                <section className="latest">
                    <p className="eyebrow">Latest issue</p>
                    <h2 className="section-heading">
                        <Link to={f"/issues/{latest['slug']}"}>{latest["title"]}</Link>
                    </h2>
                    <p className="muted">
                        Issue N.{str(latest["number"]).rjust(2, "0")} · {latest["date_long"]}
                    </p>
                    <p>{latest["description"]}</p>
                    <p>
                        <Link className="cta-pill" to={f"/issues/{latest['slug']}"}>
                            Read issue N.{str(latest["number"]).rjust(2, "0")}
                        </Link>
                    </p>
                </section>
            )}

            {len(previous) > 0 and (
                <section className="archive-teaser">
                    <p className="eyebrow">Previous issues</p>
                    <ul className="issue-list">
                        {[
                            <li key={issue["slug"]}>
                                <Link to={f"/issues/{issue['slug']}"}>
                                    <span className="issue-num">N.{str(issue["number"]).rjust(2, "0")}</span>
                                    <span className="issue-title">{issue["title"]}</span>
                                    <span className="issue-date muted">{issue["date_long"]}</span>
                                </Link>
                            </li>
                            for issue in previous
                        ]}
                    </ul>
                    <p><Link to="/issues">See all issues →</Link></p>
                </section>
            )}
        </>;
    }
}
