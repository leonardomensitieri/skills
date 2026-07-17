---
name: forge-otimizador
description: Auto-optimise a matured, validated forged skill against its eval harness — Karpathy-style autoresearch. Movement III of forge-atelier, run explicitly on a skill that already ships good results. Never auto-fires; costly and the most Goodhart-prone step in the forge. Invoke explicitly (/forge-otimizador <skill> <harness>).
when_to_use: When a forged skill has matured (ships a prototype with promising real results) and has a trustworthy eval harness, and you deliberately want to push it past hand-tuning. Not for an unfinished or <60%-good skill — send those back to Movements I/II.
disable-model-invocation: true
user-invocable: true
argument-hint: <path-to-matured-skill> <path-to-eval-harness>
---

> Movement III of **forge-atelier** — the Otimizador. **Never auto-invoked** (`disable-model-invocation`); a human starts it deliberately. Inputs come from the handoff: read `FORGE-HANDOFF.md` to locate the matured skill, its `OUTCOME.md`, and its `forge-workspace/eval-harness/` (or take them from the invocation arguments). Chart schema → `../_shared/chart-spec.md`. Activation → `../_shared/activation-seams.md`.
>
> **At build/run time, re-read the source** — the `karpathy/autoresearch` repo plus the three-phase Claude-Skills port (`multica-ai/andrej-karpathy-skills`) — to design from the source, not from memory.

# Otimizador — autoresearch a forged skill against its eval harness

Movement II ships a skill; the Otimizador **pushes it past the human's hand-tuning**. The move, after Karpathy's *autoresearch*: the human stops editing the artifact and starts editing the *agent that edits it*. Wherever three primitives exist — something editable, a cheap measure of "better", a time-boxed test — an autonomous loop is possible. A forged skill has all three.

**Never auto-invoked.** A human starts it deliberately: it is costly and the most Goodhart-prone step in the whole forge.

## The three roles — what the loop may and may not touch
- **Fixed — the ground truth, never edited by the loop:** `OUTCOME.md`, the test cases, the rubric, and the **binary checks**. This *is* the metric. If the loop could edit the metric it would optimise the metric instead of the skill (Goodhart). Lock it.
- **Editable — the only thing mutated:** the forged skill's **`SKILL.md` body** and its resources. Wording, structure, examples, ordering — all fair game, **one change at a time**.
- **Human-edited — the "program.md":** this protocol plus the rubric/binary set. The human iterates *these* between runs — the real lever, one level up from the skill.

## The readiness gate — optimise, or rebuild first?
- **60–80% good, fails in repeatable ways** → the sweet spot; the loop finds the failure patterns. Proceed.
- **< 60%, or wrong *type* of output** → do not optimise a broken skill. Send it back to **Movement I/II** to rebuild, then optimise.
- **> 90% good** → diminishing returns; target one weak dimension, or stop.
- **Prerequisite:** you must know what "good" looks like. No `OUTCOME.md` / no harness → no loop.

## Phase 1 — Setup (human in the loop; two touchpoints)
1. **Read the target skill whole** — `SKILL.md`, resources, examples (locate via `FORGE-HANDOFF.md` or the invocation arguments). Document what it does, its inputs/outputs, and which files are editable vs fixed.
2. **Gather/generate test cases** — real inputs a user would send, spanning the skill's branches, seeded from `OUTCOME.md`'s good/bad examples. **Split train / held-out**: optimise on train, validate kept wins on held-out — never tune against the exam.
3. **Build the 1–5 rubric** — one row per quality dimension from `OUTCOME.md`. For *humans* to see where quality sits.
4. **Run the baseline** — score the un-mutated skill; record it as experiment 0.
5. **Convert the weak dimensions to binary checks** — the key step. A 1–5 score is a judgement call, unusable by an unattended loop. Turn each weak/important dimension into a **yes/no** check with no grey area. **Two independent judges must agree** on a binary; if they can't, that dimension is **not binarisable** — it stays in Debrief / expert review.
   - **Judge against the final artifact** (render-complete), never a stripped slice.
   - **Structural ≠ target.** A check guaranteed by the format/render is a **guardrail** (keep it to catch regressions) — not an optimisation target.
