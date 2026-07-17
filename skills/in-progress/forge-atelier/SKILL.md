---
name: forge-atelier
description: Forge a high-performance, reusable skill out of an expert's own method — their clinical reasoning, their workflow, the repeatable practice they know by reflex but have never fully written down. Use when someone wants to turn their expertise, their protocol, or their way of doing a recurring task into something an AI can execute at their level — "turn my method into a skill", "codify how I do X", "capture my workflow as a reusable skill", "build a skill from my process". It runs a deliberate, multi-session extraction, not a quick draft. This is the single entry point of the forge constellation; it orchestrates the component skills (forge-desmonte, forge-grill, forge-otimizador, forge-handoff). For a simple, well-specified task with no hidden expertise to recover, the lighter skill-creator is the better fit.
when_to_use: When an expert wants their tacit, repeatable method turned into a reusable skill an AI executes at or above their level — and is willing to engage across a session (deposit material, answer one-gap-per-turn questions). Not for one-off outputs or fully-specified simple tasks.
---

# forge-atelier — orchestrator for forging a skill from an expert's method

This is the **single entry point** of the forge constellation and the only piece that holds the *whole*. The component skills are deliberately myopic — the Desmonte sees the current map, the Grill sees one gap at a time — so something has to hold the trajectory, own the shared state, and decide when each movement is done. That is this skill's entire job.

It implements the three-movement spine: **I. Desmontar** (extract the method) → **II. Remontar** (reconstruct it as an artifact) → **III. Transcender** (auto-optimise). Movements I and II run here; the Desmonte and Grill are **separate co-routine skills this orchestrator reads and applies** (single source — never copied); the Construtor (Movement II) is **inline** in this skill; Movement III is a separate skill the orchestrator hands off to.

This spine is a **cycle, not a line.** Movement II does not finish the work — it ships a *prototype*. Real use then exposes where the method was still tacit or simply wrong, and each such failure re-opens Movement I on that one point; the skill is rebuilt and ships again. So **"done" is always provisional** (see *The return edge*).

The mental model is a surgical team: not one monolith doing everything, but specialists plus a lead who orchestrates them and owns the shared record — the chart. Here the "chart" is the workspace, and this skill is the lead.

**Conduct everything the expert sees in the expert's own language.** This body is in English for robustness; the session is not.

## The shared state this skill owns — the "chart"

The Forge initialises and is the single source of truth for the chart. Its schema (the `forge-workspace/` files) is defined once in **`../_shared/chart-spec.md`** — read it; do not redefine it here. The components write into these files; the Forge keeps them coherent from turn to turn. No session state lives anywhere else.

## How the constellation works — read-and-apply, never copy

Skills do not reliably invoke one another, so the Forge does not "call" the components programmatically. Two patterns, both honoring **one source per protocol**:

