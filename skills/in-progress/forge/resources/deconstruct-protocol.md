> Bundled resource — applied by skill-forge during Movement I (the deconstruction co-routine). Source: the deconstruct-method protocol, YAML frontmatter removed.

# Desmonte — functional deconstruction of an expert's method

This skill adapts the deconstruction core of the **`leonardo-method`** skill — Leonardo's four-phase deep-study method (the "wooden sphere") — **with its polarity inverted**. It credits that method as its origin; it does **not** invoke it, because the polarity is reversed (see below): running `leonardo-method` as-is would pull in a Socratic coach that *withholds* answers, the opposite of what this needs.

In the study method, a *human* disassembles *external* knowledge and reassembles it in their *own mind*; the assistant is a Socratic coach who deliberately *withholds* answers so the learner rediscovers them. Here it is the reverse on every axis: the *system* disassembles the *expert's* method, the reassembly target is a *machine artifact* (a skill, not understanding in a head), and the assistant **actively analyses, decomposes, and proposes** — it does not withhold. The expert is already the master; nothing needs to be internalised. The job is to get the method *out* of them and understand it well enough to rebuild it.

The metaphor still holds and is worth keeping: a method you can only *describe* is an assembled sphere you have not yet taken apart. You do not understand it until you can disassemble it, see how each piece fits and why, and rebuild it yourself. Recognition of the surface sequence is not understanding.

**Communicate any expert-facing output in the expert's own language.** The body of this skill is in English for robustness; what the expert reads is not.

## The one discipline that matters most: function, not surface sequence

The failure this skill exists to prevent: a skill that mirrors *the order the expert happens to do things in*, copying gestures without grasping why. Such a skill works on the examples and shatters on everything else, and never reaches the expert's level.

So the whole job is to get *underneath* the observed sequence to the **function** of each step and the **true dependencies** between steps. The order an expert performs things is often habit, convenience, or how they were taught — not the real constraint. Only the functional decomposition generalises beyond the examples, and only generalisation lets the reconstruction match or exceed the expert.

## The procedure

Run this against the method as currently expressed — the material the expert provided plus the current `PROCESS-MAP.md` and any answers already captured by the Grill.

1. **Disassemble into discrete steps.** Identify the atomic actions and decisions of the method. Split anything that is secretly two steps; merge anything that is artificially divided.
2. **Determine each step's function.** For every step, answer: *What does it accomplish? Why does it exist? What would break downstream without it? What does it consume (inputs)? What does it produce (outputs)? What must precede it?*
3. **Build the dependency graph, not a list.** Surface where the seemingly linear practice actually has branches, gates, parallel paths, or loops. Separate *true* ordering constraints (B genuinely needs A's output) from *habitual* ordering (the expert just does A first).
4. **Attempt reconstruction.** Ask yourself: *could the method be rebuilt from this map alone, by someone who is not the expert?* Walk it forward mentally against the expert's own examples.
5. **Where reconstruction fails, that failure is a gap.** A step whose function is unclear, a dependency that does not resolve, an input that appears from nowhere, a branch whose condition is unstated — each is a gap. Mark them explicitly, biggest first.

## The clean boundary with the Grill

**The Desmonte does not interrogate the expert — that is the Grill's role.** Exhaust the material first (this is the cheap-first rule seen from the other side: the Desmonte squeezes everything possible out of what already exists). When the material genuinely cannot resolve something, *do not ask* — mark it as a gap and let the spiral route it to the Grill.

This keeps the two co-routines cleanly separated: **the Desmonte analyses and flags; the Grill asks.** Each turn of the spiral: the Desmonte produces the current `STEP-FUNCTION-MAP.md` and a ranked gap list → the Grill takes the biggest gap, interrogates the expert, captures the answer → the Desmonte runs again with the new information, and the map tightens. The loop closes inward until the expert declares the extraction sufficient.

## Workspace

```
forge-workspace/
├── PROCESS-MAP.md          ← the external view of the flow (read; refine if the flow itself was wrong)
├── STEP-FUNCTION-MAP.md    ← THIS skill's main output (rewritten each spiral turn)
└── KNOWLEDGE-MAP.md        ← updated with what is now known vs. still missing (the gaps)
```

Create files lazily — write `STEP-FUNCTION-MAP.md` once there is a first decomposition to record; do not scaffold it empty.

## Format

> *(Embedded while we draft; can be split into `STEP-FUNCTION-FORMAT.md` at packaging time.)*

### STEP-FUNCTION-MAP.md — step entry

```
## S<N> — <step name>
**Function:** <what it accomplishes / why it exists>
**Breaks if absent:** <what fails downstream without it>
**Consumes:** <inputs>
**Produces:** <outputs>
**Depends on:** <prior steps / preconditions — true constraints only>
**Branches:** <conditions that change what happens next, if any>
**Surface ≠ function:** <note any place the expert's habitual ordering is NOT a real dependency>
```

### Ranked gap list (hand to the Grill, biggest first)

```
## Open gaps
- G<N>: <the step / dependency / condition that will not resolve from the material> — why it blocks reconstruction
```

## When NOT to use this skill
- The goal is to *study* material and internalise it yourself — use the `leonardo-method` skill; its polarity is the one you want.
- There is no repeatable method underneath — a one-off task has no functional graph to recover.
- The user only wants a summary of a process, not a decomposition rigorous enough to rebuild from.

## A short example of the texture

> **Desmonte (analysing the material):** The expert's notes do step A (acquire), then B (check polarity), then C (interpret). On the surface that is a linear chain. But B's output ("polarity valid / suspect") is consumed by C, while A's output feeds both B and C. So the true graph is A → {B, C}, with B *gating* C — not a flat A → B → C. **Surface ≠ function:** the expert lists B second out of habit; functionally it is a gate on C.
> *Map updated. One thing the material cannot tell me:* when B comes back "suspect," does the method halt, or branch to a correction path? The examples never show a suspect case.
> **→ Gap G1 (to Grill):** unstated branch when the polarity gate fails. Blocks reconstruction — the skill would not know what to do in the case the expert clearly handles by reflex.
