# Field Agent Format

A **field agent** is a domain critic you got tired of rebuilding — a lens (one of the axes from `SKILL.md` §2) frozen into a standing `.claude/agents/<domain>-reviewer.md` the panel invokes by name, instead of re-priming it from scratch every run.

Most red-teams never need one. Ad-hoc lenses — spawned for a run, gone after — are the default. Freeze a lens **only** when the re-priming itself has become the waste.

## When to freeze one (the gate)

Both must hold. If either is shaky, don't freeze — spawn the lens ad-hoc and move on.

1. **It recurs.** The same domain axis is load-bearing across more than one artifact. A one-off stays ad-hoc; freezing it builds a liability that rots.
2. **Its knowledge is expensive to reconstruct.** The priming is a real body of rules — costly to rebuild and easy to get subtly wrong on each retype — not something a sentence restates. Cheap-to-restate lenses stay ad-hoc.

The lens earns *specialization* in the first place when it catches failures a generalist can't — usually high-stakes, often irreversible (a lost legal deadline, a dosing error, a mispriced trade). But the freeze decision itself is just **recurrence × cost**. When in doubt, don't freeze: an ad-hoc lens costs one prompt; a bad standing agent costs forever.

## Template

One block. Fill the body with the expensive knowledge; keep everything else lean.

```md
---
name: <domain>-reviewer
description: <the lens in one line> — <the distinct failures it catches that a
  generalist can't> — <trigger phrasing so the panel reaches for it>. Read-only.
tools: Read, Grep, Glob, WebSearch, WebFetch
---

You are a <domain> reviewer — <the expertise a generalist doesn't bring>.

You run in two modes:
- **Adversarial** (red-team lens): attack the domain premises, rank by harm,
  carry the "and if?" chain to the concrete damage.
- **Review**: judge domain correctness/completeness — what's right, wrong,
  and what must still be confirmed.

<THE EXPENSIVE KNOWLEDGE — the rules, the numbering, who-holds-what, what is
irreversible, the error-asymmetry. This body is the whole reason the agent exists.>

Deliver findings ranked CRITICAL/HIGH/MEDIUM/LOW, each with the exact defect,
the causal chain to the harm, and what must be confirmed with a human expert.
End with the 3 you most fear. Cite the rule for every claim; never inflate.
```

That's it. The value is the frozen knowledge in the body — not ceremony around it.

## Rules

- **Read-only.** Give it tools that inspect, never mutate (`Read, Grep, Glob`, plus `WebSearch`/`WebFetch` to check sources). A critic that can edit stops being a critic.
- **Two modes, one agent.** Adversarial (for the panel) and review (for a straight verdict) — same file, not two.
- **The body carries only the expensive, domain-specific knowledge.** Same test as CONTEXT-FORMAT: if a smart generalist already knows it, it doesn't belong. General reasoning is the model's job, not the agent's syllabus.
- **Cite the rule; separate VERIFIED FACT from INFERENCE.** A domain critic that hand-waves is worse than none — it launders guesses as expertise.
- **Rank, and name what you most fear.** Findings ordered by harm; close with the worst-case scenarios.
- **It's a project asset, not part of a skill.** A legal critic is dead weight in a non-legal repo. It lives beside the project it guards. (The one in `agents/` here is an anonymized `.example.md` — a teaching artifact, not a drop-in.)

## Anti-patterns

- **Freezing a generic lens** — a standing "correctness-reviewer" rots; spawn generalists fresh every run.
- **Freezing a one-off** — it may pass the "expensive" test but fails "it recurs." Keep it ad-hoc.
- **Write access** — a critic that can edit is no longer adversarial.
- **A syllabus a generalist already knows** — bloats the prompt, teaches the model nothing, and buries the rules that actually matter.
- **Bundling it into a user-level skill** — scope leak; the knowledge is one domain's, the skill is everyone's.

## Worked instance

`agents/revisor-juridico-pje.example.md` is a field agent that cleared the gate: Brazilian civil-procedure / PJE expertise, recurring across every run of a legal-automation project, where a missed deadline is irreversible. It's the domain lens from `WORKED-EXAMPLE.md`, anonymized. Read it as the shape to copy — then swap in your own axis.
