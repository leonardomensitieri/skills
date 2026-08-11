> Bundled resource — the forge's Movement I interrogation. Inherits `/grilling`.

# Grill — tacit-method extraction

Run the `/grilling` skill and the `/domain-modeling` skill — turned on an expert's *method* so it can be forged into a skill. Interrogate in the expert's own language.

- `/grilling` owns the interrogation mechanics: one question at a time, a recommended answer attached, scenario-driven, walking the decision tree one dependency at a time.
- `/domain-modeling` owns the vocabulary and the trade-off log: canonical terms into `CONTEXT.md`, genuine trade-offs as ADRs in `docs/adr/`.

This protocol does not re-describe either — it invokes them, and adds only what the forge needs on top:

- **Neutralise the dump.** The failure it kills: an expert who pastes text and expects a working skill. Tacit knowledge yields to adversarial, one-at-a-time, scenario-driven questioning — not a single open question.
- **Cheap-first.** If the material the expert provided or the current `STEP-FUNCTION-MAP.md` already answers a question, look it up — don't ask. Spend the expert's effort only on the single most valuable *tacit* gap.
- **The spiral.** One gap per turn: interrogate the biggest gap, capture the answer, hand back so the method is re-deconstructed with the new information.
- **Honest exit.** The exit gate is the expert's — loop until *they* say "enough." But tell them honestly when the map can be reconstructed from, and when a known gap still threatens the result.
- **When NOT to use:** a quick answer, a one-off question (no repeatable method), or an expert who hasn't committed any time.
