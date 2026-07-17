---
name: forge-desmonte
description: Functional deconstruction of an expert's method — break it into its parts, reduce each to its function and true dependencies (not the expert's surface form), and surface the ranked gaps that block reconstruction. A Movement I component of forge-atelier; also usable alone to reverse-engineer or audit an existing method or skill. Invoke explicitly (/forge-desmonte).
when_to_use: When you have material about a method (files, worked examples, a current process map) and need a functional teardown — what each part does, what truly depends on what, and where the map cannot yet be rebuilt from (the gaps). Used inside the forge spiral, or standalone to analyse or audit a method without forging a whole skill.
disable-model-invocation: true
user-invocable: true
---

> Movement I component of **forge-atelier** (the deconstruction co-routine). This file is the **single source** of the Desmonte protocol — the orchestrator reads and applies it; it is never copied. Shared sources, read by path: chart → `../_shared/chart-spec.md`; part format → `../_shared/FUNCTION-MAP-FORMAT.md`; ingredient format → `../_shared/INGREDIENTS-FORMAT.md`.

# Desmonte — functional deconstruction of an expert's method

This adapts the deconstruction core of the four-phase study method (the "wooden sphere") **with its polarity inverted**.

In the study method, a *human* disassembles *external* knowledge and reassembles it in their *own mind*; the assistant is a Socratic coach who deliberately *withholds* answers so the learner rediscovers them. Here it is the reverse on every axis: the *system* disassembles the *expert's* method, the reassembly target is a *machine artifact* (a skill, not understanding in a head), and the assistant **actively analyses, decomposes, and proposes** — it does not withhold. The expert is already the master; nothing needs to be internalised. The job is to get the method *out* of them and understand it well enough to rebuild it.

The metaphor still holds: a method you can only *describe* is an assembled sphere you have not yet taken apart. You do not understand it until you can disassemble it, see how each piece fits and why, and rebuild it yourself. Recognition of the surface is not understanding.

**Communicate any expert-facing output in the expert's own language.** This body is in English for robustness; what the expert reads is not.

## The one discipline that matters most: function, not surface FORM

The failure this skill exists to prevent: a skill that mirrors *the form the expert happens to present the method in* — its order, but also its surface shape (a checklist because the expert keeps a checklist; a linear recipe because they described it linearly) — copying gestures without grasping why. Such a skill works on the examples and shatters on everything else, and never reaches the expert's level.

So the whole job is to get *underneath* the observed form to the **function** of each part and the **true dependencies** between parts. The form an expert performs things in is often habit, convenience, or how they were taught — not the real constraint. Only the functional decomposition generalises beyond the examples, and only generalisation lets the reconstruction match or exceed the expert.

> **Form is wider than sequence (point-4 hypothesis — flagged).** The original discipline said "function, not surface *sequence*." It is widened here to "function, not surface *form*," because some expertise is not step-shaped at all (a framework of lenses, a body of heuristics, a feedback system). The **procedural/sequence mold remains the graceful default**: if nothing richer surfaces, decompose into parts + dependencies exactly as before — it costs nothing. The wider framing earns its keep only when the method genuinely is not a procedure. Do not force non-procedural structure where a procedure is the honest answer.

## The procedure

Run this against the method as currently expressed — the material the expert provided plus the current `PROCESS-MAP.md` and any answers already captured by the Grill.

1. **Disassemble into discrete parts.** Identify the atomic actions and decisions of the method. Split anything that is secretly two parts; merge anything that is artificially divided. ("Part" is general — usually a step, but it can be a gate, a lens, a branch, a parallel path, or a loop.)
2. **Determine each part's function.** For every part, answer: *What does it accomplish? Why does it exist? What would break downstream without it? What does it consume (inputs)? What does it produce (outputs)? What must precede it?*
2.5. **Capture typed expertise-ingredients — only where they actually exist (LAZY).** As you decompose, some methods reveal things that are *not* steps: a framework, a mental model, a heuristic, a feedback system, a principle, background knowledge, a system. When — and only when — one is genuinely present in the material, record it in `INGREDIENTS.md` with its type (format: `../_shared/INGREDIENTS-FORMAT.md`). **Do not hunt for one of each; do not scaffold an empty list.** Most simple methods surface none beyond procedures, and that is correct — the cheap-first rule, applied to ingredients. A skill may be born a mere procedure and grow ingredients over time.
3. **Build the dependency graph, not a list.** Surface where the seemingly linear practice actually has branches, gates, parallel paths, or loops. Separate *true* ordering constraints (B genuinely needs A's output) from *habitual* ordering (the expert just does A first).
4. **Attempt reconstruction.** Ask yourself: *could the method be rebuilt from this map alone, by someone who is not the expert?* Walk it forward mentally against the expert's own examples.
5. **Where reconstruction fails, that failure is a gap.** A part whose function is unclear, a dependency that does not resolve, an input that appears from nowhere, a branch whose condition is unstated — each is a gap. Mark them explicitly in `KNOWLEDGE-MAP.md`, biggest first.

## The clean boundary with the Grill

**The Desmonte does not interrogate the expert — that is the Grill's role.** Exhaust the material first (this is the cheap-first rule seen from the other side: the Desmonte squeezes everything possible out of what already exists). When the material genuinely cannot resolve something, *do not ask* — mark it as a gap and let the spiral route it to the Grill.

This keeps the two co-routines cleanly separated: **the Desmonte analyses and flags; the Grill asks.** Each turn of the spiral: the Desmonte produces the current `FUNCTION-MAP.md` and a ranked gap list → the Grill takes the biggest gap, interrogates the expert, captures the answer → the Desmonte runs again with the new information, and the map tightens. The loop closes inward until the expert declares the extraction sufficient.

## Workspace and formats (single sources — read by path, not copied)
- The chart schema (`forge-workspace/`, including `FUNCTION-MAP.md`, `KNOWLEDGE-MAP.md`, `INGREDIENTS.md`) → `../_shared/chart-spec.md`.
- This skill's main output is `FUNCTION-MAP.md` — entry format and the ranked-gap block in `../_shared/FUNCTION-MAP-FORMAT.md`.
- Typed ingredients (when any) → `INGREDIENTS.md`, format `../_shared/INGREDIENTS-FORMAT.md`.
- Create files lazily — write `FUNCTION-MAP.md` once there is a first decomposition; do not scaffold empty.

## When NOT to use this skill
- The goal is to *study* material and internalise it yourself — use the four-phase study method; its polarity is the one you want.
- There is no repeatable method underneath — a one-off task has no functional graph to recover.
- The user only wants a summary of a process, not a decomposition rigorous enough to rebuild from.

## A short example of the texture

> **Desmonte (analysing the material):** The expert's notes do step A (acquire), then B (check polarity), then C (interpret). On the surface that is a linear chain. But B's output ("polarity valid / suspect") is consumed by C, while A's output feeds both B and C. So the true graph is A → {B, C}, with B *gating* C — not a flat A → B → C. **Surface ≠ function:** the expert lists B second out of habit; functionally it is a gate on C.
> *Map updated. One thing the material cannot tell me:* when B comes back "suspect," does the method halt, or branch to a correction path? The examples never show a suspect case.
> **→ Gap G1 (to Grill):** unstated branch when the polarity gate fails. Blocks reconstruction — the skill would not know what to do in the case the expert clearly handles by reflex.
