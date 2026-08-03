"""404 catch-all."""

import from "@jac/runtime" { Link }


def:pub page() -> JsxPage {
    return
        <section className="not-found">
            <p className="eyebrow">404</p>
            <h1 className="display">Not found.</h1>
            <p>
                The page you're looking for doesn't exist. Try the{" "}
                <Link to="/issues">archive</Link>
                .
            </p>
        </section>;
}
