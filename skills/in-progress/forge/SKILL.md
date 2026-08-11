---
name: forge
description: Forge a high-performance, reusable skill out of an expert's own method — their clinical reasoning, their workflow, the repeatable practice they know by reflex but have never fully written down. Use this when someone wants to turn their expertise, their protocol, or their way of doing a recurring task into something an AI can execute at their level — requests like "turn my method into a skill", "I want to codify how I do X", "capture my workflow as a reusable skill", or "build a skill from my process". It runs a deliberate, multi-session extraction, not a quick skill draft. For drafting a simple skill for a well-specified task with no hidden expertise to recover, the lighter skill-creator is the better fit.
disable-model-invocation: true
---

# forge — forge a skill from an expert's method

Turn an expert's tacit, repeatable method into a reusable skill an AI runs at or above their level. You are the orchestrator: you hold the whole, own the chart, run the spiral, and give the honest verdict on readiness. The generic work is **invoked, not reimplemented**; each movement's detail lives in `resources/`. Conduct everything the expert sees in their own language.

## The chart — the shared state you own

```
forge-workspace/
├── STEP-FUNCTION-MAP.md    each step's function + true dependencies (the Desmonte's output)
├── KNOWLEDGE-MAP.md        the single home for gaps (Desmonte + return-edge failures)
├── CONTEXT.md              the glossary   (via /domain-modeling)
└── docs/adr/               the "why"      (via /domain-modeling)
```

Create files lazily — only when there's something to write.

## Entry

Ask the expert to deposit whatever they have — even almost nothing; the method comes out through questions, not a homework dump. Ingest it. Then pin the target: concrete examples of good vs. bad output → `OUTCOME.md`, what the spiral converges toward and the seed of the eval harness.

## Movement I — the spiral (extract)

Not a pipeline; a spiral. Each turn, one gap at a time:

1. **Deconstruct** — apply `resources/deconstruct-protocol.md` (the Desmonte): rewrite `STEP-FUNCTION-MAP.md`, add the biggest gaps to `KNOWLEDGE-MAP.md`.
2. **Drill the biggest gap** — apply `resources/grill-protocol.md` (it runs `/grilling` + `/domain-modeling`).
3. **Capture and re-deconstruct.** The map tightens; turn again.

**Your two jobs alone, because only you see the whole:** converge the spiral — one gap per turn, never a questionnaire; and tell the truth about readiness — *"the map can be built from"* or *"this gap still threatens the result, here's why."* The exit gate is the expert's; never let them stop blind.

## Movement II — reconstruction (rebuild)

Apply `resources/reconstruct-protocol.md` (it runs `/skill-creator`): consume the chart, choose the mold, hold the fidelity floor, validate against realistic prompts, and expose the eval harness — the socket Movement III consumes.

## The return edge — a prototype, not a finish line

Movement II ships a prototype. A real-use failure becomes a new gap in `KNOWLEDGE-MAP.md` that re-opens Movement I on that point. Route it with `/handoff`. "Done" stays provisional.

## Movement III — auto-optimisation (deferred)

Once a prototype has matured, it can be auto-optimised against its harness (Karpathy-style autoresearch). Deferred; built from the source when we reach it.

## When NOT to use

Simple, well-specified task with no hidden expertise → use `/skill-creator`. A one-off output, or no repeatable method underneath → nothing to forge. Expert can't commit time → shallow, abandoned maps.
