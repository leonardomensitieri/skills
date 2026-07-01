# 📦 skills

Cada pasta com um `SKILL.md` é uma **Agent Skill**. A **forge-atelier** é uma *constelação*: um orquestrador auto-invocável + componentes explicit-only que ele **lê e aplica por caminho** (`read-and-apply, never copy`). Todas as peças vivem lado a lado aqui — mais os fontes únicos em [`_shared/`](_shared/). **Instale a pasta inteira junto** (co-location), senão as referências relativas quebram.

| Skill | Papel | Invocação |
|---|---|---|
| [⚒️ `forge-atelier/`](forge-atelier/) | Orquestrador — dono do chart, roda os Movimentos I+II, Construtor inline | **auto-invocável** (a única) |
| [`forge-desmonte/`](forge-desmonte/) | Movimento I — desconstrução funcional do método | explicit-only (`/forge-desmonte`) |
| [`forge-grill/`](forge-grill/) | Movimento I — interrogatório uma-pergunta-por-vez; também grelha planos solo | explicit-only (`/forge-grill`) |
| [`forge-otimizador/`](forge-otimizador/) | Movimento III — auto-otimização estilo Karpathy (caro; nunca dispara sozinho) | explicit-only (`/forge-otimizador`) |
| [`forge-handoff/`](forge-handoff/) | Handoff entre sessões + roteador de falhas de uso real de volta à forja | explicit-only (`/forge-handoff`) |

**Fontes únicos** (referenciados, nunca copiados): [`_shared/`](_shared/) — o schema do chart (`chart-spec.md`) + os formatos. O manifesto de co-location é [`ATELIER-MAP.md`](ATELIER-MAP.md); a memória de design está em [`docs/architecture-blueprint.md`](docs/architecture-blueprint.md).

Instruções de instalação e a documentação completa estão no [README principal](../README.md).
