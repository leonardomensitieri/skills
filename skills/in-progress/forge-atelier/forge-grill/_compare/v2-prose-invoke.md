---
name: forge-grill
description: Extract an expert's tacit method by relentless one-question-at-a-time interrogation. Movement I of forge-atelier. Runs the /grilling and /domain-modeling skills, aimed at a method rather than a code plan. Invoke explicitly (/forge-grill).
when_to_use: When a method lives partly in an expert's head and you need adversarial, scenario-driven questioning to make its tacit decision rules explicit — inside the forge spiral, or standalone to grill your own plan against your material.
disable-model-invocation: true
user-invocable: true
---

Run the `/grilling` skill and the `/domain-modeling` skill — aimed at an expert's *method*, not a code plan.

The "codebase" is the **material the expert has provided** (files, worked examples, transcripts) plus the maps already built about their method. Drag what they *know how to do* but *cannot easily say* into explicit, reproducible form. Interrogate in the expert's own language.

What forge-grill adds on top of those two skills:

- **Cheap-first:** if the provided material already answers a question, read it — don't ask. Each turn, spend the expert's effort only on the single most valuable *tacit* gap.
- **The spiral:** work as a co-routine — one gap per turn: interrogate the biggest gap, capture the answer, hand back so the method is re-deconstructed with the new information. Loop until the expert says "enough"; the exit gate is theirs.
- **When NOT to use:** a quick answer, a one-off question (no repeatable method), or an expert who hasn't committed any time.

## Example

> **Grill:** Your `FUNCTION-MAP.md` says part 2 is "check lead polarity" but not *why it's first*. My guess: a single cheap check rules out a whole class of false alarms before a costly interpretation — is that the function, or is it ordering for another reason?
> **Expert:** That's it — it's a gate. If it fails, everything downstream is suspect.
> **Grill:** Then "gate" is the canonical word, not "check" (writing it to the glossary now). And this looks like a real trade-off — worth an ADR. Shall I record it?
