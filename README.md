# Jaseci Digest

A biweekly newsletter for the [Jaseci](https://www.jaseci.org) and Jac open-source ecosystem. This repo is both the **public archive site** (Jac) and the **source of truth for issue content** (markdown files). Emails are delivered via [Buttondown](https://buttondown.com).

The visual design follows the team's editorial template — cream background, all-caps display headings, numbered sections, hexagon "J" mark.

---

## Quick start

```bash
# resolve [dependencies] and [dependencies.npm] into .jac/
jac install

# run the dev server
#   jac 0.35.x (the pinned/deploy version):  jac start
#   jac 0.37+ (start/dev were folded in):    jac run --serve main.jac
jac start

# type-check the sources
jac check main.jac
```

> The site is a Jac app end to end: `main.jac` is the server entry and `pages/` holds the
> client routes. See `.github/workflows/deploy.yml` for the jac-scale deploy pipeline.

---

## Project layout

```
main.jac                      ← server entry: Subscribe walker + issue/article endpoints
jac_syntax_highlighter.jac    ← Pygments lexer for Jac, registered for codehilite
pages/                        ← client routes
├── layout.jac                ← base layout, imports styles/main.css
├── index.jac                 ← landing + latest issue + subscribe
├── about.jac
├── [...notFound].jac
├── articles/[slug].jac
└── issues/
    ├── index.jac             ← all-issues archive
    └── [slug].jac            ← individual issue page
src/content/                  ← source of truth for content (read by main.jac)
├── issues/
│   ├── _template.md          ← copy this to start a new issue
│   └── 001-build-with-jac.md
└── articles/
styles/
└── main.css                  ← design tokens + typography
email/                        ← Buttondown sources (NNN-*.md) + generated previews
tools/
└── render_previews.jac       ← regenerates the email/*.html previews
```

> `tools/render_previews.jac` lives outside `email/` deliberately. A `.jac` file inside a
> directory named `email/` makes Jac register it as a package called `email`, shadowing the
> Python stdlib package and breaking every `jac` command with
> `ModuleNotFoundError: No module named 'email.utils'`.

---

## Publishing a new issue

1. Copy `src/content/issues/_template.md` to a new file: `NNN-slug.md` (e.g. `002-jaclang-release.md`).
2. Update frontmatter:
   - `number` — incrementing issue number
   - `title` — short, sentence case
   - `date` — publish date (YYYY-MM-DD)
   - `description` — one sentence; used for SEO, archive list, and footer tagline
   - `draft: false` — flip from `true` when ready to publish
3. Write the body in markdown. Use `## Heading.` for major sections (rendered uppercase). Use `### 1. Heading.` for numbered subsections.
4. Commit and push. The site rebuilds on deploy.
5. Send the email via Buttondown — see below.

### Issue structure (recommended)

Modeled on nextjsweekly / dspyweekly — scannable, link-driven, easy to fill biweekly. Every issue is a stack of short sections; every item inside a section is `### [Title](link)` + 1–2 sentence blurb.

1. **Intro** — 2-column block with optional hero image, or a single short paragraph.
2. **(Optional) Pull-quote** — orange arrow-circle CTA. Use only when the issue has a single strong thesis.
3. **Featured** — 1–2 lead items with 2–3 sentence blurbs.
4. **Built with Jac** — 2–3 community-built projects worth showing off, or a single link to the official gallery at <https://www.jaseci.org/built-with-jaseci> if nothing new this fortnight.
5. **Articles** — 3–4 items: community long-form, deep dives.
6. **Community** — 3–4 items: talks, RFCs, Discord highlights, upcoming events.
7. **Tools & libraries** — 3–4 items: small things worth knowing about.
8. **Releases** — 3–4 items: shipped versions, changelogs (reference-y, lives near the bottom).
9. **Closing** — short sign-off + the big CTA pill at the bottom.

Skip any section that has nothing in it — don't ship empty headings. Look at [`src/content/issues/001-build-with-jac.md`](src/content/issues/001-build-with-jac.md) for a fully filled example and [`_template.md`](src/content/issues/_template.md) for the empty skeleton you copy from.

**Image assets** — drop per-issue images under `public/issues/NNN/` (matching the issue number). Reference them from the markdown as `/issues/NNN/whatever.svg`. The build serves `public/` at the root.

---

## Sending via Buttondown

The site embeds Buttondown's hosted subscribe form (no API key needed) — set `PUBLIC_BUTTONDOWN_USERNAME` in `.env` to your Buttondown username (default placeholder is `jaseci`).

To send an issue:

**Option A — manual (recommended at the start):**

1. Open the published issue page on the live site.
2. Copy the rendered HTML or paste the markdown into Buttondown's editor.
3. Schedule the send for Thursday morning.

**Option B — RSS-to-email (automation):**

Buttondown can watch this site's RSS feed (`/rss.xml`) and auto-draft an email whenever a new issue is published. Configure under Buttondown → Settings → Automations → RSS-to-email.

**Option C — API (future):**

`BUTTONDOWN_API_KEY` is also used by the live subscribe endpoint (see below). Programmatic sending of issues is not implemented yet.

---

## Subscribe flow (single opt-in)

This site uses **single opt-in** — subscribers are activated immediately, no confirmation email.

- The form posts to `/api/subscribe` (a server route on this app).
- That route forwards the email to Buttondown's authenticated API
  (`POST https://api.buttondown.email/v1/subscribers`) with `type: "regular"`, which
  bypasses the default double opt-in confirmation flow.
- The API key lives **server-side only** (`BUTTONDOWN_API_KEY` env var) — it is never
  shipped to the browser.

This means the app is not purely static — it needs a server runtime (which is why we
deploy onto EKS via jac-scale rather than shipping static files). The endpoint is the
`Subscribe` walker in `main.jac`, exposed as a REST route by jac-scale.

### Spam exposure

Skipping double opt-in means a bot could subscribe arbitrary emails. We intentionally
ship v1 without any anti-bot protection per the team's call ("we'll handle manually if
it becomes a problem"). When you need to add it later, the easy upgrade path is:

1. **Honeypot** field — invisible input most bots fill in; reject server-side.
2. **Rate limit** per IP on `/api/subscribe`.
3. **Cloudflare Turnstile** — invisible CAPTCHA, free, ~10 lines to integrate.

---

## Environment variables

Copy `.env.example` to `.env` and fill in:

```bash
PUBLIC_SITE_URL=https://jasecidigest.com
PUBLIC_BUTTONDOWN_USERNAME=jaseci
BUTTONDOWN_API_KEY=                # required: single opt-in needs the API
```

`PUBLIC_*` vars are exposed to the browser. The API key is server-side only and is **never** referenced in client code. Generate the key at <https://buttondown.com/settings/programming>.

---

## Deployment (EKS / Kubernetes)

The site runs as a Jac server on EKS, not as static files (because the subscribe endpoint
needs a runtime). Pushing to `main` triggers
[`.github/workflows/deploy.yml`](./.github/workflows/deploy.yml), which installs the jac
toolchain and runs `jac start --scale`. There is no container build and no Node runtime;
the jac binary is shipped to the pods over the bundle PVC.

**Quick local sanity check before pushing:**

```bash
jac check main.jac
jac start
```

**Kubernetes manifest:** [`deploy/k8s.yaml`](./deploy/k8s.yaml) — Namespace, Deployment
(2 replicas, non-root, read-only root FS), Service, and Ingress. Edit before applying:

1. Replace `image: REPLACE_ME/jaseci-digest:latest` with your ECR URI and tag.
2. Create the secret: `kubectl create secret generic jaseci-digest-secrets -n jaseci-digest --from-literal=BUTTONDOWN_API_KEY=...` (or wire it from AWS Secrets Manager via External Secrets Operator — recommended).
3. Set `host:` on the Ingress to your real domain and adjust the annotations to match your ingress controller (ALB, NGINX, etc.) and TLS issuer.
4. `kubectl apply -f deploy/k8s.yaml`.

**If you'd rather skip the backend** and lose single opt-in: swap the subscribe form back
to Buttondown's embed endpoint and deploy the built client to any static host. Single
opt-in is the only reason this needs a server.

---

## Design notes

- The aesthetic intentionally matches the team's print-style template (cream + black, all-caps display type, numbered sections, hexagon "J" mark).
- Don't introduce gradients, drop shadows, or modern flourishes — the system is flat and editorial.
- Body copy is left-aligned on the web for readability; the template's justified columns are a print-only choice.
- Inter is loaded from rsms.me/inter; swap in a self-hosted or paid display font if/when one is finalized.

---

## License

Content © Jaseci Labs and contributors. Code MIT.
