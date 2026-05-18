---
number: 2
title: Issue title here
date: 2026-05-29
description: One-sentence description shown in SEO + archive list + footer tagline.
draft: true
---

<!--
ISSUE TEMPLATE. Duplicate this file and rename to NNN-slug.md (e.g. 002-foo-bar.md).
Remove `draft: true` when ready to publish.

STRUCTURE (modeled on nextjsweekly.com, scannable, link-driven, biweekly):
  1. Intro (2-column with optional hero image, OR a single paragraph)
  2. Optional arrow-circle pull-quote. Only for issues with a strong lead thesis
  3. ## Featured        ← 1-2 lead items, each with a longer 2-3 sentence blurb
  4. ## Built with Jac  ← 2-3 community-built projects worth showing off; OR a single link to the gallery (https://www.jaseci.org/built-with-jaseci) if nothing new this fortnight
  5. ## Articles        ← 3-4 items: long-form community posts, deep dives
  6. ## Community       ← 3-4 items: talks, RFCs, Discord highlights, events
  7. ## Tools & libraries  ← 3-4 items: small things worth knowing about
  8. ## Releases        ← 3-4 items: shipped versions, changelogs, hosted releases (reference-y, near the bottom)
  9. Closing            ← one short paragraph + the big CTA pill

PER-ITEM FORMAT (used in every section):
  ### [Title of the thing](https://link)
  One or two sentences. Why does this matter? Why should the reader click?

Internal long-form pieces live in src/content/articles/. To publish a deep-dive
alongside an issue:
  - Create src/content/articles/<slug>.md (see build-with-jac.md as a model)
  - From this issue, link to it: ### [Title](/articles/<slug>)
  - Articles are NOT listed on /issues. They're only reachable via direct link.

Sections can be omitted if you have nothing in them. Don't leave empty headings.
Drop new images into public/issues/NNN/ if you want them.
-->

<!-- Optional intro grid (text left, image right) - delete if you don't have a hero image -->
<div class="intro-grid">
<div>

Welcome to **Issue N.02** of Jaseci Digest.

Short framing paragraph that covers the theme of this issue, or the one thing readers should take away. Two or three sentences max.

</div>
<figure>
  <img src="/issues/002/hero.svg" alt="Describe the hero image." />
</figure>
</div>

<!-- Optional pull-quote. Use sparingly, only when the issue has a single thesis -->
<!--
<a class="arrow-cta" href="https://www.jaseci.org" target="_blank" rel="noopener">
  <span class="arrow-cta__icon" aria-hidden="true">
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M5 12 H19 M13 6 L19 12 L13 18" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </span>
  <span class="arrow-cta__text">
    The one-line thesis of this issue, in 12-25 words.
  </span>
</a>
-->

## Featured

### [Title of the lead piece](https://example.com)

Why this matters in 2 to 3 sentences. Featured items get a slightly longer blurb than other sections. Set the context, then let the reader click through.

### [Optional second feature](https://example.com)

Same shape. Skip if there's only one lead this fortnight.

## Built with Jac

### [Project name](https://project-link.example.com)

One or two sentences. What is the project, what does it use Jac for (walkers? `by llm()`? graph state?), and why is it worth a click.

### [Another project](https://project-link.example.com)

Same shape. 2-3 items max per issue. If nothing new this fortnight, replace this section with a single item linking to https://www.jaseci.org/built-with-jaseci as a "browse the gallery" pointer.

## Articles

### [Article title](https://example.com)

One-line context + why it's worth reading.

### [Another article](https://example.com)

Same shape.

## Community

### [Talk or blog post](https://example.com)

Who, where, what stood out.

### [RFC or proposal](https://example.com)

What's being proposed and when comments close.

### [Upcoming event](https://example.com)

When, where, link to register or learn more.

## Tools & libraries

### [Library name](https://example.com)

What it does in one sentence.

### [Another library](https://example.com)

Same.

## Releases

### [Project name vX.Y: what shipped](https://example.com)

One or two sentences. Headline the breaking changes or the big new capability.

### [Another release](https://example.com)

What's new, what to watch out for.

## Closing

A short sign-off. Mention what to expect next issue, ask for replies or tips, link to Discord.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
