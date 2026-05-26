sv import from ...main { GetIssue, Subscribe }

cl import from "@jac/runtime" { useParams, Link }

cl {
    def:pub page() -> JsxElement {
        params = useParams();
        slug = params["slug"];

        has loading: bool = True;
        has issue: any = None;
        has error: str = "";

        has email: str = "";
        has status_message: str = "";
        has status_kind: str = "";
        has submitting: bool = False;

        async can with [slug] entry {
            loading = True;
            error = "";
            issue = None;
            try {
                result = root spawn GetIssue(slug=str(slug));
                if result.reports and len(result.reports) > 0 {
                    data = result.reports[0];
                    if data["ok"] {
                        issue = data;
                        padded = str(data["number"]).rjust(2, "0");
                        document.title = f"{data['title']} · Jaseci Digest Issue N.{padded}";
                    } else {
                        error = str(data["error"]);
                    }
                } else {
                    error = "No response from server.";
                }
            } except Exception {
                error = "Network error.";
            }
            loading = False;
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
                        status_message = "You're already on the list. See you Wednesday.";
                    } else {
                        status_message = "You're in. The next issue lands on Wednesday.";
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

        if loading {
            return <article className="issue"><p className="muted">Loading…</p></article>;
        }
        if error {
            return <article className="issue">
                <p className="eyebrow">Error</p>
                <h1 className="display">{error}</h1>
                <p><Link className="cta-pill" to="/issues">Back to archive</Link></p>
            </article>;
        }

        padded = str(issue["number"]).rjust(2, "0");

        return <article className="issue">
            <header className="issue-header">
                <div className="issue-meta">
                    <span className="issue-date">{issue["date_formatted"]}</span>
                </div>
                <div className="issue-title-block">
                    <p className="eyebrow">Jaseci Digest</p>
                    <h1 className="display">N.{padded}</h1>
                    <p className="sr-only">{issue["title"]}</p>
                    <p className="issue-description">{issue["description"]}</p>
                </div>
            </header>

            <div className="issue-body" dangerouslySetInnerHTML={{"__html": issue["html"]}} />

            <hr />

            <section className="issue-subscribe" id="subscribe">
                <h2 className="section-heading">Get the next one in your inbox</h2>
                <form className="subscribe" onSubmit={handle_submit} noValidate>
                    <label className="eyebrow" htmlFor="bd-email-issue">
                        Subscribe. Biweekly, free, no spam.
                    </label>
                    <div className="row">
                        <input
                            id="bd-email-issue"
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
                        By subscribing you'll receive Jaseci Digest every other Wednesday. Unsubscribe anytime.
                    </p>
                    {status_message and (
                        <p className="form-status" data-kind={status_kind}>{status_message}</p>
                    )}
                </form>
            </section>

            <nav className="issue-nav">
                <Link to="/issues">← All issues</Link>
            </nav>
        </article>;
    }
}
