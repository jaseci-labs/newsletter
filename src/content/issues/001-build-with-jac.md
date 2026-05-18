---
number: 1
title: Day one
date: 2026-05-15
description: Jac's case for an AI-native language, the projects already built on it, and the releases, articles, and community work that shipped across the first fortnight.
draft: false
---

<div class="intro-grid">
<div>

Welcome to **Issue N.01** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

Every other Thursday we'll send you a short, scannable list of releases, articles, projects, and community notes. No fluff. The goal is to keep you in the loop without taking more than five minutes of your day.

This week's lead is a piece on why Jac exists at all: what AI-native software actually needs, and why the languages we have weren't built for it.

</div>
<figure>
  <img src="/issues/001/jaseci_newsltter.png" alt="Jaseci Digest hero artwork." />
</figure>
</div>

<a class="arrow-cta" href="/articles/build-with-jac">
  <span class="arrow-cta__icon" aria-hidden="true">
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M5 12 H19 M13 6 L19 12 L13 18" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </span>
  <span class="arrow-cta__text">
    Know what AI-native software actually needs. Figure out what existing languages can't do. Jac builds where those overlap.
  </span>
</a>

## Featured

### [Build with Jac: how Jac is changing the way we build AI software](/articles/build-with-jac)

Most languages were designed before AI was the product. Jac was designed from scratch around two ideas: meaning-typed programming (where `by llm()` replaces hand-written prompts) and object-spatial programming (where graphs and walkers replace plain OOP). Worth a slow read.

## Built with Jac

### [Explore the gallery of projects built with Jaseci](https://www.jaseci.org/built-with-jaseci)

A growing collection of open-source projects, hackathon winners, and production systems shipped on Jac and Jaseci. Worth a scroll if you're looking for code to read, patterns to copy, or proof that the paradigm works at scale.

## Articles

### [Same app, 5× the code: anatomy of a full-stack polyglot tax](https://blogs.jaseci.org/blog/2026/04/09/jac-vs-sota-todo-app/)

The same todo app built two ways: 46 lines in one Jac file versus 233 lines across eleven files in a SOTA stack (FastAPI, React, TypeScript). A concrete look at how much code exists only to translate between incompatible type systems.

### [Building agents in a language that knows what an agent is](https://blogs.jaseci.org/blog/2026/05/12/building-agentic-ai-with-jac/)

Why general-purpose languages make you rebuild agent infrastructure every time you ship one: declaring tool schemas twice, embedding workflows in prose prompts, hand-writing ReAct loops. The argument for making the agent itself a language primitive.

### [Sometimes, meta-packages need to go. Here's why.](https://blogs.jaseci.org/blog/2026/03/31/why-jac-client-should-drop-meta-packages/)

The case against meta-packages in jac-client. Bundling several dependencies behind one line hides complexity instead of removing it. Direct dependency injection turns "one opaque line into seven honest ones."

## Community

### [JacHacks Spring 2026 is happening May 15 to 19](https://jachacks.org/)

Four days of online, global, no-travel hacking on AI-native, graph-powered apps in Jac. Tutorials and mentors throughout. Prize tracks span agentic AI, fintech, social impact, and more. Catch the [opening ceremony and keynote by Jason Mars](https://www.youtube.com/watch?v=JHBLmoU7zVk).

### [Join the Jaseci Discord](https://discord.gg/jaseci)

The fastest way to talk to the team and other builders. RFC chatter, debugging help, JacHacks coordination, and a steady stream of show-and-tells from the community. Worth joining whether you're shipping in production or just curious.

## Tools & libraries

### [byllm](https://docs.jaseci.org/reference/plugins/byllm/)

The runtime behind `by llm()`. You write a typed function signature with a docstring; byllm builds the prompt, parses the response, and returns a typed result. Supports structured outputs, tool calling, streaming, and multimodal inputs.

### [jac-mcp](https://docs.jaseci.org/quick-guide/agent-skills-and-mcp/)

Plug Claude, Cursor, or any MCP-compatible client into the Jac toolchain. The MCP server gives the assistant live compiler validation and auto-loaded skill guides so it writes idiomatic, correct Jac instead of hallucinating syntax.

### [jac-client](https://docs.jaseci.org/reference/plugins/jac-client/)

Write a full stack in one Jac codebase. Server walkers compile to Python; client components compile to JavaScript with React as the renderer. The same `.jac` files target web, mobile (via Capacitor), desktop (via Tauri), and PWAs, no separate TypeScript layer required.

## Releases

### [jaclang v0.15.0: strict `any` and ambient typing](https://docs.jaseci.org/community/release_notes/jaclang/)

Strict `any` semantics across `.jac` modules tightens type behavior at module boundaries. Adds ambient typing primitives (`Callable`, `Protocol`, `TypeVar`), typed walker `reports`, and SSE-aware streaming returns. Breaking change: read the [migration notes](https://docs.jaseci.org/community/breaking-changes/#1-strict-any-semantics-in-jac-modules) first.

### [jac-scale v0.2.16: production Kubernetes mode](https://docs.jaseci.org/community/release_notes/jac-scale/)

Fans one container image out to a Deployment, ClusterIP Service, HPA, and PDB per `sv import`-discovered service. Zero-downtime rolling updates, MongoDB and Redis auto-provisioning for stateful services, sticky sessions for WebSockets. `jac start app.jac --scale` is now real.

### [jac-client v0.3.14: native mobile via Capacitor](https://docs.jaseci.org/community/release_notes/jac-client/)

`jac build --client mobile` wraps your web app in a native Android or iOS shell with automatic HMR. One Jac codebase, three deploy targets.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
