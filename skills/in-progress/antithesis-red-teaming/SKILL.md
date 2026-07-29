---
name: antithesis-red-teaming
description: Assemble an adversarial red-team — a BLIND panel of lens-specialized critics — to stress-test a plan, design, decision, migration, or artifact and surface what breaks BEFORE reality does, then synthesize a ranked, traceable verdict. Use whenever you or the user want to red-team, stress-test, pressure-test, adversarially review, or "find the holes / attack the premises" of a plan, design, architecture, proposal, spec, or PR; whenever a decision is high-stakes or hard to reverse; or whenever you catch yourself confident and a prior review only refined instead of challenging assumptions. Prefer this over a single reviewer when the thing can fail in multiple DISTINCT ways (correctness, domain, operations, security, UX). Don't wait for the literal word "red-team" — reach for it before committing to anything risky.
---

# Antithesis — assemble an adversarial red-team

**Thesis** (a plan) → **Antithesis** (a blind panel of adversaries that attacks it) → **Synthesis** (a ranked, traceable verdict + a refined plan). The value is NOT "spawn some critics." It's the five judgments below — most red-teams fail because they skip #1 and #2.

> **Full worked example** — all five steps applied end-to-end to a real, high-stakes plan (the case that birthed this method, incl. how a persistent domain critic was born): read `WORKED-EXAMPLE.md`.

## When to reach for this
Before committing to something high-stakes or hard to reverse (architecture, migration, irreversible action, a plan you're about to implement); when a first review only *refined* your idea instead of challenging its premises; when you notice you're confident; or on an explicit "attack this / find the holes" request. A red-team pays off when the artifact can fail in several **distinct** ways — not for a one-dimensional check (use `/code-review` or a single reviewer for that).

## 1. Neutralize ANCHORING first — the failure that makes red-teams useless
A reviewer handed your design with "validate and refine" finds refinements *inside your frame* and misses the frame's flaws. So:
- **Give the artifact as a proposal to DESTROY, not to improve.** Frame the job as "break this," not "help me finish it."
- **List the premises you'd normally protect as "claims to DISTRUST"** and tell each critic to attack them explicitly — especially anything you fenced off ("don't change X").
- **Disclose your own bias** to the panel: if you (or a prior review) anchored on something, say so, and point them at exactly that spot.

> Worked example (this method's origin): a first review of a "just config" wiring found 5 real *in-frame* blind spots but **missed the central bug** — because the author had fenced off the routing premise ("do NOT change this function"). An unanchored red-team, explicitly told to attack that premise, found it in the first pass. **What you protect is what most needs attacking.**

## 2. Choose lenses that map to THIS artifact's real failure axes
Don't reuse a canned trio. Ask: **"What are the genuinely DISTINCT ways this specific thing can fail?"** Pick **2–4 lenses**, one per axis. A lens earns its place only if it sees failure the others can't — redundant lenses just burn tokens.
- Common axes to draw from: **correctness/implementation** · **domain-specific** (legal, medical, financial, regulatory) · **operational / failure-modes** (production, unattended, scale, deploy) · **security / adversarial** · **UX / human-factors** · **cost / performance**.
- The highest-value lens is usually the one carrying **knowledge a generalist wouldn't bring**.

> Worked example: lenses were **technical-correctness · domain (Brazilian civil procedure/PJE) · operational (100%-unattended production)**. The **domain** lens found the killer bug (a routing rule that was correct-but-incomplete) precisely because it required expertise the generic reviewer lacked; the **operational** lens found failures unique to "runs at 3am with nobody watching." A generic 3-lens template would have missed both.

## 3. Run a BLIND panel with an adversarial mandate
Spawn the critics **blind to each other** (independent perspectives; a shared draft converges to one view) — one agent per lens, **all in one message** (parallel). Give each the **real artifact + real code/context**, not a summary — the real bugs live in the code, not the plan. Use the mandate below.

### Mandate template (copy per critic — swap the LENS + PREMISES)
```
You are a RED-TEAM adversary. Your job is NOT to plan or improve — it is to BREAK.
Produce a ranked list of flaws, holes, and failure scenarios. Be skeptical, creative,
think "and if?" and carry the causal chain forward to the CONCRETE harm. Read the REAL
code/artifact, not just the summary — the real bugs are there.

BIAS DISCLOSURE: the author has a known bias toward confirming this approach, and
BLINDED these premises in a prior pass — attack them HEAD-ON, do not trust them:
<list the premises you'd normally protect>

CONTEXT (invariants a flaw would violate): <the rules/goals/constraints of the system>
ARTIFACT TO DESTROY: <path to the plan/design> · CODE TO READ: <exact files/functions>

YOUR LENS: <this critic's axis — e.g., domain-legal / operational-failure-modes /
technical-correctness>. Attack from this angle and go beyond the obvious; for premises
already under scrutiny, push "what if?" further than anyone has.

Deliver: findings ranked CRITICAL/HIGH/MEDIUM/LOW — each with the exact defect
(file:function), the "and if?" causal chain to the damage, and the trigger scenario.
End with the 3 you most fear.
```

## 4. Synthesize — don't just collect
- **Dedup** findings across lenses (the same flaw surfaces from multiple angles).
- **Triage/verify** each: "is this actually real?" A red-team's own failure mode is **plausible-but-wrong** findings. For the scary ones, verify **adversarially** — spawn a skeptic that tries to REFUTE it (kill it if it can't survive), or check it against the code/facts yourself.
- **Build a traceability matrix**: every finding → status (`resolved in design` / `deferred to a gated step` / `to-detail in implementation` / `verified NOT-a-bug`). **Record the non-bugs too** — so nobody re-cries-wolf next time.
- Surface the **top 3 feared** across the whole panel.

## 5. Decide the response (and keep the audit trail)
For each real finding: resolve it in the design, defer it to a gated later step, or accept-with-mitigation. Update the plan; **the matrix is the audit trail** of what was raised and why it was handled that way. Nothing raised should vanish silently.

## Scale mode — hand off to a workflow (optional)
For exhaustive pre-ship audits, run this as a `/workflows` script instead of a one-shot panel: **fan-out lenses → verify each finding adversarially → loop-until-dry** (stop after K rounds with no new findings) **→ synthesize**. This is the Workflow tool's "review-changes" pattern. Build it only when the recurrence justifies it (a pre-deploy exam, a large migration) — not speculatively.

## Anti-patterns (each one quietly guts a red-team)
- **Anchoring the panel** (the #1 killer — see §1).
- **A fixed lens set** applied regardless of the artifact (§2).
- Feeding a **summary** instead of the real code/context.
- **Collecting without verifying** → plausible-but-wrong findings survive and waste trust.
- **No traceability** → findings get lost or re-litigated.
- **Crying wolf** → not recording verified non-bugs, so they resurface every round.

## Composes with
- **Persistent domain critics**: for a recurring domain axis, register a standing agent (`.claude/agents/<domain>-reviewer.md`) primed with that expertise, and have the panel invoke it — cheaper than re-priming the domain every time. When to freeze one (the gate) and how to shape it live in `AGENT-FORMAT.md`; a real, anonymized one ships in `agents/revisor-juridico-pje.example.md`.
- **`/grill-me` / `/grill-with-docs`**: interactive human grilling. Complementary — use *antithesis* for an autonomous multi-lens attack, a grill for interactive Q&A with the user.
- **`/code-review`**: a single-lens diff review — fine on its own for one-dimensional checks; *antithesis* is for multi-axis, premise-attacking review of plans/designs.
