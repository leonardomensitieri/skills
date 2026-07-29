# antithesis-red-teaming — which critics do you actually spawn?

[`SKILL.md`](./SKILL.md) holds the **method**: thesis → a blind panel of adversaries → a ranked, traceable verdict. [`WORKED-EXAMPLE.md`](./WORKED-EXAMPLE.md) runs all five steps end-to-end on a real, high-stakes plan.

This README settles the one question the method keeps raising and that most people get wrong: **who's on the panel?** Spawn the wrong critics and the red-team theatre-checks your plan — lots of activity, none of it touching the axis that actually kills you.

There are three tiers of critic. Picking the tier is the skill.

| Tier | What it is | Lifetime | Cost | Reach for it when |
| --- | --- | --- | --- | --- |
| **1 — Generic ad-hoc lens** | A fresh sub-agent handed a lens (correctness, ops, security, UX) at spawn time | One run, then gone | ~free | The failure axes need no knowledge a smart generalist can't hold in-context |
| **2 — Specific domain lens** | An ad-hoc sub-agent, but primed with real domain expertise you paste into its prompt | One run, then gone | A big prompt every run | One axis needs knowledge a generalist lacks, but the domain recurs rarely |
| **3 — Frozen field agent (standing subagent)** | A registered `.claude/agents/<domain>-reviewer.md` the panel invokes by name | Persists across runs | Written once, cheap forever | That domain axis recurs **and** its knowledge is expensive to reconstruct each time |

The example that ships here — [`agents/revisor-juridico-pje.example.md`](./agents/revisor-juridico-pje.example.md) — is a Tier 3 agent. It's the one from the worked example, anonymized.

---

## Tier 1 — when the generic ad-hoc lenses are enough

**Default here.** Most artifacts fail along axes a sharp generalist can attack cold: a broken fallback, a dead variable, a race, a footgun, a confusing empty state. If every distinct way your thing can break is visible to someone who just reads the code and the constraints carefully, you don't need a specialist — you need 2–4 *unanchored* generalists, each pointed at a different axis, spawned blind and in parallel (SKILL.md §2–§3).

**Signs Tier 1 is all you need:**

- The invariants a flaw would violate are stated in the artifact itself — no outside body of rules to know.
- You can write each lens's mandate in a sentence without pasting a syllabus.
- A competent engineer from another team could find the bugs given the code and an afternoon.

Don't gold-plate. A standing agent for a one-off, in-context axis is dead weight — it rots, and it re-primes knowledge that was free to hold anyway.

## Tier 2 — when you need a SPECIFIC domain lens

Some axes are invisible without knowledge the model won't reliably bring: **legal, medical, financial, regulatory, tax, a gnarly internal protocol.** A generalist reviewing these doesn't find *wrong* — it finds *plausible*, because it can't tell the difference. That's the dangerous case: the panel comes back green and the killer bug was in the exact spot no one on it was equipped to see.

> In the worked example, the generic reviewers found five real in-frame blind spots and **missed the central bug** — a routing rule that was correct-looking but legally incomplete. Only the lens carrying Brazilian civil-procedure expertise could see it, because seeing it required knowing that a case's *origin code* is not its *acting court*. No amount of "think harder" gets a generalist there.

**How to know a specific lens was missing** (the retrospective tell — catch it before it costs you):

- A prior review only **refined** your idea and never attacked a premise — often because no critic *knew enough* to attack it.
- The scariest failure mode lives in a body of rules **external to the artifact** (a statute, a spec, a compliance regime, a hardware contract).
- You find yourself writing "well, technically the domain says…" — that sentence is a lens you didn't staff.
- The thing can cause **irreversible domain harm** (a missed legal deadline, a dosing error, a mispriced trade) that a generalist would rank MEDIUM because they can't feel the stakes.

**The move:** add one lens whose mandate *is* the domain expertise. Paste the real rules into its prompt. It's still ad-hoc — spawned for this run, gone after. That's correct **until the domain starts recurring.**

