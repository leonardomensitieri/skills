<div align="center">

<!-- banner (⚒️) — Leonardo fará -->

# forge-atelier

**Forge a reusable skill out of an expert's own method — and have an AI execute it at their level.**

</div>

---

## What it is

Every expert carries a method they know by reflex — the clinical reasoning, the workflow, the repeatable practice they've never fully written down. forge-atelier extracts that tacit method and rebuilds it as a reusable, testable, AI-executable skill.

It's not a prompt generator. It's a deliberate, spiraling, multi-session extraction: the AI asks, the expert answers, the map of the method closes — one gap per turn, until it's buildable.

> *"Turn my method into a skill"* · *"Codify how I do X"* · *"Capture my workflow as something reusable"*

## The constellation

forge-atelier is a **constellation**: a self-invoking orchestrator plus explicit-only components it reads and applies by path. Everything lives side by side — **co-location** — so the references between the pieces resolve.

| Skill | Role | Invocation |
|---|---|---|
| [⚒️ `forge-atelier`](./forge-atelier/) | Orchestrator — owns the chart, runs Movements I+II, Builder inline. Forges a skill out of an expert's method. | **self-invoking** (the only one) |
| [`forge-desmonte`](./forge-desmonte/) | Movement I — functional deconstruction of the method into parts, functions, and real dependencies. | explicit-only |
| [`forge-grill`](./forge-grill/) | Movement I — one-question-at-a-time interrogation that pulls out the tacit method; also grills solo plans. | explicit-only |
| [`forge-otimizador`](./forge-otimizador/) | Movement III — Karpathy-style self-optimization against the harness (expensive; never fires on its own). | explicit-only |
| [`forge-handoff`](./forge-handoff/) | Cross-session handoff and router that feeds real-use failures back into the forge. | explicit-only |

Single sources, referenced and never copied: [`_shared/`](_shared/). Co-location manifest: [`ATELIER-MAP.md`](ATELIER-MAP.md). Design notes and rationale: [`docs/architecture-blueprint.md`](docs/architecture-blueprint.md).

## 🌀 How it works — the three movements

- **I · Deconstruct** — The method is broken into *functions* and *real dependencies*, not its usual surface form. Each turn chases the single most valuable gap still tacit.
- **II · Reconstruct** — The Builder synthesizes a new `SKILL.md` for an AI executor — embedded lexicon, progressive disclosure, eval harness — and validates it against real test prompts.
- **III · Transcend** — Once mature, the skill self-optimizes against its own harness. Never on its own: it's expensive and the most Goodhart-prone step in the system.

### 🔁 The cycle never closes

Movement II ships a **prototype**, not a finished product. Real use exposes where the method was still tacit (or simply wrong), and each failure becomes a new gap that reopens the spiral at that point. *"Done" is always provisional.*

> [!NOTE]
> Install the whole folder together. If a piece is missing, the forge fails **explicitly**, never silently, and tells you which one.

## When to use it (and when not)

**Use it** when someone wants to turn expertise, a protocol, or a recurring way of doing a task into something an AI executes at their level — and they'll engage across the session.

**Skip it** when the task is simple and fully specified (use the lighter `skill-creator`), when you want a one-off output rather than a reproducible method, or when there's no repeatable practice underneath.

## Install

The constellation installs as **one block** — same co-location rule: copy every piece together, or the references break.

```bash
# global (all sessions) — run from this folder
cp -r forge-atelier forge-desmonte forge-grill forge-otimizador forge-handoff \
      _shared ATELIER-MAP.md ~/.claude/skills/

# per project — same command, project-local destination
cp -r forge-atelier forge-desmonte forge-grill forge-otimizador forge-handoff \
      _shared ATELIER-MAP.md .claude/skills/
```

Then invoke it: `/forge-atelier`

---

<div align="center">

Made with ⚒️ by **Leonardo Abreu** · *AI Skills for Builders*

</div>
