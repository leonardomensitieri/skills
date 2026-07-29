# Worked example — the red-team that birthed this method

A concrete end-to-end walkthrough of the five judgments (§1–§5 of `SKILL.md`) on a real, high-stakes plan — and how it caught a **silent, deadline-losing bug** that a normal review missed.

## The setup
An **unattended legal-automation agent**: it reads a lawyer's court publications by email, logs into the Brazilian court system (PJE/TJBA), downloads the case files, and drafts petitions — all with nobody watching. The task: add "2nd-degree" (appellate) support so publications from the appeals court route to the right system (`pje2g`) instead of the trial-court one (`pje`). The author (me) framed it as **"just config, no new logic"** — swap URLs, thread a parameter — and wrote a tidy 6-step plan.

## §1 — Anchoring (the trap)
The FIRST review spawned **one** reviewer with the plan and asked it to *"validate and refine."* It found 5 real blind spots — but all **inside my frame** (a broken fallback, a dead variable, a retrocompat alias, a footgun, a selector-parity gap). It **missed the central bug** — because I had **fenced off the routing rule**: my prompt literally said *"the routing heuristic is confirmed by norm — do NOT change it."* **I protected the exact thing that was wrong.**

The fix (this method's core): re-run the panel **unanchored** — hand the plan as a proposal to DESTROY, list the fenced premises (incl. *"the `.0000` routing rule is correct"*) as **claims to distrust**, and **disclose my own bias** to the critics (*"the author anchored a prior review; attack what was fenced off"*).

## §2 — Lenses mapped to THIS artifact's failure axes
Not a canned trio — the genuinely **distinct** ways this thing could fail:
- **Technical / implementation** — the wiring itself (parameter threading, session files, browser lifecycle, silent aliases).
- **Domain (Brazilian civil procedure / PJE)** — is the routing rule *legally* correct? ← the axis a generalist can't see.
- **Operational (100%-unattended production)** — what breaks at 3am with nobody watching?

## §3 — Blind panel + adversarial mandate
**Three** critics, **blind to each other**, spawned **in parallel**, each handed the **real code** (not a summary) + the mandate from `SKILL.md` (attack premises · "and if?" · carry causality to the concrete harm · rank · cite `file:line` · name the 3 you fear most).

## §4 — Synthesis (and the payoff)
The three lenses **converged** on a CRITICAL finding the anchored review had missed — the **domain** lens nailed it: the routing rule keyed on the wrong signal (the case's **origin code**, not the **acting court**), so an appeal would silently download **stale** case files and draft a petition over the wrong facts → **a lost deadline, in silence**. The **operational** lens found that removing a safety net inverted the system's core rule (*"when in doubt, raise a flag — never stay silent"*). ~34 findings total → a **traceability matrix**: each finding → `resolved` / `deferred` / `to-detail` / **`verified-not-a-bug`** (the non-bugs recorded so nobody re-cries-wolf).

**Verify — don't just collect:** the killer finding was then **empirically confirmed** — we downloaded the same case from **both** systems and compared: the trial-court copy was **170 pages shorter and missing the very act that started the deadline**. Plausible-but-wrong findings were killed against a concrete check; the real ones survived.

## §5 — Decide + audit trail
The plan was **reshaped**: route by the acting court's *órgão* (not the origin code); **keep the immediate safety flag** (never silent); add a **freshness check** (the intimated act must exist in the downloaded files). The matrix became the **audit trail** — every finding, and why it was handled that way. Nothing raised vanished silently.

## The persistent domain critic (how it "accompanies" this skill)
The **domain (juridical) lens** proved so valuable — and so expensive to re-prime each run — that we **froze it as a standing agent**: `revisor-juridico-pje`, a read-only reviewer carrying Brazilian-civil-procedure + PJE expertise (numbering rules, which court holds which files, irreversible "ciência", deadline math). Now the panel **invokes it directly** as the domain lens.

This is the `SKILL.md` "Composes with → persistent domain critics" principle in action, and the rule behind it: **freeze a standing agent ONLY for a recurring axis whose knowledge is expensive to reconstruct** — never for the generic lenses (spawn those ad-hoc). The agent is a **separate project-level asset**, not bundled into this user-level skill (scope: a legal critic would be dead weight in a non-legal project).

## Takeaways (transferable)
1. **What you protect is what most needs attacking** — the anchored premise hid the bug.
2. **The domain lens earns its keep** by seeing failures a generalist can't — it found the killer.
3. **Verify the scary findings against reality** — a red-team's own failure mode is plausible-but-wrong.
4. **The matrix is the deliverable** — findings + statuses + the recorded non-bugs, as an audit trail.
5. **Freeze only the recurring, expensive lens** as a standing agent; spawn the rest ad-hoc.
