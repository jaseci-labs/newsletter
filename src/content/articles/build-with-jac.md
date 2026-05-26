---
title: Build with Jac
description: How Jac is changing the way we build AI software with meaning-typed programming, object-spatial programming, and one language for AI-native full-stack development.
date: 2026-05-26
eyebrow: Featured article · Issue N.01
draft: false
---

<img src="/issues/001/workspace.png" alt="An overhead view of a writing workspace." class="section-image" />

Most languages treat AI as an add-on. Jac was designed from scratch around two core ideas that make AI native to the way you write software, and once you've seen them, it's hard to go back to doing it the old way.

## Two ideas that set Jac apart

### 1. Meaning-Typed Programming

In every other language, when you want an LLM to do something, you write a prompt. You manage it as a string somewhere in your codebase, you engineer it carefully, you hope it stays aligned with the function it's supposed to be powering, and update it manually when things drift. The prompt and the code are two separate things that have to stay synchronized by hand.

In Jac, you write `by llm()` where the function body would go. The language reads your function signature, your parameter names, your types, your docstrings, and constructs the prompt automatically. You declare what the function should do. Jac handles how to ask for it.

Research out of UMich shows this approach lets developers complete tasks 3.2× faster with 45% fewer lines of code.

### 2. Object-Spatial Programming

Traditional object-oriented programming models software as objects calling methods on each other. Jac models software as a graph. Nodes hold state. Edges represent relationships. Walkers are agents that traverse the graph, carry their own state, and execute logic at each node they visit.

This sounds abstract until you see what it unlocks. Dependency graphs, trust networks, memory systems, supply chain maps, social graphs, fraud detection: an enormous category of real problems is naturally graph-shaped. In Python you reach for NetworkX, manage visited sets manually, bolt on a separate agent framework, and wire everything together with glue code. In Jac the walker is the agent and the graph is the execution model at the same time.

## Why this matters

AI is becoming the substance of the software we ship, not an add-on bolted onto it. The languages we have, Python and JavaScript, were designed for a different problem. They're extraordinary general-purpose tools, but they treat AI calls as strings to manage by hand, graphs as third-party libraries to glue together, and deployment as someone else's stack. Every layer in between is friction, and friction is a hidden tax on the speed at which small teams can ship and new ideas can move.

The right primitives in a language compress that work. When AI calls become first-class, prompt management disappears. When graphs become first-class, glue code disappears. When deployment is a one-liner, infrastructure code disappears. You spend less time building the abstraction layer and more time building the thing.

That direction is locked in: AI as a first-class language primitive, agents as graph traversals, deployment as a one-liner. The only open question is which language gets there first, and Jac is already further down that path than most.

## Where to start

Check out Jac at [jaseci.org](https://www.jaseci.org/), or browse the [source on GitHub](https://github.com/jaseci-labs/jaseci). Join our [Discord](https://discord.gg/jaseci). [JacCoder](https://jac-coder.jaseci.org/) and [JacBuilder Studio](https://jac-builder-studio.jaseci.org/) are available for getting up to speed quickly.

The languages we use shape how we think about problems. Jac is asking a different question than every language that came before it.

It's worth paying attention to.

<div class="end-cta">
  <a href="https://www.jaseci.org" class="cta-pill cta-pill--lg" target="_blank" rel="noopener">Visit Jaseci.org</a>
</div>
