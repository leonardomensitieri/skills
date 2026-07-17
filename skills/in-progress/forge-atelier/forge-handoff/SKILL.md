---
name: forge-handoff
description: Pass a forge in progress (or a shipped prototype) between sessions and conversations, and route real-use failures back into the forge. Writes/reads a thin FORGE-HANDOFF.md that points to the chart by path (never copies it) and names the next skill to invoke. A connective-tissue component of forge-atelier. Invoke explicitly (/forge-handoff).
when_to_use: When context is filling mid-forge, a session is ending, you're resuming a forge in a new conversation, a matured skill is ready for the Otimizador, or a forged skill failed in real use and that failure must re-open Movement I.
disable-model-invocation: true
user-invocable: true
---

> Connective-tissue component of **forge-atelier**. Thin by design. The chart (`forge-workspace/`, schema → `../_shared/chart-spec.md`) is the payload — referenced by path, never copied. Activation policy → `../_shared/activation-seams.md`. Adapts mattpocock's CONTEXT-MAP "pointer, not copy" pattern.

# Handoff — pass the forge between sessions, and route failures back in

The constellation spans skills and conversations. State lives in the chart on disk, but the chart holds *state*, not *where we are* or *what's next*. This skill carries that: a thin manifest that summarises, points (never copies), and names the next move.

## What it writes — `FORGE-HANDOFF.md`

Saved **outside** the workspace (one level up from `forge-workspace/`, beside the forged skill) so it survives independently of the chart. Everything is a **path, never inlined** — the discipline that keeps it reference-not-copy:

```
# Forge handoff — <forged skill name>

## Summary
<2-4 sentences: what the skill does, its OUTCOME target, lean/full, which mold
(procedural/holistic/mixed), current maturity>

## The chart (payload — referenced, not copied)
- chart:        ./forge-workspace/
- OUTCOME:      ./forge-workspace/OUTCOME.md
- eval harness: ./forge-workspace/eval-harness/
- Lexicon:      ./forge-workspace/LEXICON.md     (travels as runtime resource)
- Decisions:    ./forge-workspace/DECISIONS.md   (travels as human "why")

## Suggested next skill
<one of:>
- /forge-atelier      — resume the forge (Movement I/II unfinished, or a return-edge re-entry)
- /forge-otimizador   — skill has matured + harness is trustworthy → autoresearch it

## Open gaps / known residue
<the KNOWLEDGE-MAP gaps the expert chose to ship with, if any>

## Return-edge log (real-use failures → new gaps)
- <date> <failure observed in real use> → new gap: <...>  (status: open | folded back)
```

## What it does — three jobs

1. **Save a handoff** (session ending / context filling): summarise the current state, point to the chart, set the suggested next skill, write `FORGE-HANDOFF.md`.
2. **Resume from a handoff** (new session/conversation): read `FORGE-HANDOFF.md`, locate the chart by its paths, summarise where things stand, and — at the seam — **ask** the user whether to invoke the suggested next skill (`../_shared/activation-seams.md`). Do not auto-invoke it.
3. **Route a real-use failure back in (the return edge):** when a forged skill misses its target in real use,
   - append a row to the **Return-edge log** with the failure;
   - write it as a **new gap** in the chart's `KNOWLEDGE-MAP.md` (gap-block format per `../_shared/FUNCTION-MAP-FORMAT.md`);
   - flip **Suggested next skill** to `/forge-atelier`, and at the seam **ask** the user whether to re-open Movement I on that gap.

That third job is why this is a skill and not merely a file format: it is the concrete mechanism of the forge's return edge.

## Discipline
- **Reference, never copy.** Every chart artifact is a path. If you find yourself pasting chart content into the handoff, stop — the handoff points.
- **Never auto-invoke the next skill.** The handoff *suggests*; the user *invokes* (platform: skills don't call each other).
- **Lazy.** Write `FORGE-HANDOFF.md` when there is a real handoff to make (session boundary, maturity, or a failure) — not on every turn.
