> Bundled resource — applied by the forge during Movement I (the interrogation co-routine).

# Grill — tacit-method extraction

Run the `/grilling` skill and the `/domain-modeling` skill — turned on an expert's *method* so it can be forged into a skill. Interrogate in the expert's own language.

- `/grilling` owns the interrogation mechanics: one question at a time, a recommended answer attached to each, scenario-driven, walking the decision tree one dependency at a time.
- `/domain-modeling` owns the vocabulary and the trade-off log: it canonicalises terms into `CONTEXT.md` and records genuine trade-offs as ADRs in `docs/adr/`.

This protocol does not re-describe either — it invokes them, and adds only what the forge needs on top.

## What the forge adds on top

- **Neutralise the dump.** The failure it exists to kill: an expert who pastes text and expects a working skill. Tacit knowledge yields to adversarial, one-at-a-time, scenario-driven questioning — not to a single open question.
- **Cheap-first.** If the material the expert already provided (files, worked examples, transcripts) or the current `STEP-FUNCTION-MAP.md` already answers a question, look it up — do not ask. Each turn, spend the expert's effort only on the single most valuable *tacit* gap.
- **The spiral.** Work as a co-routine — one gap per turn: interrogate the biggest gap, capture the answer, hand back so the method is re-deconstructed with the new information.
- **Honest exit.** The exit gate is the expert's — loop until *they* say "enough." But tell them honestly when the map is complete enough to reconstruct from, and when a known gap still threatens the result.
- **When NOT to use:** a quick answer, a one-off question (no repeatable method), or an expert who has not committed any time.

## A short example of the texture

> **Grill:** Your `STEP-FUNCTION-MAP.md` says step 2 is "check lead polarity." Your material doesn't say *why that step is first*. My guess: it's first because a single cheap check rules out a whole class of false alarms before you commit to a costly interpretation — is that the function, or is it ordering for some other reason?
> **Expert:** That's it — it's a gate. If it fails, everything downstream is suspect.
> **Grill:** Then "gate" is the canonical word, not "check." Recording it to `CONTEXT.md` now. And this looks like a real trade-off (you *could* interpret first and validate later) — worth an ADR. Shall I record it?