6. **— Human touchpoint —** the human approves the cases, the binary set, and the **stopping criteria**. Nothing runs until then.

## Phase 2 — The autonomous loop (no human)
**Execution substrate.** This fan-out-and-judge loop is a deterministic multi-agent **workflow**: each round is a pipeline/parallel over the test cases (run the skill → judge each output with schema-validated verdicts), a barrier to tally the pass-rate, then keep/discard, bounded by a round/budget loop. (Where no orchestration tool exists, spawn the sub-agents manually; the logic is identical.)

An append-only **ledger** tracks every experiment: `id | pass_rate | status(keep/discard/crash) | one-line description`.

**LOOP until a stopping criterion or manual interrupt:**
1. Note the current state (a snapshot of the skill files).
2. Propose **one surgical mutation** to the skill body — *one* change, aimed at a known failing check (**Surgical Changes**; **Simplicity First**: prefer the simplest change that could move it). **Never edit the harness.**
3. Snapshot the mutation.
4. **Run the skill on every test case** — a fresh executor per case, with the mutated skill; capture each output.
5. **Score on the binary checks** — judges (≥2 per check; disagreement = *not passed*, flagged). The **pass-rate** is the metric.
6. Record in the ledger.
7. **Keep or discard:** keep/advance **only if** the pass-rate improved **and no previously-passing check regressed**. Otherwise **revert**.
8. **Simplicity tiebreaker:** equal pass-rate + simpler skill → keep; a gain that adds bloat for a tiny delta → discard.
9. **Crash** (a case errors): fix-if-trivial, else log `crash` and move on.
10. **Never stop to ask permission.** Out of ideas → think harder. Stop only on the agreed criterion (N rounds with no fresh win, or a budget) or manual interrupt.

**Timeout:** bound each experiment; if a run hangs, kill it, log it, revert.

## Phase 3 — Debrief (human in the loop)
1. **Re-score** baseline and final skill with the **original 1–5 rubric** — the human compares before/after in the language they think in.
2. **Report:** which dimensions moved, what was kept and why, what was discarded, which regressions were refused, and what the loop **could not** improve (the tacit residue).
3. **Promotion is explicit:** the loop proposes, the human ships. Movement III never promotes on its own.

## Autonomy ∝ binarizability — the safety line
- **Content skill** → almost all quality binarises → the middle loop runs almost entirely on its own.
- **Clinical skill** → only the **checkable layer** binarises; the **deep judgement** — the very thing that justified the forge over the creator — resists yes/no and goes to an **expert review cycle, never a blind loop**. In a medical domain, **expert-in-the-loop is a safety requirement, not a preference.** The loop optimises only what binarises trustworthily; the rest lives in Debrief.

## Discipline & lineage
- **One mutation per experiment** ↔ **one gap per turn** (Movement I): both are *converge, don't sprawl*.
- **Simplicity First** ≡ Karpathy's *simplicity criterion*: the keep/discard tiebreaker.
- **Surgical Changes:** one change, traceable to a failing check.
- **Fidelity is the floor, not the ceiling** (Construtor): diverge from the expert's method **only as far as the trustworthy binary signal confirms.** No trustworthy measurement → no divergence.

## Recursion — the horizon, not now
The forge is a skill that makes skills — the *program.md one level up*. The same loop pointed at the **forge's own protocols** would optimise it against *"how good are the skills it generates"* — the skill that improves all skills. **Lock:** the most Goodhart-prone configuration of all. Prove the loop first on a forged **content** skill with a trustworthy harness; only then consider going up a level — never start with the medical case nor with the self-reference.

## Output
The **optimised skill** (promoted on the human's say-so), the **experiment ledger**, the **before/after 1–5 report**, and the **eval harness preserved**. That harness also feeds the **return edge** (via `../forge-handoff/SKILL.md`): when the skill later fails in real use, the new failure becomes a new check and the loop can run again.
