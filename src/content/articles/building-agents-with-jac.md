---
title: "Agentic AI with Jac: A Programming Language That Knows What an Agent Is"
description: Most agent frameworks make you say everything twice. Jac collapses the duplication with seven patterns that turn retry loops, routing, and tool use into language features the runtime can see.
date: 2026-06-10
eyebrow: Featured article · Issue N.02
draft: false
---

Building an AI agent today means rebuilding the same machinery every time. You declare a tool as a function, then declare it again as a JSON schema. You describe a workflow in plain English inside a system prompt, then hope the model follows it. You write a ReAct loop, validation-retry logic, and a routing dispatcher, and then the next project you write them again.

Jac was designed so you do not have to. When agents, tools, and workflows are first-class in the language, the boilerplate stops being something you write and becomes something the runtime handles.

## Three problems with how we build agents

Before the patterns, it helps to name what is actually wrong.

### 1. Duplicated intent

A tool lives in your code as a function with a signature, and again as a JSON schema the model reads. A structured output lives as a type, and again as a description in the prompt. Nothing keeps the two copies in sync. Rename a parameter and the prompt silently drifts.

### 2. Prose-based workflows

Sequencing, branching, retries, and parallelism end up described in natural language inside a system prompt. The control flow of your agent is a paragraph, not code. The runtime cannot verify it, enforce it, or show you where it went wrong.

### 3. Repeated infrastructure

Every team rebuilds the same supporting machinery: the ReAct loop, the validate-and-retry cycle, the dispatcher that routes to the right specialist, the thread pool that fans work out and gathers it back. None of it is your product. All of it has to exist.

## Two ideas that fix the root cause

Jac addresses all three with two language-level ideas.

**Meaning-Typed Programming**, via the byLLM plugin, makes the function signature the prompt. The name, the parameter names, the types, and the docstring are what the model receives. Change the return type and the schema updates with it. There is no second copy to maintain.

**Object-Spatial Programming** makes the workflow a graph. Nodes hold state, edges hold relationships, and walkers traverse the graph carrying their own state. The control flow you used to bury in a prompt becomes structure the runtime can read.

Together they turn the three problems into three solved primitives: signatures define prompts and schemas, graphs make workflows explicit, and the runtime owns the loops.

## Seven patterns

Almost every agent is some composition of seven patterns. Three are about a single step of thinking. Four are about coordinating steps.

## The Mind: three patterns for a single step

### Generate

Free-text output from a function signature. No prompt string anywhere.

```jac
def answer(question: str) -> str by llm();
```

The function name, parameter, and return type are the instruction. `by llm()` tells the runtime to introspect the signature and ask the model.

### Extract

Typed, structured output with validation and retry built in.

```jac
def classify_paper(title: str, abstract: str) -> PaperClassification by llm();
```

The return type is the schema. The runtime validates the model's JSON against it and retries automatically when the response does not fit. You never write the parser or the retry.

### Invoke

Tool use, where the tools are ordinary functions.

```jac
def research(query: str) -> str by llm(
    tools=[search_papers, get_citations, summarize_abstract]
);
```

The runtime reads each tool's signature, exposes it to the model, runs the calls the model asks for, and manages the whole ReAct loop. You pass functions. You do not write the loop.

## The Flow: four patterns for coordinating steps

This is where Object-Spatial Programming earns its place. Each coordination pattern becomes a shape in the graph.

### Pipe

Sequential composition. Connect nodes with edges and let a walker visit each in order.

```jac
root ++> draft ++> ex ++> summ ++> done;
```

Each node carries its own prompt, and each step's output feeds the next. The numbered list of instructions you used to cram into one system message is now the graph itself.

### Route

Model-guided branching. The model reads the descriptions on the connected nodes and chooses which specialist to visit.

```jac
visit [-->] by llm(incl_info={"User query": self.query});
```

Adding a new specialist is one new node, not a prompt rewrite. The router is part of the language, not something you dispatch by hand.

### Loop

Retry cycles with typed exit conditions. The retry edge carries its own metadata.

```jac
eval_n +>:RetryEdge:+> revise;
revise ++> eval_n;
```

The loop exits on a typed condition like `Quality.GOOD`, not a brittle substring match on the model's text. The graph documents why the loop exists.

### Spawn

Parallel fan-out and merge. Launch concurrent walkers, then wait for them.

```jac
hw_task = flow root spawn HardwareResearcher(topic=self.topic);
sw_task = flow root spawn SoftwareResearcher(topic=self.topic);
hw: any = wait hw_task;
sw: any = wait sw_task;
```

Each walker runs concurrently with its own scoped tools and context. `wait` synchronizes the results before you synthesize them. No thread pool to manage.

## What this adds up to

Look at the seven and notice what is missing from your code. No JSON schemas mirroring your types. No workflow prose in a system prompt. No hand-written ReAct loop, no retry wrapper, no dispatcher, no thread pool. Each of those became a language feature the runtime can see, verify, and run.

That is the whole argument. When the language knows what a tool is, what a workflow is, and what an agent is, building an agent is just building the agent.

For the full walkthrough with complete examples, read the original post on the Jaseci blog: [Building agentic AI with Jac](https://blogs.jaseci.org/blog/2026/05/12/building-agentic-ai-with-jac/).

<div class="end-cta">
  <a href="https://www.jaseci.org" class="cta-pill cta-pill--lg" target="_blank" rel="noopener">Visit Jaseci.org</a>
</div>
