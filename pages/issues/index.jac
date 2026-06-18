sv import from ..main { GetIssues }

cl import from "@jac/runtime" { Link }

cl {
    def:pub page() -> JsxElement {
        can with entry {
            document.title = "All issues · Jaseci Digest";
        }

        has loading: bool = True;
        has issues: list = [];
        has error: str = "";

        async can with entry {
            try {
                result = root spawn GetIssues();
                if result.reports and len(result.reports) > 0 {
                    data = result.reports[0];
                    issues = data["issues"];
                } else {
                    error = "No response from server.";
                }
            } except Exception {
                error = "Network error.";
            }
            loading = False;
        }

        return <section className="archive">
            <p className="eyebrow">Archive</p>
            <h1 className="display">All issues.</h1>
            <p className="muted archive-lede">
                Every Jaseci Digest since the first. New issues land every two weeks.
            </p>

            {loading and <p className="muted">Loading…</p>}
            {error and <p className="form-status" data-kind="error">{error}</p>}

            {(not loading) and (not error) and (len(issues) == 0) and (
                <p className="muted">No issues published yet. Check back soon.</p>
            )}

            {(not loading) and (not error) and (len(issues) > 0) and (
                <ul className="issue-list issue-list--archive">
                    {[
                        <li key={issue["slug"]}>
                            <Link to={f"/issues/{issue['slug']}"}>
                                <span className="issue-num">N.{str(issue["number"]).rjust(2, "0")}</span>
                                <span className="issue-meta-block">
                                    <span className="issue-title">{issue["title"]}</span>
                                    <span className="issue-description muted">{issue["description"]}</span>
                                </span>
                                <span className="issue-date muted">{issue["date_long"]}</span>
                            </Link>
                        </li>
                        for issue in issues
                    ]}
                </ul>
            )}
        </section>;
    }
}
