---
number: 3
title: Agents in the language
date: 2026-07-01
description: Building agentic AI is easy when the language does the heavy lifting. In Jac, the agent is the only code you write.
draft: false
---

<!--
DRAFT scaffold for Issue N.03. The Featured section is written. The rest are
stubs: fill the items you have, delete the headings you don't. Remove
`draft: true` when ready to publish. Drop any images into public/issues/003/.
-->

Welcome to **Issue N.03** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

This week's lead is about building AI agents with far less code. Today, much of an agent's codebase is scaffolding: integrating the model, defining each tool, and validating and retrying its outputs. **[Building Agentic AI with Jac](https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac)** shows how Jac builds that scaffolding into the language, so the only thing you write is the agent itself.

## Featured

<style>
@import url('https://fonts.googleapis.com/css2?family=Source+Sans+3:wght@400;600;700&display=swap');
.issue-body .feat-eyebrow { display:block; font-weight:700; font-size:0.78rem; text-transform:uppercase; letter-spacing:0.08em; color:var(--accent); margin:0.5rem 0 0.5rem; }
.issue-body .feat-hero { display:block; margin:0 0 1.25rem; font-size:clamp(1.7rem,4.2vw,2.7rem); font-weight:700; line-height:1.08; letter-spacing:-0.02em; color:var(--text-heading); text-decoration:none; }
.issue-body .feat-hero:hover { color:var(--accent); }
.issue-body .feat-code-cap { display:flex; align-items:center; justify-content:space-between; gap:0.6rem; max-width:none; margin:1.5rem 0 0; padding:0.6rem 1.05rem; background:#efdcc4; border:1px solid var(--rule-soft); border-left:4px solid var(--accent); border-bottom:none; border-radius:12px 12px 0 0; font-weight:700; font-size:0.92rem; color:var(--text-heading); }
.issue-body .feat-code-cap .badge { font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.05em; color:var(--bg); background:var(--accent); padding:0.24em 0.75em; border-radius:999px; white-space:nowrap; }
.issue-body .codehilite, .issue-body .codehilite pre { background:#f6f0e6; }
.issue-body .codehilite { margin:0 0 1.25rem; border:1px solid var(--rule-soft); border-top:none; border-left:4px solid var(--accent); border-radius:0 0 12px 12px; box-shadow:0 16px 34px -20px rgba(31,22,14,0.4); overflow:hidden; }
.issue-body .codehilite pre { margin:0; padding:1rem 1.2rem; overflow-x:auto; color:#2c2218; background:transparent; border:none; border-radius:0; box-shadow:none; }
.issue-body .codehilite .c, .issue-body .codehilite .c1, .issue-body .codehilite .cm, .issue-body .codehilite .ch, .issue-body .codehilite .cs { color:#b07a3a; font-style:italic; }
.issue-body .codehilite .k, .issue-body .codehilite .kn, .issue-body .codehilite .kd, .issue-body .codehilite .kp, .issue-body .codehilite .kr, .issue-body .codehilite .kc { color:#8a3fb0; }
.issue-body .codehilite .s, .issue-body .codehilite .s1, .issue-body .codehilite .s2, .issue-body .codehilite .sb, .issue-body .codehilite .dl { color:#b5432c; }
.issue-body .codehilite .nb, .issue-body .codehilite .nc, .issue-body .codehilite .kt { color:#1f7a70; }
.issue-body .codehilite .n, .issue-body .codehilite .nn, .issue-body .codehilite .p, .issue-body .codehilite .o, .issue-body .codehilite .nf { color:#2c2218; }
.issue-body .codehilite .m, .issue-body .codehilite .mi, .issue-body .codehilite .mf { color:#b5432c; }
.issue-body .feat-question { font-size:clamp(1.2rem,2.4vw,1.6rem); font-weight:700; line-height:1.3; letter-spacing:-0.015em; color:var(--text-heading); margin:1.5rem 0 1.25rem; }
.issue-body .feat-question .hl { color:var(--accent); }
.issue-body .feat-vs { width:100%; border-collapse:separate; border-spacing:0 0.85rem; margin:1.25rem 0 1.75rem; }
.issue-body .feat-vs-card { padding:1rem 1.25rem; border-radius:12px; line-height:1.5; font-size:1rem; }
.issue-body .feat-vs-card .vs-label { display:block; font-weight:700; font-size:0.78rem; text-transform:uppercase; letter-spacing:0.05em; margin-bottom:0.35rem; }
.issue-body .feat-vs-card.old { background:var(--bg-soft); border:1px solid var(--rule-soft); color:var(--text-muted); }
.issue-body .feat-vs-card.old .vs-label { color:var(--text-muted); }
.issue-body .feat-vs-card.jac { background:rgba(217,122,44,0.09); border:1px solid var(--accent); border-left:5px solid var(--accent); color:var(--text); }
.issue-body .feat-vs-card.jac .vs-label { color:var(--accent); }
.issue-body .feat-vs-card.jac b { color:var(--text-heading); }
.issue-body .feat-table-lead { margin:1.75rem 0 0.6rem; font-size:1.05rem; }
.issue-body .feat-table-lead .tag { display:inline-block; font-size:0.72rem; font-weight:700; text-transform:uppercase; letter-spacing:0.06em; color:var(--bg); background:var(--accent); padding:0.18em 0.6em; border-radius:999px; margin-right:0.55em; vertical-align:middle; }
.issue-body .feat-table { width:100%; table-layout:fixed; border-collapse:separate; border-spacing:0; margin:0.5rem 0 1.5rem; font-family:'Source Sans 3', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; font-size:0.95rem; line-height:1.4; border:1px solid var(--rule-soft); border-radius:12px; overflow:hidden; box-shadow:0 2px 14px -8px rgba(31,22,14,0.22); }
.issue-body .feat-table th, .issue-body .feat-table td { padding:0.85rem 1rem; text-align:left; vertical-align:top; }
.issue-body .feat-table thead th { font-weight:700; font-size:0.95rem; }
.issue-body .feat-table thead th:first-child { width:18%; background:var(--bg-soft); }
.issue-body .feat-table thead th.jh { width:44%; background:var(--accent); color:var(--bg); }
.issue-body .feat-table thead th.lv { width:38%; background:var(--bg-soft); color:var(--text-muted); }
.issue-body .feat-table .row-label { font-weight:700; color:var(--text-heading); }
.issue-body .feat-table td.jh { color:var(--text-heading); background:rgba(217,122,44,0.13); }
.issue-body .feat-table td.jh::before { content:"\2713\00a0\00a0"; color:var(--accent); font-weight:700; }
.issue-body .feat-table td.lv { color:var(--text-muted); }
.issue-body .feat-table tbody tr:not(:last-child) td { border-bottom:1px solid var(--rule-soft); }
.issue-body .feat-table code { font-size:0.82em; background:#ffffff; border:1px solid var(--rule-soft); color:var(--accent); padding:0.1em 0.45em; border-radius:5px; }
.issue-body .feat-try-wrap { margin:1.75rem 0 0.5rem; text-align:center; }
.issue-body .feat-try-wrap p { margin:0; text-align:center; }
.issue-body .feat-try { display:inline-block; padding:1rem 2.2rem; background:var(--accent); color:var(--bg); font-weight:700; font-size:1.05rem; letter-spacing:0.01em; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease, background 0.15s ease; }
.issue-body .feat-try:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(184,95,21,0.5); background:var(--accent-hover); }
.issue-body .yt-btn { display:inline-block; padding:0.85rem 1.9rem; background:#ff0000; color:#fff; font-weight:700; font-size:1rem; letter-spacing:0.01em; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .yt-btn:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(255,0,0,0.5); }
.issue-body .news-img { display:block; margin:0.75rem 0 1.1rem; border-radius:12px; overflow:hidden; border:1px solid var(--rule-soft); box-shadow:0 12px 32px -16px rgba(31,22,14,0.45); transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .news-img:hover { transform:translateY(-2px); box-shadow:0 18px 40px -16px rgba(31,22,14,0.55); }
.issue-body .news-img img { display:block; width:100%; height:auto; margin:0; }
.issue-body .discord-btn { display:inline-flex; align-items:center; gap:0.6rem; padding:0.8rem 1.7rem; background:#5865F2; color:#fff; font-weight:700; font-size:1rem; border-radius:999px; text-decoration:none; transition:transform 0.15s ease, box-shadow 0.2s ease; }
.issue-body .discord-btn:hover { transform:translateY(-2px); box-shadow:0 12px 26px -8px rgba(88,101,242,0.55); }
.issue-body .discord-btn svg { width:22px; height:22px; flex:none; }
</style>

<a class="feat-hero" href="https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac">Agentic AI is easy when it's built into the language</a>

<p class="feat-question">What if the AI agent that usually takes <span class="hl">150+ lines of code</span> to build was just <span class="hl">7 lines with Jac</span>?</p>

<p class="feat-code-cap">A complete AI agent <span class="badge">7 lines of Jac</span></p>

```jac
import from byllm.llm { Model }
glob llm = Model(model_name="openai/gpt-4o");

# A tool is just an ordinary function.
def search(query: str) -> list[str];

# An agent: a function the model runs, calling tools.
def research(topic: str) -> str by llm(tools=[search]);

with entry {
    print(research("the best coffee in Tokyo"));
}
```

<table class="feat-vs">
<tr><td class="feat-vs-card old"><span class="vs-label">&#10007;&nbsp; The usual way</span>You write the agent and all the code around it: connecting to the model, defining each tool, looping while it works, and validating and retrying its output. Most of your file is not the agent.</td></tr>
<tr><td class="feat-vs-card jac"><span class="vs-label">&#10003;&nbsp; With Jac</span><b>That supporting code is part of the language.</b> You describe the agent, and the runtime handles the rest. The whole thing is the 7 lines above.</td></tr>
</table>

The full article explores how Jac makes building real, capable agents this simple.

<div class="feat-try-wrap">
  <a class="feat-try" href="https://blogs.jaseci.org/blog/posts/building-agentic-ai-with-jac" target="_blank" rel="noopener">Read the article &rarr;</a>
</div>

## Tutorials

### [Jac Tutorial: Lesson 1](https://youtu.be/EB4vtXbO5Js)

The Jaseci team just kicked off a video series that teaches Jac from the ground up. Lesson 1 is a hands-on introduction: install the toolchain, write your first program, and get a feel for how the language reads. It is the first of many, with new lessons landing regularly, so subscribe to the Jaseci channel to follow along.

<div class="feat-try-wrap" style="margin:1.25rem 0 1.5rem;">
  <a class="yt-btn" href="https://www.youtube.com/@Jac-Jaseci" target="_blank" rel="noopener">&#9658;&nbsp;&nbsp;Subscribe to Jaseci on YouTube</a>
</div>

<figure class="video-embed" style="position:relative;padding-bottom:56.25%;height:0;overflow:hidden;margin:1.5rem 0 1.25rem;border-radius:10px;">
  <iframe style="position:absolute;top:0;left:0;width:100%;height:100%;border:0;" src="https://www.youtube.com/embed/EB4vtXbO5Js" title="Jac Tutorial: Lesson 1" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share" allowfullscreen></iframe>
</figure>

## Community

### [JacHacks SF is coming](https://jachacks.org/)

<a href="https://jachacks.org/" target="_blank" rel="noopener" class="news-img">
  <img src="/issues/003/jachacks.png" alt="JacHacks SF. August 8, 2026, 9:00 AM PT, San Francisco." />
</a>

JacHacks heads to San Francisco for a one-day, in-person hackathon built around the future of AI programming, landing August 8 at 9 AM PT. It follows a strong run for the series, with JacHacks Spring drawing 300+ builders and 81 projects online this May. [Register on Luma](https://luma.com/9x1573sw) to grab your spot.

### [Join the Jaseci Discord](https://discord.com/invite/6j3QNdtcN6)

The fastest way to talk to the team and other builders. RFC chatter, debugging help, release questions, and a steady stream of show-and-tells. Worth joining whether you ship in production or are just curious.

<div class="feat-try-wrap" style="margin:1rem 0 0.5rem;">
  <a class="discord-btn" href="https://discord.com/invite/6j3QNdtcN6" target="_blank" rel="noopener"><svg viewBox="0 0 24 24" fill="currentColor" aria-hidden="true"><path d="M20.317 4.3698a19.7913 19.7913 0 00-4.8851-1.5152.0741.0741 0 00-.0785.0371c-.211.3753-.4447.8648-.6083 1.2495-1.8447-.2762-3.68-.2762-5.4868 0-.1636-.3933-.4058-.8742-.6177-1.2495a.077.077 0 00-.0785-.037 19.7363 19.7363 0 00-4.8852 1.515.0699.0699 0 00-.0321.0277C.5334 9.0458-.319 13.5799.0992 18.0578a.0824.0824 0 00.0312.0561c2.0528 1.5076 4.0413 2.4228 5.9929 3.0294a.0777.0777 0 00.0842-.0276c.4616-.6304.8731-1.2952 1.226-1.9942a.076.076 0 00-.0416-.1057c-.6528-.2476-1.2743-.5495-1.8722-.8923a.077.077 0 01-.0076-.1277c.1258-.0943.2517-.1923.3718-.2914a.0743.0743 0 01.0776-.0105c3.9278 1.7933 8.18 1.7933 12.0614 0a.0739.0739 0 01.0785.0095c.1202.099.246.198.3728.2924a.077.077 0 01-.0066.1276 12.2986 12.2986 0 01-1.873.8914.0766.0766 0 00-.0407.1067c.3604.698.7719 1.3628 1.225 1.9932a.076.076 0 00.0842.0286c1.961-.6067 3.9495-1.5219 6.0023-3.0294a.077.077 0 00.0313-.0552c.5004-5.177-.8382-9.6739-3.5485-13.6604a.061.061 0 00-.0312-.0286zM8.02 15.3312c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9555-2.4189 2.157-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.9555 2.4189-2.1569 2.4189zm7.9748 0c-1.1825 0-2.1569-1.0857-2.1569-2.419 0-1.3332.9554-2.4189 2.1569-2.4189 1.2108 0 2.1757 1.0952 2.1568 2.419 0 1.3332-.946 2.4189-2.1568 2.4189Z"/></svg>Join the Discord</a>
</div>

## Articles

### [What 75 students shipped in one semester with Jac](https://cse.engin.umich.edu/stories/students-build-agentic-ai-tools-for-work-travel-wellness)

Over one Winter semester, 75+ students in Michigan's EECS 449 shipped 17 full-stack AI applications, most of them in Jac. These were real, working products, not chatbot demos, from an adaptive scheduling assistant to a research terminal for prediction-market traders. They got there in a single term because Jac handles the interface, the logic, the data, and the AI in one language, so the teams spent their time building instead of wiring tools together.

## Releases

### [jaclang v0.30.3: one self-contained binary, nothing else to install](https://docs.jaseci.org/community/release_notes/jaclang/)

The headline of the 0.30 series: jaclang now ships as a single self-contained `jac` binary, a Zig launcher with a bundled CPython. It runs without a separate Python installation or a package manager. Download the binary, add it to your PATH, and `jac run` and `jac start` work immediately. Serving and deploying are now built in as well, with the former `jac-scale` package folded into the binary, and Jac-native desktop apps run on that same bundled runtime. Heavier dependencies such as FastAPI, MongoDB, and Redis are installed per project, only when your configuration requires them.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
