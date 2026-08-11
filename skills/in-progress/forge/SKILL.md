---
name: forge
description: Forge a high-performance, reusable skill out of an expert's own method — their clinical reasoning, their workflow, the repeatable practice they know by reflex but have never fully written down. Use this when someone wants to turn their expertise, their protocol, or their way of doing a recurring task into something an AI can execute at their level — requests like "turn my method into a skill", "I want to codify how I do X", "capture my workflow as a reusable skill", or "build a skill from my process". It runs a deliberate, multi-session extraction, not a quick skill draft. For drafting a simple skill for a well-specified task with no hidden expertise to recover, the lighter skill-creator is the better fit.
disable-model-invocation: true
---

# forge — forge a skill from an expert's method

Turn an expert's tacit, repeatable method into a reusable skill an AI runs at or above their level. You are the orchestrator: you hold the whole, own the chart, run the spiral, and give an honest verdict on readiness. The heavy generic work is **invoked, not reimplemented**. Conduct everything the expert sees in their own language; this body is English for robustness.

## The chart — the shared state you own

```
forge-workspace/
├── PROCESS-MAP.md          the external view of the flow
├── STEP-FUNCTION-MAP.md    each step's function + true dependencies (the Desmonte's output)
├── KNOWLEDGE-MAP.md        what's known vs. still missing (the gaps)
├── CONTEXT.md              the glossary   (via /domain-modeling)
└── docs/adr/               the "why"      (via /domain-modeling)
```

Create files lazily — only when there's something to write.

## Entry

Ask the expert to deposit whatever they have — files, examples, transcripts — even if it's almost nothing. No homework dump: the method comes out through questions; a question may just prompt them to write something down. Ingest it and form the first `PROCESS-MAP.md`. Rich docs → ingestion-heavy, light Grill; almost nothing → interrogation-heavy, and the session transcript becomes the source.

Then pin the target: ask for concrete examples of good vs. bad output and capture it in `OUTCOME.md` — what the spiral converges toward, and the seed of the eval harness.

## Movement I — the spiral (extract)

Not a pipeline; a spiral. Each turn:

1. **Deconstruct what we have** — apply `resources/deconstruct-protocol.md` (the Desmonte). It rewrites `STEP-FUNCTION-MAP.md` (every step reduced to function + true dependencies, not surface order) and ranks the gaps.
2. **Drill the single biggest gap** — run `/grilling` and `/domain-modeling`, turned on the expert's method. One question per turn, recommended answer attached; `/domain-modeling` writes terms to `CONTEXT.md` and trade-offs to `docs/adr/`. The forge adds: **neutralise the dump** (an expert who pastes text expects magic); **cheap-first** (if the material answers it, look — don't ask); **one gap per turn**.
3. **Capture** the answer (or the artifact it prompted) and **re-deconstruct**. The map tightens; turn again.

**Your two jobs alone, because only you see the whole:** converge the spiral — one gap per turn, never a questionnaire; and tell the truth about readiness — *"the map can be built from"* or *"this gap still threatens the result, here's why."* The exit gate is the expert's; never let them stop blind.

## Movement II — reconstruction (rebuild)

Run `/skill-creator` to write and structure the `SKILL.md`. The forge adds three things on top:

- **Consume the chart** — build from `STEP-FUNCTION-MAP.md` + `CONTEXT.md` + `docs/adr/`, not a fresh interview. Encode each instruction as its function and reason, in true dependency order — never the expert's surface sequence. If the chart has a hole, flag it back to Movement I; never invent the missing piece.
- **Choose the mold** — a skill is an ability, not always a procedure: procedural (default), holistic, or mixed.
- **Fidelity is the floor** — reconstruct faithfully; diverge from the expert's habit only when a **measurable, observable** signal proves it's better. No measurement, no divergence.

Validate against realistic test prompts (qualitative: read output **and** transcript; quantitative: assertions → pass rate), reserving some cases. Expose the **eval harness** — the socket Movement III consumes.

## The return edge — a prototype, not a finish line

Movement II ships a prototype. A real-use failure becomes a new gap in `KNOWLEDGE-MAP.md` that re-opens Movement I on that point. Route it with `/handoff`. "Done" stays provisional.

## Movement III — auto-optimisation (deferred)

Once a prototype has matured, it can be auto-optimised against its harness (Karpathy-style autoresearch). Deferred; built from the source when we reach it.

## When NOT to use

Simple, well-specified task with no hidden expertise → use `/skill-creator`. A one-off output, or no repeatable method underneath → nothing to forge. Expert can't commit time → shallow, abandoned maps.
