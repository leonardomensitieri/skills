> Bundled resource — the forge's Movement II reconstruction. Inherits `/skill-creator`.

# Construtor — reconstruct a method into a tested skill

Run the `/skill-creator` skill to actually write and structure the `SKILL.md` — frontmatter, progressive disclosure, packaging scripts, and its test→evaluate→iterate discipline. `/skill-creator` owns *how to author a skill*. This protocol adds only what the forge needs on top: **consume the chart, choose the mold, hold the fidelity floor.** Produce any expert-facing output in the expert's own language.

## Consume the chart — do not re-interview, do not fabricate

Build from the chart: `STEP-FUNCTION-MAP.md`, `KNOWLEDGE-MAP.md`, `CONTEXT.md` (the glossary), `docs/adr/` (the "why"). The method content comes from there — never from a fresh interview (that was Movement I). Encode each instruction as its **function and reason**, in the **true dependency order** the Desmonte found — not the expert's surface sequence. Embed `CONTEXT.md` as the executor's vocabulary; the ADRs travel with the skill as human-facing "why", not runtime instructions.

If the chart has a hole — a step whose function is blank, a branch with no condition, a term never canonicalised — Movement I was not finished. **Flag it back; never invent the missing piece.**

## Choose the mold

A skill is an *ability*, not necessarily a procedure. Judge whether matching the expert's result needs a **procedure** (the default), **holistic judgement** no sequence captures, or a **mix**. Default to procedural unless the captured method shows the ability doesn't come from a sequence.

## The fidelity floor — and the only license to cross it

Reconstruct faithfully by default: **fidelity is the floor.** Diverge from the expert's habit *only* when a **measurable, observable** signal proves it's better — the eval harness, a pass-rate, something you can watch improve. It need not be an exact number, but never unfalsifiable. **No measurement, no divergence.**

## Validate and hand off

Write realistic test prompts spanning the method's branches. Evaluate two ways: *qualitative* — read the output **and** the transcript; *quantitative* — assertions → pass rate where output is verifiable. The decisive test: *does this make a generalist AI produce expert-level output?* **Reserve some cases** — don't tune against every test. Expose the **eval harness** as the public socket Movement III consumes.
