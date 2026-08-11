> Bundled resource — applied by the forge during Movement II (reconstruction + validation).

# Construtor — reconstruct a method into a tested skill

Run the `/skill-creator` skill to actually write and structure the `SKILL.md` — frontmatter, progressive disclosure, packaging scripts, and its test→evaluate→iterate discipline. `/skill-creator` owns *how to author a skill*. This protocol does not re-describe that; it adds only what the forge needs on top: **consume the chart, choose the mold, hold the fidelity floor.** Produce any expert-facing output in the expert's own language.

## Consume the chart — do not re-interview, do not fabricate

The input is the completed `forge-workspace/` chart: `PROCESS-MAP.md`, `STEP-FUNCTION-MAP.md`, `KNOWLEDGE-MAP.md`, `CONTEXT.md` (the glossary), `docs/adr/` (the "why"). The method content comes from there — never from a fresh interview (that was Movement I).

Encode each instruction as its **function and reason**, in the **true dependency order** the Desmonte found — not the expert's habitual surface sequence. A `SKILL.md` that transcribes the *surface* reads, to an executing AI, as rules with no rationale, and a model given rules without reasons generalises badly. Embed `CONTEXT.md` as the executor's vocabulary (progressive disclosure — loaded on demand); the ADRs travel with the skill as human-facing "why", not runtime instructions.

If the chart has a hole — a step whose function is blank, a branch with no condition, a term never canonicalised — that is a signal Movement I was not finished. **Flag it back to extraction; never invent the missing piece.** A fabricated instruction ships looking authoritative and is worse than an admitted gap.

## Choose the mold

A skill is an *ability*, not necessarily a procedure. Judge whether matching the expert's result needs a **procedure** (the default), **holistic judgement** no sequence captures, or a **mix**. Default to procedural unless the captured method and its results show the ability does not come from a sequence.

## The fidelity floor — and the only license to cross it

Reconstruct faithfully by default: **fidelity is the floor.** Diverge from the expert's habitual way *only* when a **measurable, observable** signal proves the divergence is actually better — the eval harness, a pass-rate, something you can watch improve across runs. It need not be an exact number, but it can never be unfalsifiable. **No measurement, no divergence.**

## Validate and hand off

Write realistic test prompts (the kind a real user sends), spanning the method's branches. Run the executor-with-the-draft and evaluate two ways: *qualitative* — read the output **and the transcript** (right thing done, effort not wasted); *quantitative* — assertions turned into a pass rate wherever output is verifiable. The decisive test is the forge's whole thesis: *does this make a generalist AI produce expert-level output on these cases?* **Reserve some cases** — do not tune against every test, or the skill overfits its own exam. Expose the **eval harness** (prompts + assertions) as the public socket Movement III consumes.
