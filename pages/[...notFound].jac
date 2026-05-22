"""404 catch-all."""

cl import from "@jac/runtime" { Link }

cl {
    def:pub page() -> JsxElement {
        return <section className="not-found">
            <p className="eyebrow">404</p>
            <h1 className="display">Not found.</h1>
            <p>The page you're looking for doesn't exist. Try the <Link to="/issues">archive</Link>.</p>
        </section>;
    }
}
