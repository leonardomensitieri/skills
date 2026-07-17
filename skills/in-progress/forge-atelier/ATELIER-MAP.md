# Forge Atelier — constellation map

This bundle is **one install unit**. The orchestrator and components reference each other and the shared sources by the relative paths below. Do not move a folder without updating this map. **Never copy a protocol into another skill "for convenience"** — that reintroduces the duplication this design exists to remove (see `README.md`).

## Skills (peers — no nesting)
| Folder | Role | Invocation |
|---|---|---|
| `forge-atelier/` | orchestrator; owns the chart; runs Movements I+II; Construtor inline | **auto-invocable** (the only one) |
| `forge-desmonte/` | Desmonte — Movement I functional deconstruction | explicit-only (`/forge-desmonte`) |
| `forge-grill/` | Grill — Movement I interrogation; also solo plan-grilling | explicit-only (`/forge-grill`) |
| `forge-otimizador/` | Otimizador — Movement III autoresearch loop | explicit-only (`/forge-otimizador`) |
| `forge-handoff/` | handoff manifest + return-edge router | explicit-only (`/forge-handoff`) |

## Shared single sources (referenced, never copied) — `_shared/`
| File | What |
|---|---|
| `_shared/chart-spec.md` | the `forge-workspace/` schema (the chart) |
| `_shared/FUNCTION-MAP-FORMAT.md` | the part-entry format |
| `_shared/LEXICON-FORMAT.md` | the Lexicon entry format |
| `_shared/DECISIONS-FORMAT.md` | the Decisions entry format |
| `_shared/INGREDIENTS-FORMAT.md` | the typed-ingredient format (point 4, lazy) |
| `_shared/activation-seams.md` | the detect-and-ask policy |

## Resolution rule
All paths are relative to this map's directory (the bundle root). When a skill says "Read and apply `_shared/X`" or "Read and apply `../forge-grill/SKILL.md`", resolve from here. **If a path does not resolve**, the bundle was split on install — consult this map; if a piece is still missing, tell the user it is absent and ask them to install the full forge-atelier bundle (a detect-and-ask, never a silent failure).

## Design memory
The rationale (the three movements, the constellation, the locked decisions) lives in `docs/architecture-blueprint.md`.
