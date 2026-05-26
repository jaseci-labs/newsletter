---
number: 1
title: Day one
date: 2026-05-26
description: Jac's case for an AI-native language, the projects already built on it, and the releases, articles, and community work that shipped across the first fortnight.
draft: false
---

<div class="intro-grid">
<div>

Welcome to **Issue N.01** of Jaseci Digest, a biweekly roundup of what's happening across the Jaseci and Jac open-source ecosystem.

Every other Tuesday we'll send you a short, scannable list of releases, articles, projects, and community notes. No fluff. The goal is to keep you in the loop without piling onto your reading list.

This week's lead is a concrete cost analysis: the same todo app built once in Jac and once in FastAPI plus React plus TypeScript, side by side. The result is hard to argue with.

</div>
<figure>
  <img src="/issues/001/jaseci_newsltter.png" alt="Jaseci Digest hero artwork." />
</figure>
</div>

## Featured

<a class="arrow-cta" href="https://blogs.jaseci.org/blog/2026/04/09/jac-vs-sota-todo-app/">
  <span class="arrow-cta__icon" aria-hidden="true">
    <svg viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
      <path d="M5 12 H19 M13 6 L19 12 L13 18" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
  </span>
  <span class="arrow-cta__text">
    <strong>Same app, 5× the code: anatomy of a full-stack polyglot tax.</strong> 46 lines in one Jac file or 233 across eleven in FastAPI + React + TypeScript. A concrete look at how much code exists only to translate between incompatible type systems.
  </span>
</a>

## Built with Jac

### [Explore the gallery of projects built with Jaseci](https://www.jaseci.org/built-with-jaseci)

A growing collection of open-source projects, hackathon winners, and production systems shipped on Jac and Jaseci. Worth a scroll if you're looking for code to read, patterns to copy, or proof that the paradigm works at scale.

## Articles

### [Sometimes, meta-packages need to go. Here's why.](https://blogs.jaseci.org/blog/2026/03/31/why-jac-client-should-drop-meta-packages/)

The case against meta-packages in jac-client. Bundling several dependencies behind one line hides complexity instead of removing it. Direct dependency injection turns "one opaque line into seven honest ones."

## Community

### [JacHacks Spring 2026: 81 projects shipped in four days](https://jachacks-spring.devpost.com/project-gallery)

Wrapped May 15 to 19 with 81 submissions on Devpost, all built on Jac. Browse the [project gallery](https://jachacks-spring.devpost.com/project-gallery) for what shipped across agentic AI, fintech, social impact, and more. Catch the [opening ceremony and keynote by Jason Mars](https://www.youtube.com/watch?v=JHBLmoU7zVk). Winners will be announced soon.

### [Join the Jaseci Discord](https://discord.gg/jaseci)

The fastest way to talk to the team and other builders. RFC chatter, debugging help, JacHacks coordination, and a steady stream of show-and-tells from the community. Worth joining whether you're shipping in production or just curious.

## Releases

### [jaclang v0.15.3: `defview` and dynamic JSX](https://docs.jaseci.org/community/release_notes/jaclang/)

Adds a `defview` declarator for view declarations and `<@expr />` for dynamic JSX element resolution. The compiler now ships its CLI reference guides bundled, and strict `any` semantics tighten further across module boundaries.

### [byllm v0.6.9: tool calling for local models](https://docs.jaseci.org/community/release_notes/byllm/)

Brings tool calling to backends without server-side tool APIs, like Ollama and vLLM. Local-first agents just got easier to ship.

### [jac-client v0.3.14: native mobile via Capacitor](https://docs.jaseci.org/community/release_notes/jac-client/)

`jac build --client mobile` wraps your web app in a native Android or iOS shell with automatic HMR. One Jac codebase, three deploy targets.

<div class="end-cta">
  <a href="/issues" class="cta-pill cta-pill--lg">Browse the archive</a>
</div>
