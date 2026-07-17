# Activation — the detect-and-ask policy (single source)

> Referenced by every skill in the atelier. One rule, stated once. (Platform fact: skills do not call each other programmatically — so a handoff is always a *suggestion to the user*, never a silent jump.)

**Ask at the seams; run the routine.**

- **Auto-invoke:** only `forge-atelier` (the entry skill) may fire on its own. Every component is `disable-model-invocation: true` — it can never fire silently.
- **At a seam between skills** (Movement I → II, II → handoff, handoff → Otimizador, a return-edge re-entry): detect the moment and **ask** the user to invoke the next `/forge-…` skill.
- **Before costly / outward / irreversible actions** (writing the final SKILL.md, starting the Otimizador loop, promoting/shipping): **ask first.**
- **Routine internal steps** (re-deconstruct a turn, write a Lexicon entry, append a Decision, ask the Grill's one question): **just run** — do not nag.
- **Once a costly action is explicitly started** (e.g. the Otimizador loop): it runs **unattended** to its stopping criterion. Asking happens *before* the start and *after* the end — never inside.
