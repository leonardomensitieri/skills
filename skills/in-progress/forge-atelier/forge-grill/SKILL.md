---
name: forge-grill
description: Extract an expert's tacit method by relentless one-question-at-a-time interrogation, so it can be forged into a skill. Movement I of forge-atelier. Runs the /grilling and /domain-modeling skills. Invoke explicitly (/forge-grill).
when_to_use: When a method lives partly in an expert's head and you need adversarial, scenario-driven questioning to make its tacit decision rules explicit — inside the forge spiral, or standalone to grill your own plan against your material and code.
disable-model-invocation: true
user-invocable: true
---

Run the `/grilling` skill and the `/domain-modeling` skill — turned on an expert's *method* so it can be forged into a skill.

Grill against **everything the environment offers**: the codebase, filesystem, tools, AND the material the expert has provided (files, worked examples, transcripts) plus the maps already built about their method. The codebase is never out of scope — a forged skill is itself a code artifact (a `SKILL.md`, scripts, bundled resources applied to a codebase), so grilling a method means grilling the code it will become, too. The job: drag what the expert *knows how to do* but *cannot easily say* into explicit, reproducible form. Interrogate in the expert's own language.

What forge-grill adds on top of those two skills:

- **Neutralise the dump.** The failure it exists to kill: an expert who pastes text and expects a working skill. Tacit knowledge yields to adversarial, one-at-a-time, scenario-driven questioning — not to a single open question.
- **Cheap-first.** If the environment or the provided material already answers a question, look it up — don't ask. Each turn, spend the expert's effort only on the single most valuable *tacit* gap.
- **The spiral.** Work as a co-routine — one gap per turn: interrogate the biggest gap, capture the answer, hand back so the method is re-deconstructed with the new information.
- **Honest exit.** The exit gate is the expert's — loop until *they* say "enough." But tell them honestly when the map is complete enough to reconstruct from, and when a known gap still threatens the result.
- **When NOT to use:** a quick answer, a one-off question (no repeatable method), or an expert who hasn't committed any time.

## Example

See [`examples/grill-session.md`](./examples/grill-session.md) for a worked grill exchange.