## Tier 3 — when to FREEZE it into a standing field agent (subagent)

A "field agent" is a Tier 2 lens you got tired of rebuilding. When the same domain axis shows up run after run, and its priming prompt is a page of hard-won rules, re-pasting that page every time is waste and drift — each copy is a chance to leave something out. So you **freeze** it: register it once as a `.claude/agents/<domain>-reviewer.md` subagent, and the panel invokes it by name as its domain lens.

**Freeze only when BOTH are true:**

1. **Recurrence** — this domain axis is load-bearing on more than one artifact. One-offs stay Tier 2.
2. **Expensive knowledge** — the expertise is a real body of rules that's costly and error-prone to reconstruct from scratch each run. Cheap-to-restate lenses stay ad-hoc.

Freeze a *generic* lens (correctness, ops) and you've built a maintenance liability that adds nothing a fresh spawn wouldn't. Skip freezing a *recurring expensive* lens and you pay the re-priming tax — plus the risk that one run's paste quietly drops the rule that catches the bug.

**Anatomy of a good field agent** — study [`agents/revisor-juridico-pje.example.md`](./agents/revisor-juridico-pje.example.md):

- **Read-only.** It reviews and attacks; it never edits. A critic with write access stops being a critic.
- **Scoped tools.** `Read, Grep, Glob, WebSearch, WebFetch` — enough to inspect the artifact and check the law, nothing to mutate it.
- **Two modes.** *Adversarial* (the red-team lens: attack premises, rank by harm, carry causality to the concrete damage) and *review* (a straight correctness verdict). One agent, invoked either way.
- **The expensive knowledge, frozen in the body.** The numbering rules, which court holds which files, what triggers an irreversible deadline, the error-asymmetry principle — the exact page you were re-pasting.
- **A discipline for output.** Cite the rule for every claim; separate VERIFIED FACT from INFERENCE; rank findings; end with the ones it most fears.
- **It's a project-level asset, not part of this skill.** A legal critic is dead weight in a non-legal repo. Ship it beside the project it guards, not inside the user-level skill. (This is why the example lives here only as an `.example.md` teaching artifact.)

## The decision, in one pass

```
Can a sharp generalist see every way this breaks, from the code + constraints alone?
├─ Yes → Tier 1: spawn 2–4 unanchored generic lenses, blind + parallel. Done.
└─ No, one axis needs outside expertise
   └─ Does that domain recur across artifacts, with expensive-to-rebuild knowledge?
      ├─ No  → Tier 2: add a specific domain lens ad-hoc; paste the rules; spawn it for this run.
      └─ Yes → Tier 3: freeze it as a standing `.claude/agents/<domain>-reviewer.md` field agent.
```

## Anti-patterns (each one quietly guts the panel)

- **A generalist on a specialist's axis** — comes back "looks fine" and can't tell plausible from correct. The green light is the failure.
- **The canned trio, every time** — reusing correctness/ops/security regardless of the artifact. A lens earns its seat only if it sees failure the others can't.
- **Freezing a generic lens** — a standing "correctness-reviewer" is a rotting liability; spawn those fresh.
- **Not freezing a recurring expensive lens** — you re-pay the priming tax and risk dropping the one rule that catches the bug.
- **Giving the field agent write access** — a critic that can edit is no longer adversarial.
- **Bundling the domain agent into the skill** — scope leak; it's a project asset, not a universal one.

## What ships here

```
antithesis-red-teaming/
  SKILL.md                              the method (five judgments)
  WORKED-EXAMPLE.md                     all five steps, end-to-end, on a real plan
  README.md                             this file — which critics to spawn
  agents/
    revisor-juridico-pje.example.md     a Tier 3 field agent, anonymized (adapt, don't run as-is)
```

The agent is an **example**, not a drop-in. Its knowledge is one specific domain; copy the *shape* — read-only, scoped tools, two modes, expensive knowledge in the body, cite-the-rule discipline — and swap in your own axis.
