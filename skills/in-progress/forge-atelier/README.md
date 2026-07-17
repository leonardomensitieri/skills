<div align="center">

# ⚒️ forge-atelier

**Forge a reusable skill out of an expert's own method — and have an AI execute it at their level.**

</div>

---

Skills I use and develop to make AI agents execute real methods — not generic output. Each piece lives side by side here (co-location) so the references between them resolve.

## ✨ What it is

Every expert carries a method they know by reflex — the clinical reasoning, the workflow, the repeatable practice they've never fully written down. forge-atelier extracts that tacit method and rebuilds it as a reusable, testable, AI-executable skill.

It's not a prompt generator. It's a deliberate, spiraling, multi-session extraction: the AI asks, the expert answers, the map of the method closes — one gap per turn, until it's buildable.

> *"Turn my method into a skill"* · *"Codify how I do X"* · *"Capture my workflow as something reusable"*

## 📦 The constellation

forge-atelier is a **constellation**: a self-invoking orchestrator plus explicit-only components it reads and applies by path. Every piece lives side by side (co-location) so the references between them resolve.

| Skill | Role | Invocation |
|---|---|---|
| [⚒️ `forge-atelier`](./forge-atelier/) | Orchestrator — owns the chart, runs Movements I+II, Builder inline. Forges a skill out of an expert's method. | **self-invoking** (the only one) |
| [`forge-desmonte`](./forge-desmonte/) | Movement I — functional deconstruction of the method into parts, functions, and real dependencies. | explicit-only |
| [`forge-grill`](./forge-grill/) | Movement I — one-question-at-a-time interrogation that pulls out the tacit method; also grills solo plans. | explicit-only |
| [`forge-otimizador`](./forge-otimizador/) | Movement III — Karpathy-style self-optimization against the harness (expensive; never fires on its own). | explicit-only |
| [`forge-handoff`](./forge-handoff/) | Cross-session handoff and router that feeds real-use failures back into the forge. | explicit-only |

Single sources (referenced, never copied): [`_shared/`](_shared/). Co-location manifest: [`ATELIER-MAP.md`](ATELIER-MAP.md). Design notes: [`docs/architecture-blueprint.md`](docs/architecture-blueprint.md).

## 🌀 How it works — the three movements

| Movement | Name | What happens |
|:---:|---|---|
| **I** | **Deconstruct** | The method is broken into *functions* and *real dependencies* — not its usual surface form. Each turn chases a single gap: the most valuable one still tacit. |
| **II** | **Reconstruct** | The Builder synthesizes the new `SKILL.md` *for an AI executor* — embedded lexicon, progressive disclosure, eval harness — and validates it against real test prompts. |
| **III** | **Transcend** | Once the skill is mature, it self-optimizes against its own harness. It never runs on its own: it's expensive and the most Goodhart-prone step in the system. |

### 🔁 The cycle never closes

Movement II doesn't ship a finished product — it ships a **prototype**. Real use exposes where the method was still tacit (or simply wrong), and each failure becomes a new gap that **reopens the spiral** at that point. *"Done" is always provisional.*

> [!NOTE]
> forge-atelier is the **entry point of a constellation** of cooperating skills (`forge-desmonte`, `forge-grill`, `forge-otimizador`, `forge-handoff`, and `_shared/`). Install the whole folder together — everything co-located so the references between them resolve. If a piece is missing, the forge fails **explicitly**, never silently, and tells you which one.

## 🧭 When to use it (and when not)

**Use it when** someone wants to turn expertise, a protocol, or a recurring way of doing a task into something an AI executes at their level — and they'll engage across the session (deposit material, answer one question per turn).

**Don't use it when:**
- The task is simple and well-specified, with no hidden expertise → use the lighter `skill-creator`.
- You want a quick answer or a one-off output, not a reproducible method.
- There's no repeatable practice underneath — nothing to deconstruct.

## 🫁 One session, in one breath

> Deposit what exists (even if it's almost nothing) → say what a **good result** looks like and pick *lean* or *full* → Deconstruct breaks the method into functions and finds the biggest gap → Grill drills **only that gap**, one question at a time → re-deconstruct → repeat until you say "enough" and the forge agrees it's buildable → the Builder writes the `SKILL.md` and tests it against the target → **the prototype runs in the real world, each failure becomes a new gap, and the spiral turns again.**

## 🚀 Install

The constellation is **a single install block** — copy all the pieces together (co-location) into your skills directory, or the references between them break:

```bash
# global (all sessions), run from this folder
cp -r forge-atelier forge-desmonte forge-grill forge-otimizador forge-handoff \
      _shared ATELIER-MAP.md ~/.claude/skills/

# or per project: swap ~/.claude/skills/ for .claude/skills/
```

Then invoke it in the session:

```
/forge-atelier
```

---

<div align="center">

Made with ⚒️ by **Leonardo Abreu** · *AI Skills for Builders*

**Claude Code · automation · vibe coding**

</div>
