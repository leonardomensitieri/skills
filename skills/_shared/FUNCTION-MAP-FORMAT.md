# FUNCTION-MAP.md — entry format (single source)

> The unit is a **part** of the method, reduced to its *function* and *true dependencies* — not the expert's habitual surface form. "Part" is general: usually a step, but it can be a gate, a branch, a parallel path, or a loop. The procedural shape is the **default**; richer non-step expertise is captured separately as ingredients (see `INGREDIENTS-FORMAT.md`).

## P<N> — <part name>
**Function:** <what it accomplishes / why it exists>
**Breaks if absent:** <what fails downstream without it>
**Consumes:** <inputs>
**Produces:** <outputs>
**Depends on:** <prior parts / preconditions — TRUE constraints only>
**Branches:** <conditions that change what happens next, if any>
**Surface ≠ function:** <any place the expert's habitual FORM (order, shape) is NOT a real dependency>

## Open gaps — ranked, hand to the Grill (biggest first)
- G<N>: <the part / dependency / condition that will not resolve from the material> — why it blocks reconstruction
