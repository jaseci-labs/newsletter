cl import "../styles/main.css";
cl import from "@jac/runtime" { Outlet, Link }

cl {
    def:pub layout() -> JsxElement {
        return <>
            <header className="site-header">
                <div className="container">
                    <div className="brand-row">
                        <Link to="/" className="brand">
                            <img src="/logo.png" alt="" width={28} height={28} className="brand-logo" />
                            <span className="brand-text">Jaseci Digest</span>
                        </Link>
                    </div>
                    <nav aria-label="Primary">
                        <ul>
                            <li><Link to="/issues">Issues</Link></li>
                            <li><a href="/#subscribe">Subscribe</a></li>
                            <li><Link to="/about">About</Link></li>
                            <li><a href="https://www.jaseci.org" target="_blank" rel="noopener">Jaseci.org</a></li>
                        </ul>
                    </nav>
                    <hr className="header-rule" />
                </div>
            </header>

            <main className="container">
                <Outlet />
            </main>

            <footer className="site-footer">
                <div className="container footer-grid">
                    <div className="footer-col footer-col--left">
                        <a href="https://www.jaseci.org" target="_blank" rel="noopener">WWW.JASECI.ORG</a>
                    </div>
                    <div className="footer-col footer-col--center"></div>
                    <div className="footer-col footer-col--right">
                        <Link to="/">
                            <img src="/logo.png" alt="Jaseci" width={40} height={40} className="footer-logo" />
                        </Link>
                    </div>
                </div>
            </footer>
        </>;
    }
}
