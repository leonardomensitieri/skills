---
name: forge-grill
description: Relentless one-question-at-a-time interrogation that drags tacit method out of an expert into explicit, reproducible form — sharpening vocabulary and logging real trade-offs as they surface. A Movement I component of forge-atelier; also usable standalone to stress-test your own plan against your material and documented decisions. Invoke explicitly (/forge-grill).
when_to_use: When a method is partly in the expert's head and the material can't resolve a gap — you need adversarial, scenario-driven questioning to make tacit decision rules explicit. Used inside the forge spiral (one gap per turn), or standalone to grill a plan against existing docs/code (the original grill-with-docs use).
disable-model-invocation: true
user-invocable: true
---

> Movement I component of **forge-atelier** (the interrogation co-routine). This file is the **single source** of the Grill protocol — the orchestrator reads and applies it; never copied. Shared sources, read by path: chart → `../_shared/chart-spec.md`; Lexicon format → `../_shared/LEXICON-FORMAT.md`; Decisions format + when-to-record → `../_shared/DECISIONS-FORMAT.md`.

# Grill — tacit-method extraction by relentless interrogation

This adapts the grilling discipline from stress-testing *code* to extracting an *expert's method*. The "codebase" becomes the **material the expert has provided** (files, worked examples, transcripts, prior artifacts) plus the **maps already built** about their method. The job is to drag what the expert *knows how to do* but *cannot easily say* into explicit, reproducible form.

It exists to neutralise one specific failure: the expert who "dumps" text and expects a working skill. Tacit knowledge does not surrender to a single open question — it surrenders to adversarial, one-at-a-time questioning guided by concrete scenarios. That is the whole engine here.

**Conduct the interrogation in the expert's own language** (the language they are writing to you in). This body is in English for robustness; the dialogue is not.

## The core loop

Interrogate the expert relentlessly about every aspect of their method until you reach a shared, explicit understanding. Walk down each branch of the method's decision tree, resolving dependencies between decisions one by one. **For each question, propose your recommended answer** — never ask a bare question; ask a question with your best guess attached, so the expert is correcting rather than composing from scratch.

Ask **one question at a time**, and wait for the answer before continuing. A wall of ten questions makes the expert skim; one sharp question gets a precise answer.

### The cheap-first rule — this is what keeps the session from being a burden

**If a question can be answered by exploring the material the expert already provided, explore the material instead of asking.** Read the provided files, the worked examples, the transcripts, and the current `FUNCTION-MAP.md` *before* forming a question. Each turn, spend the expert's effort only on the *single most valuable thing that is genuinely missing or genuinely tacit* — never on something already sitting in the material. This is the rule that lets an expert with almost nothing written participate without a homework dump, and lets an expert with rich documentation skip straight to the gaps.

## Place in the spiral

The Grill is a **co-routine**, not a one-shot. Each turn: read the current maps (chart schema → `../_shared/chart-spec.md`) → find the biggest gap → interrogate *only that* → the answer (or a newly provided artifact) is captured → hand back so the method can be **re-deconstructed** with the new information. The spiral closes inward until the expert declares "enough." (Standalone, the same loop works for one person grilling their own plan against their own material — that is the original grill-with-docs use case.)

## During the session

### Challenge against the Lexicon
When the expert uses a term that conflicts with an existing entry in `LEXICON.md`, call it out immediately. *"Your Lexicon defines 'descompensação' as X, but here you seem to mean Y — which is it?"* A method whose vocabulary drifts produces a skill whose instructions are ambiguous, and an ambiguous skill never reaches the expert's level.

### Sharpen fuzzy language
When the expert uses a vague or overloaded term, propose a precise canonical term on the spot. *"You keep saying 'o caso grave' — do you mean haemodynamically unstable, or anatomically complex? Those trigger different paths."* Precision in the Lexicon is precision in the final skill.

### Discuss concrete scenarios
When a part or a boundary between concepts is being discussed, stress-test it with an invented edge-case scenario that forces the expert to be precise. *"You said you check A before B. Walk me through the case where A and B both present at once — what actually decides the order?"* Scenarios are how tacit decision rules become explicit ones.

### Cross-reference with the material
When the expert states how something works, check whether their provided examples and artifacts agree. Surface every contradiction. *"You just said partial cases get referred out, but example #3 in your material was managed in-house — which is the real rule?"* The contradiction is usually where the most valuable tacit knowledge is hiding.

### Update LEXICON.md inline
When a term is resolved, write it to `LEXICON.md` right there (format: `../_shared/LEXICON-FORMAT.md`). Do not batch terms to capture later — capture them as they happen, or they are lost.

### Record decisions sparingly
Record a Decision in `DECISIONS.md` only when it meets **all three** criteria in `../_shared/DECISIONS-FORMAT.md` (hard to reverse; surprising without context; the result of a real trade-off). Most exchanges produce no Decision, and that is correct.

## Knowing when to stop

The exit gate belongs to the expert: the loop continues until **they** declare the extraction sufficient. Do not declare it yourself. But do tell them, honestly, when you believe the map is complete enough to reconstruct from — and when you believe a known gap still threatens the result.

## When NOT to use this skill
- The user wants a quick answer, a summary, or a single clarification — just answer.
- There is no method to extract (a one-off question, not a repeatable practice).
- The expert has not committed any time — grilling without engagement produces shallow, abandoned maps.

## A short example of the texture

> **Grill:** Your `FUNCTION-MAP.md` says part 2 is "check lead polarity." Your material doesn't say *why that part is first*. My guess: it's first because a single cheap check rules out a whole class of false alarms before you commit to a costly interpretation — is that the function, or is it ordering for some other reason?
> **Expert:** That's it — it's a gate. If it fails, everything downstream is suspect.
> **Grill:** Then "gate" is the canonical word, not "check." Writing to Lexicon now. And this looks like a real trade-off (you *could* interpret first and validate later) — worth a Decision Record. Shall I record it?
