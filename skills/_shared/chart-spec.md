# The chart — `forge-workspace/` (single source of the schema)

> Referenced by the orchestrator and every component. **Do NOT redefine this schema anywhere else — point to this file.** (In v2.1 this block was copied into three files and had already drifted; one source ends that.)

The Forge owns one shared state, the **chart**. It is the single source of truth for a forging session; no session state lives anywhere else.

```
forge-workspace/
├── OUTCOME.md          ← what "good output" from the finished skill looks like — the quality target
├── PROCESS-MAP.md      ← the external view of the flow
├── FUNCTION-MAP.md     ← each part + its function + true dependencies (not the expert's surface form)
├── KNOWLEDGE-MAP.md    ← what is known vs. still missing (the ranked gaps)
├── INGREDIENTS.md      ← (lazy) typed expertise-ingredients, only if any surface — see INGREDIENTS-FORMAT.md
├── LEXICON.md          ← canonical terms (grows by merge) — see LEXICON-FORMAT.md
├── DECISIONS.md        ← append-only log of real trade-offs — see DECISIONS-FORMAT.md
└── eval-harness/       ← (Movement II output) test prompts + assertions; the socket Movement III consumes
```

## The one discipline that governs the chart files
**Create files lazily — only when there is something to record. Never scaffold an empty file.** Write `FUNCTION-MAP.md` once there is a first decomposition; create `LEXICON.md` when the first term is canonicalised; create `DECISIONS.md` when the first genuine trade-off crystallises; create `INGREDIENTS.md` only if a non-step ingredient actually surfaces (most simple methods surface none — that is correct).

## Per-file formats (each a single source in `_shared/`)
- `FUNCTION-MAP.md` entries → `FUNCTION-MAP-FORMAT.md`
- `LEXICON.md` entries → `LEXICON-FORMAT.md`
- `DECISIONS.md` entries → `DECISIONS-FORMAT.md`
- `INGREDIENTS.md` entries → `INGREDIENTS-FORMAT.md`

## What travels with a forged skill (its institutional memory)
When Movement II ships the skill, three chart artifacts travel with it: the **Lexicon** (as a runtime resource the executor loads for vocabulary), the **Decisions** (as human-facing "why" for whoever edits it later — not runtime), and the **eval-harness** (exposed publicly; the socket the Otimizador and the return edge consume).
