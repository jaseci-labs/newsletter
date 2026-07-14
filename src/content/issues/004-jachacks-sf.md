---
number: 4
title: Built for builders
date: 2026-07-15
description: Two features this issue. JacHacks comes to San Francisco for the first time on July 26, and a tutorial on the new one-binary Jac toolchain.
draft: false
---

<!--
DRAFT scaffold for Issue N.04. The Featured section (JacHacks SF, promoted from
Issue N.03's Community section) is written. Unfinished sections are commented
out at the bottom so the preview only renders real content. Set `draft: true`
before committing if the issue isn't ready to publish. Images go in
public/issues/004/.
-->

Welcome to **Issue N.04** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

Two features this issue. First, JacHacks is coming to San Francisco on **July 26**, its first time in the city. Second, a tutorial on the new one-binary Jac toolchain that sets up your whole dev environment with a single download. Both below.

## Featured

<style>
.issue-body .feat-hero { display:block; margin:0 0 1.1rem; font-size:clamp(1.7rem,4.2vw,2.7rem); font-weight:700; line-height:1.08; letter-spacing:-0.02em; color:var(--text-heading); text-decoration:none; }
.issue-body .feat-hero:hover { color:var(--accent); }
.issue-body .feat-lede::first-letter { float:left; font-size:3.1em; line-height:0.82; font-weight:700; color:var(--accent); padding:0.08em 0.14em 0 0; }
.issue-body .news-img { display:block; margin:0.5rem 0 1.4rem; border-radius:12px; overflow:hidden; border:1px solid var(--rule-soft); box-shadow:0 12px 32px -16px rgba(31,22,14,0.45); transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .news-img:hover { transform:translateY(-2px); box-shadow:0 18px 40px -16px rgba(31,22,14,0.55); }
.issue-body .news-img img { display:block; width:100%; height:auto; margin:0; }
.issue-body .feat-try-wrap { margin:1.9rem 0 0.5rem; text-align:center; }
.issue-body .feat-try-wrap p { margin:0; text-align:center; }
.issue-body .feat-try { display:inline-block; padding:1rem 2.2rem; background:var(--accent); color:var(--bg); font-weight:700; font-size:1.05rem; letter-spacing:0.01em; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease, background 0.15s ease; }
.issue-body .feat-try:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(232,90,37,0.5); background:var(--accent-hover); }
.issue-body .feat-kicker { display:block; font-weight:700; font-size:0.75rem; text-transform:uppercase; letter-spacing:0.12em; color:var(--accent); margin:1.9rem 0 0.8rem; }
.issue-body .feat-callout { margin:1.5rem 0 1.75rem; padding:1rem 1.3rem; background:rgba(255,107,53,0.08); border:1px solid var(--accent); border-left:5px solid var(--accent); border-radius:12px; font-size:1.05rem; font-weight:500; line-height:1.55; color:var(--text-heading); }
.issue-body ul.feat-list { list-style:none; margin:0 0 1.6rem; padding:0; display:grid; grid-template-columns:1fr 1fr; gap:0.8rem; }
.issue-body ul.feat-list li { margin:0; display:flex; align-items:center; gap:0.9rem; padding:0.9rem 1.05rem; background:#faf6ec; border:1px solid var(--rule-soft); border-radius:12px; box-shadow:0 2px 10px -6px rgba(31,22,14,0.18); font-size:0.96rem; line-height:1.45; transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body ul.feat-list li:hover { transform:translateY(-2px); box-shadow:0 10px 24px -12px rgba(31,22,14,0.32); }
.issue-body ul.feat-list .fi { flex:none; width:38px; height:38px; border-radius:11px; background:var(--accent-soft); color:var(--accent); display:flex; align-items:center; justify-content:center; }
.issue-body ul.feat-list .fi svg { width:20px; height:20px; }
@media (max-width: 560px) { .issue-body ul.feat-list { grid-template-columns:1fr; } }
.issue-body .orn-divider { display:flex; align-items:center; justify-content:center; gap:0.55rem; margin:3.25rem auto 0; }
.issue-body .orn-divider::before, .issue-body .orn-divider::after { content:''; height:1px; width:min(8rem, 22vw); background:var(--rule-soft); }
.issue-body .orn-divider p { display:flex; align-items:center; gap:0.55rem; margin:0; }
.issue-body .orn-divider i { width:7px; height:7px; transform:rotate(45deg); background:var(--accent); display:block; flex:none; }
.issue-body .orn-divider i:nth-child(2) { background:var(--accent-2); }
.issue-body .term { margin:1.25rem 0 1.5rem; border-radius:12px; overflow:hidden; border:1px solid var(--rule-soft); background:var(--warm-dark); box-shadow:0 16px 34px -20px rgba(31,22,14,0.5); }
.issue-body .term-bar { padding:0.6rem 1.05rem; background:rgba(0,0,0,0.28); }
.issue-body .term-bar p { display:flex; align-items:center; gap:0.45rem; margin:0; }
.issue-body .term-bar i { width:11px; height:11px; border-radius:50%; display:block; flex:none; }
.issue-body .term-bar i:nth-child(1) { background:#ff5f56; }
.issue-body .term-bar i:nth-child(2) { background:#ffbd2e; }
.issue-body .term-bar i:nth-child(3) { background:#27c93f; }
.issue-body .term-bar span { margin-left:0.5rem; font-size:0.74rem; letter-spacing:0.04em; color:rgba(243,239,230,0.55); font-family:var(--font-mono); }
.issue-body .term pre { margin:0; padding:1.05rem 1.25rem; font-family:var(--font-mono); font-size:0.85rem; line-height:1.7; color:#f3efe6; background:transparent; border:none; overflow-x:auto; }
.issue-body .term .tc { color:rgba(243,239,230,0.45); }
.issue-body .term .tp { color:var(--accent); font-weight:700; }
.issue-body .yt-btn { display:inline-block; padding:0.85rem 1.9rem; background:#ff0000; color:#fff; font-weight:700; font-size:1rem; letter-spacing:0.01em; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .yt-btn:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(255,0,0,0.5); }
.issue-body .discord-btn { display:inline-flex; align-items:center; gap:0.6rem; padding:0.8rem 1.7rem; background:#5865F2; color:#fff; font-weight:700; font-size:1rem; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .discord-btn:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(88,101,242,0.55); }
.issue-body .discord-btn svg { width:22px; height:22px; flex:none; }
</style>

<a class="feat-hero" href="https://jachacks.org/">JacHacks lands in San Francisco</a>

<a href="https://jachacks.org/" target="_blank" rel="noopener" class="news-img">
  <img src="/issues/004/jachacks.png?v=4" alt="JacHacks SF, registration open. July 26, 2026, 8:00 AM PT, Founders, Inc., San Francisco." />
</a>

<p class="feat-lede">JacHacks SF is a one-day, in-person hackathon built around the future of AI programming, happening <strong>July 26</strong> at <strong>Founders, Inc. in San Francisco</strong>. Starting at 8 AM PT, you spend the day <strong>building AI agents and applications with Jac</strong>, and demo what you made that same evening.</p>

<div class="feat-try-wrap" style="margin:1.5rem 0 2rem;">
  <a class="feat-try" href="https://jachacks.org/" target="_blank" rel="noopener">Register for JacHacks SF &rarr;</a>
</div>

<span class="feat-kicker">What to expect</span>

<ul class="feat-list">
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M8 21h8M12 17v4M7 4h10v4a5 5 0 0 1-10 0V4z"/><path d="M7 5H4a3 3 0 0 0 3 3M17 5h3a3 3 0 0 1-3 3"/></svg></span><span>$10,000+ in prizes</span></li>
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="9" y="3" width="6" height="11" rx="3"/><path d="M5 11a7 7 0 0 0 14 0M12 18v3"/></svg></span><span>Talks, workshops, and mentorship from startup founders and AI leaders</span></li>
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><rect x="6" y="6" width="12" height="12" rx="2"/><path d="M9 2v4M15 2v4M9 18v4M15 18v4M2 9h4M2 15h4M18 9h4M18 15h4"/></svg></span><span>The latest AI tools, models, and agent frameworks to build with</span></li>
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="9" cy="8" r="3"/><path d="M4 20c0-3 2.3-5 5-5s5 2 5 5"/><circle cx="17" cy="9" r="2.5"/><path d="M16 15.2c2.4.2 4 1.9 4 4.3"/></svg></span><span>Founders, engineers, and investors from across the Bay Area</span></li>
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><circle cx="9" cy="8" r="3"/><path d="M4 20c0-3 2.3-5 5-5s5 2 5 5M18 8v6M15 11h6"/></svg></span><span>Your next co-founder, teammate, or opportunity</span></li>
<li><span class="fi"><svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round" stroke-linejoin="round" aria-hidden="true"><path d="M7 3v7a2 2 0 0 0 4 0V3M9 3v18M17 3c-2.5 3-2.5 7 0 9v9"/></svg></span><span>Great food and a full day of building</span></li>
</ul>

JacHacks has previously brought together builders from **20+ universities**, including Michigan, Harvard, MIT, Stanford, UC Berkeley, and Waterloo, with this May's online edition alone drawing **300+ builders** who shipped **81 projects**.

<p class="feat-callout">Now that community meets in the heart of San Francisco. Come with an idea or find your team at the event, and leave with something real.</p>

<div class="orn-divider" aria-hidden="true" style="margin:3rem auto 2.25rem;"><i></i><i></i><i></i></div>

<a class="feat-hero" href="https://blogs.jaseci.org/blog/posts/one-binary-build-anything">The whole Jac toolchain, in one binary</a>

<div class="term">
<div class="term-bar"><i></i><i></i><i></i><span>terminal</span></div>
<pre><span class="tc"># one download, the whole toolchain</span>
<span class="tp">$</span> curl -fsSL https://raw.githubusercontent.com/jaseci-labs/jaseci/main/scripts/install.sh | bash
<span class="tc"># then everything is just jac</span>
<span class="tp">$</span> jac add numpy      <span class="tc"># PyPI and npm deps, one tool</span>
<span class="tp">$</span> jac start          <span class="tc"># walkers become REST APIs</span>
<span class="tp">$</span> jac nacompile      <span class="tc"># compile to a native binary</span>
<span class="tp">$</span> jac x hf           <span class="tc"># run any CLI from PyPI or npm</span></pre>
</div>

<p class="feat-lede">Jac ships as a <strong>single native binary</strong>. One download gives you the compiler, runtime, package manager, a web server for your apps, and <strong>built-in AI integration</strong>. There's <strong>no system Python, Node.js, or C toolchain</strong> to set up first. Explore the tutorial to see everything inside the binary, and how one tool quietly replaces the whole stack you'd normally install first.</p>

<div class="feat-try-wrap" style="margin:1.4rem 0 0.5rem;">
  <a class="feat-try" href="https://blogs.jaseci.org/blog/posts/one-binary-build-anything" target="_blank" rel="noopener">Read the article &rarr;</a>
</div>

## Articles

### [GhostWatch: how a JacHacks Winter winner built an autonomous code guardian in Jac](https://blogs.jaseci.org/blog/posts/ghostwatch-how-one-of-the-jachacks-winter-winners-built-an-autonomous-code-guardian-in-jac)

Two University of Michigan freshmen built GhostWatch in a single weekend at JacHacks Winter: an autonomous system that watches a repo for malicious dependency changes, tests the threat in a sandbox, writes a fix, and opens the pull request itself. It took 2nd in the Agentic AI track. Their write-up covers modeling the repo as a graph, running three walkers over it for a single risk verdict, and using `by llm` for typed LLM calls without the JSON boilerplate. A good preview of what a JacHacks weekend can produce.

## Community

### [Subscribe to Jaseci on YouTube](https://www.youtube.com/@Jac-Jaseci)

The Jac video tutorial series, talks, and demos all land here first. Subscribe to catch each new lesson as it drops.

<div class="feat-try-wrap" style="margin:1.25rem 0 1.5rem;">
  <a class="yt-btn" href="https://www.youtube.com/@Jac-Jaseci" target="_blank" rel="noopener">&#9658;&nbsp;&nbsp;Subscribe to Jaseci on YouTube</a>
</div>

### [Join the Jaseci Discord](https://discord.com/invite/6j3QNdtcN6)

The fastest way to reach the Jaseci team and other builders. Debugging help, release questions, RFC chatter, and a steady stream of show-and-tells. Worth joining whether you're shipping Jac in production or just getting curious.

<div class="feat-try-wrap" style="margin:1rem 0 0.5rem;">
  <a class="discord-btn" href="https://discord.com/invite/6j3QNdtcN6" target="_blank" rel="noopener"><svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.198.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z"/></svg>Join the Discord</a>
</div>

<!--
STUBS for the rest of the issue. Uncomment a section once it has real content.

## Built with Jac

(2-3 community projects, or link the gallery. Candidate: standout JacHacks
Spring winners as a "what people build at JacHacks" teaser to reinforce the
featured story.)

### [Project name](https://project-link.example.com)

One or two sentences. What is the project, what does it use Jac for, and why
is it worth a click.

## Releases

(Any jaclang / plugin releases since 0.30.3? Check
https://docs.jaseci.org/community/release_notes/jaclang/)

### [Project name vX.Y: what shipped](https://example.com)

One or two sentences. Headline the big new capability.
-->

<div class="orn-divider" aria-hidden="true"><i></i><i></i><i></i></div>

That's Issue N.04. One day in San Francisco, $10,000+ in prizes, and a room full of people building the future of AI programming. [Grab your spot at JacHacks SF](https://jachacks.org/) and see you there on **July 26**.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
