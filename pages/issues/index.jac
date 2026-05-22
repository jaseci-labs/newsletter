sv import from ..main { GetIssues }

cl import from "@jac/runtime" { Link }

cl {
    def:pub page() -> JsxElement {
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

        return <article className="issues-list-page">
            <p className="eyebrow">All issues</p>
            <h1 className="display">The archive.</h1>
            <p className="muted">
                Every Jaseci Digest since the first. New issues land every other Thursday.
            </p>

            {loading and <p className="muted">Loading…</p>}
            {error and <p className="form-status" data-kind="error">{error}</p>}

            {(not loading) and (not error) and (
                <ul className="issue-list">
                    {[
                        <li key={issue["slug"]}>
                            <Link to={f"/issues/{issue['slug']}"}>
                                <span className="issue-num">N.{str(issue["number"]).rjust(2, "0")}</span>
                                <span className="issue-title">{issue["title"]}</span>
                                <span className="issue-date muted">{issue["date"]}</span>
                            </Link>
                        </li>
                        for issue in issues
                    ]}
                </ul>
            )}
        </article>;
    }
}
