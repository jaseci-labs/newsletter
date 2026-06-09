---
number: 2
title: The roundup
date: 2026-06-10
description: A look at Jac Hammer, the studio that turns a prompt into a real Jac app, plus the JacHacks Spring winners.
draft: false
---

Welcome to **Issue N.02** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

This week's lead is **[Jac Hammer](https://jachammer.ai/)**, a studio that turns a prompt into a real, full-stack app. Where Lovable hands you a frontend and a separate backend to wire up, Jac Hammer builds the database, authentication, and AI natively in Jac and deploys it all in one click.

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
.issue-body .feat-table-lead { margin:1.75rem 0 0.6rem; }
.issue-body .feat-table { width:100%; table-layout:fixed; border-collapse:separate; border-spacing:0; margin:0.5rem 0 1.5rem; font-size:0.97rem; line-height:1.45; border:1px solid var(--rule-soft); border-radius:12px; overflow:hidden; box-shadow:0 2px 14px -8px rgba(31,22,14,0.22); }
.issue-body .feat-table th, .issue-body .feat-table td { padding:0.85rem 1rem; text-align:left; vertical-align:top; }
.issue-body .feat-table thead th { font-weight:700; font-size:0.95rem; }
.issue-body .feat-table thead th:first-child { width:24%; background:var(--bg-soft); }
.issue-body .feat-table thead th.jh { width:38%; background:var(--accent); color:var(--bg); }
.issue-body .feat-table thead th.lv { width:38%; background:var(--bg-soft); color:var(--text-muted); }
.issue-body .feat-table .row-label { font-weight:600; color:var(--text-heading); }
.issue-body .feat-table td.jh { font-weight:600; color:var(--text-heading); background:rgba(217,122,44,0.13); }
.issue-body .feat-table td.jh::before { content:"\2713\00a0\00a0"; color:var(--accent); font-weight:700; }
.issue-body .feat-table td.lv { color:var(--text-muted); }
.issue-body .feat-table tbody tr:not(:last-child) td { border-bottom:1px solid var(--rule-soft); }
.issue-body .feat-table code { font-size:0.85em; }
.issue-body .feat-question { font-size:clamp(1rem,1.9vw,1.2rem); font-weight:700; line-height:1.4; letter-spacing:-0.01em; color:var(--text-heading); margin:1.75rem 0 0.75rem; }
.issue-body .feat-question .hl { color:var(--accent); }
.issue-body .feat-vs { width:100%; border-collapse:separate; border-spacing:0 0.85rem; margin:1rem 0 1.5rem; }
.issue-body .feat-vs-card { padding:1rem 1.25rem; border-radius:12px; line-height:1.5; font-size:1rem; }
.issue-body .feat-vs-card .vs-label { display:block; font-weight:700; font-size:0.78rem; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:0.35rem; }
.issue-body .feat-vs-card.lovable { background:var(--bg-soft); border:1px solid var(--rule-soft); color:var(--text-muted); }
.issue-body .feat-vs-card.lovable .vs-label { color:var(--text-muted); }
.issue-body .feat-vs-card.jachammer { background:rgba(217,122,44,0.09); border:1px solid var(--accent); border-left:5px solid var(--accent); color:var(--text); }
.issue-body .feat-vs-card.jachammer .vs-label { color:var(--accent); }
.issue-body .feat-vs-card.jachammer b { color:var(--text-heading); }
</style>

<a class="feat-hero" href="/articles/jac-builder">Jac Hammer: an AI app studio that builds in Jac</a>

<figure class="video-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;margin:1.5rem 0 2rem;border-radius:10px;">
  <iframe style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;" src="https://www.youtube.com/embed/48_MlEfci_M" title="Jac Hammer demo" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</figure>

<p class="feat-question">What if one prompt gave you a <span class="hl">real, full-stack app</span> with authentication and a database, that you <span class="hl">deploy frontend and backend in one click</span> and scale to millions?</p>

<table class="feat-vs">
<tr><td class="feat-vs-card lovable"><span class="vs-label">&#10007;&nbsp; With Lovable</span>Real authentication, a database, and a backend mean an external backend service like Supabase to set up and run, leaving you to wrestle two services into one working deployment.</td></tr>
<tr><td class="feat-vs-card jachammer"><span class="vs-label">&#10003;&nbsp; With Jac Hammer</span><b>It builds in Jac, a language where one-click deployment, the database, authentication, backend, and AI are all native.</b> Nothing to bolt on. Describe the app, and ship it. A real app, not a demo.</td></tr>
</table>

<p class="feat-table-lead"><b>Jac Hammer vs Lovable.</b> The differences that actually matter.</p>

<table class="feat-table">
  <thead>
    <tr><th></th><th class="jh">Jac Hammer</th><th class="lv">Lovable</th></tr>
  </thead>
  <tbody>
    <tr><td class="row-label">Languages to juggle</td><td class="jh">Just Jac</td><td class="lv">React, TypeScript, SQL, and more</td></tr>
    <tr><td class="row-label">Deployment</td><td class="jh">Frontend and backend, one click, one deployment</td><td class="lv">Only the frontend; Supabase backend deployed separately</td></tr>
    <tr><td class="row-label">Database</td><td class="jh">Native to Jac</td><td class="lv">A separate Postgres database on Supabase</td></tr>
    <tr><td class="row-label">Authentication</td><td class="jh">Native to Jac</td><td class="lv">Added through Supabase</td></tr>
    <tr><td class="row-label">Build for</td><td class="jh">Web, mobile, and desktop apps</td><td class="lv">Web apps only</td></tr>
    <tr><td class="row-label">AI in your app</td><td class="jh">Native to Jac, no prompts (byLLM)</td><td class="lv">Wire up AI SDKs, APIs, and prompts</td></tr>
  </tbody>
</table>

<div class="feat-try-wrap">
  <a class="feat-try" href="https://jachammer.ai/" target="_blank" rel="noopener">Try Jac Hammer &rarr;</a>
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

### [Join the Jaseci Discord](https://discord.com/invite/6j3QNdtcN6)

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
