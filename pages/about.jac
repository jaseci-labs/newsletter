sv import from ..main { Subscribe }

cl {
    def:pub page() -> JsxElement {
        can with entry {
            document.title = "About · Jaseci Digest";
        }

        has email: str = "";
        has status_message: str = "";
        has status_kind: str = "";
        has submitting: bool = False;

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

        return <article className="about">
            <p className="eyebrow">About</p>
            <h1 className="display">A biweekly window<br />into Jaseci & Jac.</h1>
            <p>
                <strong>Jaseci Digest</strong> is a community newsletter for everyone building with
                {" "}<a href="https://www.jaseci.org" target="_blank" rel="noopener">Jaseci</a> and the
                {" "}<a href="https://docs.jaseci.org/quick-guide/" target="_blank" rel="noopener">Jac</a> programming language,
                an AI-native, graph-shaped stack from the Jaseci open-source ecosystem.
            </p>
            <p>
                Every other Wednesday we publish a short digest of what shipped, what was written,
                and what's worth your attention from across the ecosystem. Short, scannable, no fluff.
            </p>
            <h2 className="section-heading">What's inside.</h2>
            <ul>
                <li><strong>Featured:</strong> the story of the fortnight, often with a deep-dive article alongside.</li>
                <li><strong>Built with Jac:</strong> community projects shipping on the stack.</li>
                <li><strong>Articles:</strong> long-form posts and deep dives from across the community.</li>
                <li><strong>Community:</strong> talks, RFCs, Discord highlights, JacHacks notes, jobs.</li>
                <li><strong>Tools &amp; libraries:</strong> packages, plugins, and CLI utilities worth knowing about.</li>
                <li><strong>Releases:</strong> what shipped across jaclang, byllm, jac-client, jac-scale, jac-super, jac-mcp, and jaseci.</li>
            </ul>

            <form className="subscribe" onSubmit={handle_submit} noValidate>
                <label className="eyebrow" htmlFor="bd-email-about">
                    Subscribe. Biweekly, free, no spam.
                </label>
                <div className="row">
                    <input
                        id="bd-email-about"
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
        </article>;
    }
}
