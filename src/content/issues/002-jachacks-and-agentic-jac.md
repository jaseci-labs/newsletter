---
number: 2
title: The roundup
date: 2026-06-10
description: A look at Jac Builder, the studio that turns a prompt into a real Jac app, plus the JacHacks Spring winners.
draft: false
---

Welcome to **Issue N.02** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

This week's lead is **[Jac Builder](https://jac-builder.jaseci.org/)**, a studio that turns natural-language prompts into a working app. The twist: the code it writes is Jac, so you get one AI-native, full-stack codebase.

## Featured

<style>
.issue-body .feat-hero { display:block; margin:0.5rem 0 1.25rem; font-size:clamp(1.7rem,4.2vw,2.7rem); font-weight:700; line-height:1.08; letter-spacing:-0.02em; color:var(--text-heading); text-decoration:none; }
.issue-body .feat-hero:hover { color:var(--accent); }
.issue-body .feat-try-wrap { margin:1.75rem 0 0.5rem; }
.issue-body .feat-try { display:inline-block; padding:1rem 2.2rem; background:var(--accent); color:var(--bg); font-weight:700; font-size:1.05rem; letter-spacing:0.01em; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease, background 0.15s ease; }
.issue-body .feat-try:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(184,95,21,0.5); background:var(--accent-hover); }
.issue-body .feat-points { list-style:none; margin:1.5rem 0; padding:1.25rem 1.5rem; display:grid; gap:0.7rem; background:rgba(217,122,44,0.06); border-left:3px solid var(--accent); border-radius:8px; }
.issue-body .feat-points li { position:relative; padding-left:1.6rem; margin:0; line-height:1.45; }
.issue-body .feat-points li::before { content:"\2192"; position:absolute; left:0; top:0; color:var(--accent); font-weight:700; }
.issue-body .feat-points b { color:var(--text-heading); }
</style>

<a class="feat-hero" href="/articles/jac-builder">Jac Builder: an AI app studio that builds in Jac</a>

<figure class="video-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;margin:1.5rem 0 2rem;border-radius:10px;">
  <iframe style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;" src="https://www.youtube.com/embed/48_MlEfci_M" title="Jac Builder demo" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</figure>

<a class="arrow-cta" href="/articles/jac-builder">
  <span class="arrow-cta__icon" aria-hidden="true">
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M5 12 H19 M13 6 L19 12 L13 18" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </span>
  <span class="arrow-cta__text">
    Describe an app, watch it build, just like <em>Lovable, v0, or Bolt</em>. The twist: the code it writes is Jac, so you get <b>one clean, AI-native codebase</b> with <b>auth and a database built in</b> (no third-party service to wire up), and you can <b>deploy it live in one click</b>. We built the same app in both, and <b>Jac Builder got there about 3x faster</b>.
  </span>
</a>

<ul class="feat-points">
  <li><b>One language, not three.</b> Frontend, backend, and AI all live in Jac. Nothing to keep in sync by hand.</li>
  <li><b>Auth and database built in.</b> Native authentication and data storage come with the stack, no third-party service to wire up.</li>
  <li><b>AI built in.</b> Need an LLM call? Write <code>by llm()</code>. No prompt files, no schemas.</li>
  <li><b>Start from a template.</b> Begin from a real starter (full-stack with auth, a React client, live preview, or blank) and build on top.</li>
  <li><b>Deploy in one click.</b> From a sentence to a live app on the internet. No Dockerfiles, no CI, no infra.</li>
</ul>

<div class="feat-try-wrap">
  <a class="feat-try" href="https://jac-builder.jaseci.org/" target="_blank" rel="noopener">Try Jac Builder &rarr;</a>
</div>

## Articles

### [How Tobu used Jaseci to build an AI-powered memory graph](https://blogs.jaseci.org/blog/posts/tobu-memory-graph-case-study)

[Tobu](https://tobu.life/) is an AI memory app that captures the people, places, and stories behind your photos. It models each one as a connected memory on a Jac graph, not a file in a folder. The highlights:

- **2 weeks** to a working demo, **6 weeks** to production, **zero** prompt-engineering pipelines
- **92.84%** retrieval accuracy, **2.2x** fewer missed memories than traditional RAG
- **$1.5M** raised on the early traction

## Community

### [JacHacks Spring winners are live](https://jachacks.org/#spring-winners)

JacHacks Spring wrapped with more than 300 participants and 81 projects shipped in four days. Winners landed across Agentic AI, Consumer Healthcare, Fintech, and Social Impact, alongside specialty awards like Best Use of Jac and Best Demo. See them all on the [winners page](https://jachacks.org/#spring-winners), or [explore all 81 submitted projects on Devpost](https://jachacks-spring.devpost.com/project-gallery).

### [Join the Jaseci Discord](https://discord.gg/jaseci)

The fastest way to talk to the team and other builders. RFC chatter, debugging help, release questions, and a steady stream of show-and-tells. Worth joining whether you ship in production or are just curious.

## Releases

### [jaclang v0.16.0: Object-Spatial programs run client-side](https://docs.jaseci.org/community/release_notes/jaclang/)

`cl` code now runs full Object-Spatial programs in-process: walkers, nodes, and edge traversal execute locally, with no server round-trip. Native compilation also gains proper AMD64 and ARM64 struct ABIs, so `jac nacompile` produces working standalone binaries.

### [jac-desktop v0.1.1: a native desktop target for Jac](https://docs.jaseci.org/community/release_notes/jac-desktop/)

New plugin (`pip install jac-desktop`). Adds a PyTauri desktop build target (`jac build --client desktop`) and a Tauri plugin manager, so one Jac codebase now ships as a native desktop app too.

### [byllm v0.6.13: per-call system prompts](https://docs.jaseci.org/community/release_notes/byllm/)

`by llm()` now takes a `system_prompt` (a string or a callable) that extends the base prompt, so an agent's persona can be cached separately from the function's semantics.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
