# Forge Atelier — architecture blueprint (v0.3)

> Design memory for the constellation. Lineage: v0.1–v0.2 (the monolith's blueprint) lives in `skill-forge-v2.1/docs/architecture-blueprint.md` — read it for the deep rationale of the three movements and the spiral. This document records what v0.3 changes and why; it does not repeat v2.1.

## Nuclear principle (unchanged)
Turn an expert's **tacit, lived practice** into an **explicit artifact** an AI executes at or above the expert's level — not a transcript of what they do, but a reconstruction designed for the AI. Most skills fail by **extraction** (the expert "dumps" text) or by **reconstruction** (the gesture is copied without its function). Every element exists to neutralise one such failure.

## The spine (unchanged): three movements
**I. Desmontar** (extraction — the Desmonte⇄Grill spiral) → **II. Remontar** (reconstruction + validation — the Construtor) → **III. Transcender** (auto-optimisation — the Otimizador). It is a **cycle, not a line**: Movement II ships a *prototype*; real-use failure re-opens Movement I (the return edge). "Done" is always provisional.

## What v0.3 changes (the constellation), and why
The monolith bundled all four protocols into one skill because "skills don't reliably invoke each other." That bundling forced **duplication** (the chart schema was copied into three files and had drifted) and made the pieces **un-reusable alone**. v0.3 splits the monolith into **cooperating peer skills**, resolving two build-decisions the monolith left explicitly open ("internal resource vs separate skill"; "one source, two packagings").

### The five locked decisions
1. **Lean constellation.** A thin `forge-atelier` orchestrator (owns the chart, runs Movements I+II) + standalone `forge-grill`, `forge-desmonte`, `forge-otimizador` + a thin `forge-handoff`. The **Construtor stays inline** in the orchestrator (see R5).
2. **Single source of truth per protocol — never copy.** The orchestrator *reads and applies* the components and `_shared/` by path. Mechanism = co-location + the `ATELIER-MAP.md` manifest. Trade-off: install-together (documented in `README.md`).
3. **Movement III extracted.** `forge-otimizador` is pointed at an *already-matured* skill + its harness; explicit start; a single reusable optimizer (the simple form — not the self-referential configuration). The self-referential "the forge optimises itself" configuration stays the **recursion horizon — locked, not built** (the most Goodhart-prone config of all).
4. **Method-vs-form reframing — HYPOTHESIS (the procedural mold is the default).** The discipline widens from "function, not surface *sequence*" to "function, not surface *form*." The Desmonte captures typed expertise-ingredients (framework, mental model, heuristic, feedback system, principle, background knowledge, system, procedure) **lazily — only when they exist**. The **OUTCOME (result quality vs. the expert) selects the control structure** (procedural / holistic / mixed). Both molds live at the atelier level, **never carried inside a produced skill**; a produced skill may be born simple and improve over time. *Flagged as a hypothesis: if it adds friction without payoff, the lazy ingredient capture lies dormant and the procedural default stands — zero cost. Validate before trusting it.*
5. **Detect-and-ask activation.** Ask at the seams (between skills) and before costly/outward/irreversible actions; routine internal steps just run; only the orchestrator auto-invokes; the Otimizador loop runs unattended once explicitly started. Enforced by `disable-model-invocation: true` on every component. Policy: `../_shared/activation-seams.md`.

### Handoff — new connective tissue
The constellation spans skills and sessions, so context must pass between them. The **chart is the payload** (referenced by path, never copied); `forge-handoff` writes a thin `FORGE-HANDOFF.md` (summary + pointers + suggested next skill) *outside* the workspace, and **routes real-use failures back to Movement I** (the return edge made concrete). Adapted from mattpocock's CONTEXT-MAP "single-vs-multi context pointer" pattern.

## Notes on specific choices
- **R5 — why the Construtor is inline, not a peer.** It has no standalone use today (unlike the Grill, which genuinely does), and it is tightly coupled to the chart and the test→iterate loop. Keeping it inside the orchestrator keeps the constellation lean. If a standalone use appears, extracting it is mechanical (same recipe as the Desmonte). Recorded here so the asymmetry reads as a decision, not an oversight.
- **Anti-duplication is the dogma.** `_shared/` is the single source of the chart schema and every file format; no protocol text is reproduced in two skills. The one apparent repeat — "function, not surface form" in both Desmonte and Construtor — is the method's deliberate symmetry (extraction vs reconstruction), not duplication.

## Source-of-truth lineage
- `skill-forge/` — the original (Movements I+II only). Forged the first content skills.
- `skill-forge-v2.1/` — the monolith with Movement III implemented; the substantive source this bundle is built on.
- `_archive/skill-forge-v2/` — superseded; archived 2026-06-02.
