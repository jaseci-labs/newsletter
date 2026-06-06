sv import from ...main { GetArticle }

cl import from "@jac/runtime" { useParams, Link }

cl {
    def:pub page() -> JsxElement {
        params = useParams();
        slug = params["slug"];

        has loading: bool = True;
        has article: any = None;
        has error: str = "";

        async can with [slug] entry {
            loading = True;
            error = "";
            article = None;
            try {
                result = root spawn GetArticle(slug=str(slug));
                if result.reports and len(result.reports) > 0 {
                    data = result.reports[0];
                    if data["ok"] {
                        article = data;
                        document.title = f"{data['title']} · Jaseci Digest";
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

        return <article className="issue">
            <header className="issue-header">
                <div className="issue-meta">
                    <span className="eyebrow">{article["eyebrow"]}</span>
                </div>
                <div className="issue-title-block">
                    <h1 className="display" style={{"fontSize": "clamp(1.5rem, 3.4vw, 2.5rem)"}}>{article["title"]}</h1>
                </div>
            </header>

            <div className="issue-body" dangerouslySetInnerHTML={{"__html": article["html"]}} />

            <nav className="issue-nav">
                <Link to="/issues">← Back to all issues</Link>
            </nav>
        </article>;
    }
}
