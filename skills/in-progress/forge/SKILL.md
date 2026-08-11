---
name: forge
description: Forge a high-performance, reusable skill out of an expert's own method — their clinical reasoning, their workflow, the repeatable practice they know by reflex but have never fully written down. Use this when someone wants to turn their expertise, their protocol, or their way of doing a recurring task into something an AI can execute at their level — requests like "turn my method into a skill", "I want to codify how I do X", "capture my workflow as a reusable skill", or "build a skill from my process". It runs a deliberate, multi-session extraction, not a quick skill draft. For drafting a simple skill for a well-specified task with no hidden expertise to recover, the lighter skill-creator is the better fit.
disable-model-invocation: true
user-invocable: true
---

# forge — orchestrator for forging a skill from an expert's method

This is the **single entry point** of the forging system and the only piece that holds the *whole*. The component protocols are deliberately myopic — the Grill sees one gap at a time, the Desmonte sees the current map — so something has to hold the trajectory, own the shared state, and decide when each movement is done. That is this skill's entire job.

It implements the three-movement spine: **I. Desmontar** (extract the method) → **II. Remontar** (reconstruct it as an artifact) → **III. Transcender** (auto-optimise). **Movements I and II are implemented — their protocols are bundled in `resources/`.** Movement III is reserved and deferred (see below).

The mental model is a surgical team: not one monolith doing everything, but specialists plus a lead who orchestrates them and owns the shared record — the chart. Here the "chart" is the workspace below, and this skill is the lead.

**Conduct everything the expert sees in the expert's own language.** This body is in English for robustness; the session is not.

## The shared state this skill owns — the "chart"

The Forge initialises and is the single source of truth for:

```
forge-workspace/
├── PROCESS-MAP.md          ← the external view of the flow
├── STEP-FUNCTION-MAP.md    ← each step + its function + true dependencies
├── KNOWLEDGE-MAP.md        ← what is known vs. still missing (the gaps)
├── CONTEXT.md              ← canonical terms / glossary (via /domain-modeling)
└── docs/adr/               ← the "why": ADRs for real trade-offs (via /domain-modeling)
```

The protocols write into these files; the Forge keeps them coherent from turn to turn. No piece of session state lives anywhere else.

## How delegation works

The Forge holds the whole and owns the chart; the movements are **bundled protocols in `resources/`** that it reads and applies inline. The generic capabilities they need live in their own skills and are reached by **invoking them, never by copying their logic here**:
- `resources/deconstruct-protocol.md` — the Desmonte (Movement I): the forge's own piece, adapted from the `leonardo-method` study method with inverted polarity. No generic equivalent — kept whole.
- `resources/grill-protocol.md` — the Grill (Movement I): **invokes `/grilling` + `/domain-modeling`**; keeps only the forge's delta.
- `resources/reconstruct-protocol.md` — the Construtor (Movement II): **invokes `/skill-creator`**; keeps only "consume the chart, choose the mold, hold the fidelity floor".

What stays bundled is only what is genuinely the forge's: the Desmonte, the shared-state chart, and the orchestration. Everything generic is invoked.

## Entry — onboarding the expert

At the start, briefly tell the expert what is about to happen and set the one expectation that makes this work:

> Ask them to deposit **whatever they already have** — files, worked examples, old notes, transcripts — **even if that is almost nothing.** Make clear that there is no homework dump: the process will pull the method out through questions, and a question may simply prompt them to go write something down or dig up a file. **They can add material at any point.** This back-and-forth is expected, not a failure.

Then ingest everything provided and form the first `PROCESS-MAP.md`. The starting balance depends on what exists:
- **Rich documentation** → ingestion-heavy; the Desmonte does most of the early work; the Grill is light.
- **Almost nothing written** → interrogation-heavy from the first turn, and the **transcript of the session itself becomes the source material** that the Desmonte then decomposes.

## Movement I — the spiral (implemented)

Extraction is not a pipeline, it is a spiral. Each turn:

1. **Deconstruct what we have** (apply `resources/deconstruct-protocol.md`). It rewrites `STEP-FUNCTION-MAP.md` — every step reduced to its *function* and *true dependencies*, not the expert's habitual surface order — and produces a **ranked list of gaps**: whatever will not resolve from the existing material.
2. **Take the single biggest gap** and **interrogate only that** (apply `resources/grill-protocol.md`, which invokes `/grilling` + `/domain-modeling`). One question at a time, recommended answer attached. The Grill sharpens terms into `CONTEXT.md` and records genuine trade-offs as ADRs in `docs/adr/`, inline.
3. **Capture** the expert's answer, or the new artifact the question prompted them to provide, into the chart.
4. **Re-deconstruct** with the new information. The map tightens; new, smaller gaps may surface. Turn again.

