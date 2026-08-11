---
name: forge-handoff
description: Pass a forge in progress (or a shipped prototype) between sessions, and route real-use failures back into the forge. Runs the /handoff skill, specialised for the forge's chart and its return edge. A connective-tissue component of forge-atelier. Invoke explicitly (/forge-handoff).
when_to_use: When context is filling mid-forge, a session is ending, you're resuming a forge in a new conversation, a matured skill is ready for the Otimizador, or a forged skill failed in real use and that failure must re-open Movement I.
disable-model-invocation: true
user-invocable: true
---

Run the `/handoff` skill — specialised for a forge in progress (or a shipped prototype). Save the manifest **beside the forged skill** (one level up from `forge-workspace/`), not in the OS temp dir, so it survives with the chart. Two things the forge adds on top of `/handoff`.

## The payload is the chart — referenced, never copied

Everything is a path. If you find yourself pasting chart content into the handoff, stop — the handoff points.

```
- chart:        ./forge-workspace/
- OUTCOME:      ./forge-workspace/OUTCOME.md
- eval harness: ./forge-workspace/eval-harness/
- glossary:     ./forge-workspace/CONTEXT.md      (travels as runtime resource)
- ADRs:         ./forge-workspace/docs/adr/       (travel as human "why")
```

Suggested next skill is one of:
- `/forge-atelier` — resume the forge (Movement I/II unfinished, or a return-edge re-entry)
- `/forge-otimizador` — the skill has matured and its harness is trustworthy → autoresearch it

## The return edge — the reason this skill exists

When a forged skill misses its target in real use:

1. append the failure to the handoff's **return-edge log**;
2. write it as a **new gap** in the chart's `KNOWLEDGE-MAP.md` (gap format → `../_shared/FUNCTION-MAP-FORMAT.md`);
3. flip the **suggested next skill** to `/forge-atelier`, and at the seam **ask** the user whether to re-open Movement I on that gap — never auto-invoke (`../_shared/activation-seams.md`).

That third job is why this is a skill and not merely `/handoff`: it is the concrete mechanism of the forge's return edge.