- **Within Movements I+II, the Forge reads and applies the component protocols by path** — it loads the file and follows it inline, as part of its own turn. It does **not** contain a copy.
  - Desmonte (deconstruction) → **`../forge-desmonte/SKILL.md`**
  - Grill (interrogation) → **`../forge-grill/SKILL.md`**
  - Construtor (reconstruction, Movement II) → **`reconstruct-protocol.md`** (inline in this skill's folder — no standalone use yet)
- **At a seam to a separate skill** (Movement III; a handoff between sessions), the Forge does **not** auto-invoke — it **detects the moment and asks the user** to run the next `/forge-…` skill. Full policy: **`../_shared/activation-seams.md`**.

If a referenced path does not resolve, the bundle was split on install — consult **`../ATELIER-MAP.md`**; if a piece is missing, tell the user and ask them to install the full bundle (never fail silently).

## Entry — onboarding the expert

At the start, briefly tell the expert what is about to happen and set the one expectation that makes this work:

> Ask them to deposit **whatever they already have** — files, worked examples, old notes, transcripts — **even if that is almost nothing.** Make clear there is no homework dump: the process pulls the method out through questions, and a question may simply prompt them to write something down or dig up a file. **They can add material at any point.** This back-and-forth is expected, not a failure.

Then ingest everything provided and form the first `PROCESS-MAP.md`. The starting balance depends on what exists:
- **Rich documentation** → ingestion-heavy; the Desmonte does most of the early work; the Grill is light.
- **Almost nothing written** → interrogation-heavy from the first turn, and the **transcript of the session itself becomes the source material** the Desmonte then decomposes.

### Define the target first — `OUTCOME.md`

Before pulling the method apart, pin down what a **good result of the finished skill** looks like. Ask the expert for **concrete examples of good output, examples of bad output, and what separates them** — what counts as a hit, what counts as a miss, what must never happen. Capture it in **`OUTCOME.md`**.

This is the **target the whole spiral converges toward**, the **seed of the eval harness** Movement II builds, and later the **fitness function** of Movement III. (A strong success criterion lets the agent iterate on its own; a weak one keeps a human in the loop at every step.) Keep it light and example-driven; it sharpens as the method clarifies. One-gap-per-turn still holds — two or three pointed examples are enough to start.

**The OUTCOME also selects the produced skill's control structure (point-4).** A skill is an *ability*, not necessarily a procedure. After Movement I, judge — from the OUTCOME (result quality vs. the expert) and the ingredients captured — whether matching the expert's *result* requires a **procedure** (the default), **holistic judgement** no sequence captures, or a **mix**. Default to procedural unless the captured ingredients and the OUTCOME together show the result does not come from a sequence. **Both molds (procedural and holistic — "mixed" combines them) live here, at the atelier level; neither is carried inside the produced skill** — the produced skill is shaped to its own task, and may be born simple and improve over time. *(This selector is a flagged hypothesis; the procedural default is the safe fallback.)*

### Pick the mode — lean or full

Not every method needs the full ritual. With the expert, choose the path — and say which, and why:
- **Lean** — the expertise is mostly **explicit**: do a **short interrogation** to fill the obvious holes, then go **straight to the Construtor** (Movement II). Skip the full spiral.
- **Full** — the expertise is **deep and tacit**: run the **whole spiral** (Movement I), one gap per turn, until the chart can be built from.

`OUTCOME.md` is defined first **in both modes**. The mode is a starting bet, not a cage: a *lean* forge that keeps hitting tacit gaps should escalate to *full*.

## Movement I — the spiral

Extraction is a spiral, not a pipeline. Each turn:

1. **Deconstruct what we have** — read and apply **`../forge-desmonte/SKILL.md`**. It rewrites `FUNCTION-MAP.md` — every part reduced to its *function* and *true dependencies*, not the expert's habitual surface form — captures any typed ingredients lazily (`INGREDIENTS.md`), and produces a **ranked list of gaps**.
2. **Take the single biggest gap** and **interrogate only that** — read and apply **`../forge-grill/SKILL.md`**. One question at a time, recommended answer attached. The Grill sharpens terms into `LEXICON.md` and records genuine trade-offs in `DECISIONS.md`, inline.
3. **Capture** the expert's answer, or the new artifact the question prompted, into the chart.
4. **Re-deconstruct** with the new information. The map tightens; new, smaller gaps may surface. Turn again.

### This skill's heart: one gap per turn, and an honest verdict on readiness

Two judgements are the Forge's alone, because only it sees the whole:

- **Converge the spiral — do not let it sprawl.** Exactly one gap is pursued per turn: the most valuable thing still missing or still tacit. Never fan out into a questionnaire. This is what keeps the expert's effort minimal and the session finite.
- **Tell the truth about readiness.** The exit gate belongs to the expert — the loop continues until *they* declare it sufficient. But the Forge must give them an honest verdict: either *"the map is now complete enough to reconstruct from"* or *"a known gap still threatens the result, here is which one and why."* Never let the expert stop blind, and never declare completion on their behalf.

When the expert declares the extraction sufficient, Movement I closes and the chart is complete.

## Movement II — reconstruction (the Construtor, inline)

Read and apply **`reconstruct-protocol.md`** (in this skill's folder). It synthesises the new `SKILL.md` *for an AI executor* — function and rationale rather than surface form, the Lexicon embedded, progressive disclosure, scripts where the deconstruction found repeated deterministic work, the control structure chosen per the OUTCOME (point-4) — then validates it against realistic test prompts, iterating until the tests prove it. **Fidelity is the floor, not the ceiling:** it may improve on the expert's habitual way only as far as a trustworthy signal confirms it. It exposes the **eval harness** (test prompts + assertions) as the public socket Movement III consumes.

## The return edge — the skill is a prototype, not a finish line

Movement II ships a **prototype**, and the forge's work continues *through the skill's use*:

1. The skill runs on real requests; its **eval harness** is the instrument. When output misses the target, that is a **failure signal**.
2. **Each failure becomes a new gap** in `KNOWLEDGE-MAP.md`, written like any gap the Desmonte flags — but sourced from reality.
3. That gap **re-opens Movement I** on that one point: deconstruct → Grill → rebuild. The spiral turns again, now fed by use.

This is routed by **`../forge-handoff/SKILL.md`**: a real-use failure (often noticed in a different session) is logged to the handoff and a new gap to the chart, and the seam asks the user whether to re-open Movement I (`/forge-atelier`). "Enough" stays provisional — the expert's gate closes each round, but closing it ships a better prototype, never a frozen final.

## Movement III — auto-optimisation (a separate skill, by deliberate hand-off)

When the prototype has **matured** and shows promising results, the skill can be auto-optimised against its harness — Karpathy-style autoresearch. This is **a separate skill, `../forge-otimizador/SKILL.md`**, never run automatically: it is costly and the most Goodhart-prone step in the system. At the seam, the Forge **detects the moment and asks** the user to invoke `/forge-otimizador` (pointed at the matured skill + its harness via the handoff). It is not part of this skill's auto-run.

## When NOT to use this skill
- The task is a simple, well-specified job with no hidden expertise — use the lighter skill-creator.
- The user wants a quick answer or one-off output, not a reusable, reproducible method.
- There is no repeatable practice underneath — nothing to deconstruct.
- The expert cannot commit time across the session — extraction without engagement produces shallow, abandoned maps.

## The shape of a session, in one breath

> Deposit what exists (or admit there is almost nothing) → **say what good output looks like (`OUTCOME.md`) and pick lean or full** → the Desmonte breaks it into functions and finds the biggest hole → the Grill drills that one hole, sharpening words and logging trade-offs → re-deconstruct → repeat, one hole at a time, until you say "enough" and the Forge agrees the map can be built from → the inline Construtor writes the `SKILL.md` and tests it against the target → **ship the prototype and watch it run; each real failure becomes a new gap (routed by the handoff) and turns the spiral again** — and, when you choose, **`/forge-otimizador` autoresearches the working skill against its harness for more.** "Done" stays provisional.