### This skill's heart: one gap per turn, and an honest verdict on readiness

Two judgements are the Forge's alone, because only it sees the whole:

- **Converge the spiral — do not let it sprawl.** Exactly one gap is pursued per turn: the most valuable thing still missing or still tacit. Never fan out into a questionnaire (that is the cheap-first rule at the orchestration level). This is what keeps the expert's effort minimal and the session finite.
- **Tell the truth about readiness.** The exit gate belongs to the expert — the loop continues until *they* declare it sufficient. But the Forge must give them an honest verdict to decide on: either *"the map is now complete enough to reconstruct from"* or *"a known gap still threatens the result, here is which one and why."* Never let the expert stop blind, and never declare completion on their behalf.

When the expert declares the extraction sufficient, Movement I closes and the chart is complete: process map, functional map, knowledge map, CONTEXT glossary, and ADRs.

## Movement II — reconstruction (implemented)

The completed `forge-workspace/` chart is handed to the **Construtor** (apply `resources/reconstruct-protocol.md`, which **invokes `/skill-creator`** to write and structure the skill, keeping only the forge's part: consume the chart, choose the mold, hold the fidelity floor). It synthesises the new `SKILL.md` *for an AI executor* — function and rationale rather than surface order, the `CONTEXT.md` glossary embedded, progressive disclosure, scripts packaged where the deconstruction found repeated deterministic work — then validates it against realistic test prompts (qualitative and quantitative), iterating until the tests prove it. **Fidelity is the floor:** it may improve on the expert's habitual way only as far as a measurable, observable signal confirms it.

**Interface it exposes for Movement III:** the eval harness it produces (test prompts plus assertions) is made public, so the Optimiser downstream can consume it.

## The return edge — the skill is a prototype, not a finish line

Movement II ships a **prototype**, not a finished skill; the forge's work continues through the skill's use:

1. The skill runs on real requests; its **eval harness** is the instrument. Output that misses the target is a **failure signal**.
2. **Each failure becomes a new gap** in `KNOWLEDGE-MAP.md`, written like any gap the Desmonte flags — but sourced from reality.
3. That gap **re-opens Movement I** on that one point: deconstruct → Grill → rebuild. The spiral turns again, now fed by use.

Route this with **`/handoff`** — run it to pass a forge in progress (or a shipped prototype) between sessions, and to log a real-use failure back as a new gap that re-opens Movement I. "Done" stays provisional: the expert's gate closes each round, but closing it ships a better prototype, never a frozen final.

## Movement III — auto-optimisation (reserved socket — deferred)

> **Handoff:** the validated skill plus its eval harness is passed to the **Otimizador** (inspired by Karpathy's auto-research): it generates trigger-evals, proposes variants of the description and instructions, scores them on **held-out** cases (train/test split, to avoid overfitting), and keeps the winner. Because the components are bundled rather than auto-invoked, and only this Forge triggers automatically, the Optimiser's trigger-optimisation targets **this skill's description** primarily.
>
> *Build deferred by decision. The Karpathy source will be read when we reach this movement, to design it from the source rather than from memory.*

## When NOT to use this skill
- The task is a simple, well-specified job with no hidden expertise to recover — use the lighter skill-creator.
- The user wants a quick answer or a one-off output, not a reusable, reproducible method.
- There is no repeatable practice underneath — nothing to deconstruct, nothing to forge.
- The expert cannot commit time across the session — extraction without engagement produces shallow, abandoned maps.

## The shape of a session, in one breath

> Deposit what exists (or admit there is almost nothing) → the Desmonte breaks it into functions and finds the biggest hole → the Grill (`/grilling` + `/domain-modeling`) drills that one hole, sharpening words and logging trade-offs → re-deconstruct → repeat, one hole at a time, until you say "enough" and the Forge agrees the map can be built from → the Construtor (`/skill-creator`) writes the SKILL.md and tests it against the target → ship the prototype; each real failure becomes a new gap (via `/handoff`) and turns the spiral again. "Done" stays provisional.
