# skill-forge

Forge a high-performance, reusable skill out of an expert's own tacit method — and have an AI execute it at, or above, their level.

This is an Agent Skill: a `SKILL.md` plus bundled resources. The orchestrator (`SKILL.md`) runs a three-movement process and applies its component protocols from `resources/`.

## Status

- ✅ **Movement I — Extraction** (the Desmonte ⇄ Grill spiral, driven by the orchestrator)
- ✅ **Movement II — Reconstruction** (the Construtor: rebuild the SKILL.md + test/iterate)
- ⬜ **Movement III — Auto-optimisation** (the Otimizador, inspired by Karpathy) — deferred

The system is runnable end to end for Movements I + II: it can extract a method and produce a tested SKILL.md. Movement III (automatic tuning) is the only piece not yet built.

## Structure

```
skill-forge/
├── SKILL.md                        the orchestrator (entry point, auto-invoked)
├── README.md
├── docs/
│   └── architecture-blueprint.md   why the system is shaped this way (design memory)
└── resources/
    ├── deconstruct-protocol.md     Desmonte — Movement I
    ├── grill-protocol.md           Grill — Movement I
    └── reconstruct-protocol.md     Construtor — Movement II
```

## How it works, in one breath

Deposit whatever you already have about your method (or admit there is almost nothing) → the Desmonte breaks it into functions and finds the biggest hole → the Grill drills that one hole, sharpening terms and logging trade-offs → re-deconstruct → repeat, one hole per turn, until you say "enough" and the orchestrator agrees the map is complete → the Construtor rebuilds it into a SKILL.md written for an AI executor and tests it.

## Install

The `.skill` file is a zip of this folder, following the Agent Skills convention. Where you install it depends on your environment:

- It validates against the claude.ai / Skills-API rules: exactly one `SKILL.md` per skill, and frontmatter limited to `name`, `description`, `license`, `allowed-tools`, `metadata`, `compatibility`.
- Claude Code loads skills from the filesystem and additionally supports nested skills and the `disable-model-invocation` flag.

Tell me your target (claude.ai, the Skills API, or Claude Code) and I will give exact install steps.

## Design notes

- **One source per protocol, two packagings.** Each component protocol is bundled here as a resource and can also be published as a standalone skill. Keep them in sync at the source.
- **Explicit-only by bundling.** The components are not separate skills in this package — they are procedures the orchestrator runs. So only the orchestrator is ever auto-invoked; the components never fire on their own. This also sidesteps the fact that the claude.ai / Skills-API frontmatter has no "explicit-only" toggle.
- **The Lexicon and the Decision Records travel with any forged skill** as its institutional memory — the Lexicon as a runtime resource, the Decisions as human-facing "why" for whoever edits it later.

## Deferred: Movement III

The Otimizador (auto-optimisation by auto-research, à la Karpathy) consumes the eval harness that Movement II exposes, proposes variants of the description and instructions, and keeps the winner on held-out cases. It is deferred by design; the Karpathy source will be read before it is built.
