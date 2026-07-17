> Movement II of **forge-atelier** — the Construtor, **inline** (it has no standalone use yet; if one appears, extracting it is mechanical — same recipe as the Desmonte). The orchestrator reads and applies this file. Shared sources by path: chart → `../_shared/chart-spec.md`; formats → `../_shared/*-FORMAT.md`.

# Construtor — reconstruct a method into a tested skill

This is the reassembly half of the forge; it draws on the skill-creator's reconstruction and evaluation discipline, specialised to consume a completed deconstruction chart instead of interviewing intent from scratch. It is the exact mirror of the Desmonte: the Desmonte broke the method into functions and dependencies; the Construtor rebuilds *from those functions* into an artifact for an AI.

**Produce any expert-facing output in the expert's own language.** This body is in English for robustness; the artifact and the dialogue are not bound to it.

## This skill's heart: encode function and reason, not surface gesture — and prove it before declaring done

Two principles, the second guarding the first.

**Reconstruct for the executor, not as a transcript of the speaker.** A SKILL.md that faithfully transcribes how the expert *described* their steps reads, to an executing AI, as a pile of rules with no rationale — and a model given rules without reasons generalises badly. The chart holds what matters: each part's *function* and the *why* (from `FUNCTION-MAP.md` and `DECISIONS.md`). Preserve those. Write each instruction as its function and reason, in the true dependency order the Desmonte found — **not** the expert's habitual surface form. This is the same "function, not surface form" discipline as the Desmonte, now carried into the artifact: it is precisely what lets a generalist AI match or exceed the expert on cases the examples never showed. Collapse back to bare ordered steps and you have rebuilt the surface, and capped the skill below the expert.

**The artifact is done when tests prove it, not when it reads well.** A SKILL.md can be elegant and still make the executor do the wrong thing. Readiness is a test result, not an impression.

## Choose the mold from the OUTCOME, not from habit (point-4)

A skill is an *ability*, not necessarily a procedure. Build the control structure the OUTCOME selected (see the orchestrator's OUTCOME step):
- If Movement I captured typed **ingredients** (mental models, heuristics, principles, a framework — `INGREDIENTS.md`), encode *those* — the skill can be a body of judgement with few steps, not only an ordered procedure.
- If it captured only steps, build the **procedural** skill — the default, and the graceful fallback when the signal is thin.

Match the structure to what produces the expert's result; do not force a procedure onto judgement, nor judgement-prose onto a genuine procedure.

## Fidelity is the floor, not the ceiling

The default is faithful reconstruction: encode the method as the chart records it. But fidelity is the **floor**, not the **ceiling** — the job is the best *result* against `OUTCOME.md`, not a museum copy of habits, and a generalist AI can sometimes **beat the human method** when there is trustworthy measurement to prove it.

The hard guard — **diverge only when the quality signal is trustworthy:**
- **Strong, verifiable signal** (output checkable, harness has real coverage) → measured divergence is allowed, and is the path to *exceeding* the expert.
- **Weak signal, high stakes** (e.g. reading an ECG) → optimising hard against a thin proxy invites **Goodhart**; there, **fidelity wins ties and the expert stays in the loop as a safety requirement, not a preference.**

In short: **measurement licenses divergence.** No trustworthy measurement → reconstruct faithfully, and let Movement III's collaborative track explore quality later.

## Input — read the chart; do not re-interview, do not fabricate

The input is the completed chart (schema → `../_shared/chart-spec.md`): `PROCESS-MAP.md`, `FUNCTION-MAP.md`, `KNOWLEDGE-MAP.md`, `INGREDIENTS.md` (if any), `LEXICON.md`, `DECISIONS.md`, `OUTCOME.md`. The content comes from there. Do **not** go back to the expert for method content — that was Movement I's job.

If the chart has a hole — a part whose function is blank, a branch with no condition, a term never canonicalised — that is a signal Movement I was not finished. **Flag it back to extraction. Never paper over a gap by inventing the missing piece.** A fabricated instruction is worse than an admitted gap, because it ships looking authoritative.

## Reconstruct the SKILL.md

Build it in three parts, for an AI executor, under progressive disclosure.

- **The description (the trigger).** Decide the invocation mode: auto-invoked (the common case for a useful domain skill — a deliberately insistent description covering the implicit contexts where it should fire) or explicit. Default to auto-invoked with a strong description; the Otimizador tunes it later in Movement III.
- **The body.** Each part as its *function and why*; the *true dependencies and branches* (not surface form); the canonical vocabulary from `LEXICON.md` embedded; rationale stated, because the model generalises better when it understands purpose. Shape the control structure per the OUTCOME (above).
- **Scripts and resources.** Where the Desmonte flagged *repeated deterministic work*, package it as a script so the executor does not reinvent it each run.

**Progressive disclosure — three layers:** metadata (name + description) always in context; the body loaded when the skill triggers; heavy resources loaded only on demand. Embed the **Lexicon** as a resource the executor loads when it needs the vocabulary. The **Decision Records travel with the skill too, but as human-facing memory** — they document *why* the skill is shaped as it is for whoever edits it later; not runtime instructions.

## Validate — test, evaluate, iterate

1. **Write realistic test prompts** — the kind a real user would send, spanning the method's branches. A few.
2. **Run the executor-with-the-draft and evaluate two ways.** *Qualitative:* read the output **and the transcript** — does it do the right thing, and avoid wasting effort? *Quantitative,* wherever the output is verifiable: write assertions and turn them into a pass rate. The decisive test is the forge's whole thesis: *does this skill make a generalist AI produce expert-level output on these cases?*
3. **Rewrite and iterate** against what the tests reveal. **Reserve some cases** — do not tune against every test, or the skill overfits. (This reserved split is what Movement III's autoresearch leans on.)

## Output — expose the eval harness, then hand off

Produce the validated `SKILL.md` (+ scripts, + Lexicon and Decisions travelling along, per `../_shared/chart-spec.md`), and **expose the eval harness** (test prompts + assertions) in `forge-workspace/eval-harness/` as a public artifact — the socket Movement III consumes. Then write the handoff (apply `../forge-handoff/SKILL.md`): a prototype shipped, the chart referenced, the suggested next step recorded. Movement III is run later, explicitly, only when the skill has matured.

## When NOT to use this skill
- There is no chart yet — the method has not been extracted. Do Movement I first.
- The task is a simple skill from scratch with no hidden expertise and no chart — use the lighter skill-creator.
- The goal is to pull a method *out* of an expert — that is extraction (the Desmonte and the Grill), not reconstruction.

## A short example of the texture

> The chart's `FUNCTION-MAP.md` has part P2 — function: *"a cheap gate that rules out electrode-swap before any costly interpretation"*; branch (filled by the Grill): *if DI negative and aVR positive, suspect swap; distinguish from dextrocardia by precordial R-wave progression.*
>
> **Transcript reconstruction (wrong):** "Step 2: check lead polarity." — surface gesture, no reason. The executor will not know why it matters or what to do when it fails, and will not generalise.
>
> **Functional reconstruction (right):** "Before interpreting, gate on lead polarity — this cheaply rules out an electrode swap that would invalidate everything downstream. If DI is negative with aVR positive, suspect a right/left arm swap *before* dextrocardia, and distinguish them by precordial R-wave progression (preserved in a swap, lost in dextrocardia)." — function and reason intact, in dependency order.
>
> **Test prompt + assertion:** *"Here is an ECG: DI negative, aVR positive, normal precordial progression…"* → asserts the skill flags electrode swap *before* dextrocardia. If it reaches for dextrocardia first, the reconstruction lost the function — iterate.
