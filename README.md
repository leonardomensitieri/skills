<div align="center">

![Leonardo Abreu — AI Skills for Builders](assets/banner.png)

# ⚒️ skills

**Agent Skills para Claude Code — forjadas para builders.**

[![Claude Code](https://img.shields.io/badge/Claude%20Code-Agent%20Skills-d97757?logo=anthropic&logoColor=white)](https://claude.com/claude-code)
[![Skills](https://img.shields.io/badge/skills-5-blue)](#-skills-dispon%C3%ADveis)
[![Status](https://img.shields.io/badge/reposit%C3%B3rio-vivo-success)](#-skills-dispon%C3%ADveis)
[![Licença](https://img.shields.io/badge/licen%C3%A7a-MIT-lightgrey)](LICENSE)

</div>

---

Skills que eu uso e desenvolvo para fazer agentes de IA executarem métodos reais — não outputs genéricos. Cada uma vive em [`skills/`](skills/), é independente e pode ser instalada sozinha.

## 📦 Skills disponíveis

A **forge-atelier** é uma **constelação**: um orquestrador auto-invocável mais componentes explicit-only que ele lê e aplica por caminho. Todas as peças vivem lado a lado em [`skills/`](skills/) (co-location) para que as referências entre elas resolvam.

| Skill | Papel | Invocação |
|---|---|---|
| [⚒️ `/forge-atelier`](skills/forge-atelier/) | Orquestrador — dono do chart, roda os Movimentos I+II, Construtor inline. Forja uma skill a partir do método de um especialista. | **auto-invocável** (a única) |
| [`/forge-desmonte`](skills/forge-desmonte/) | Movimento I — desconstrução funcional do método em partes, funções e dependências reais. | explicit-only |
| [`/forge-grill`](skills/forge-grill/) | Movimento I — interrogatório uma-pergunta-por-vez que puxa o método tácito; também grelha planos solo. | explicit-only |
| [`/forge-otimizador`](skills/forge-otimizador/) | Movimento III — auto-otimização estilo Karpathy contra o harness (caro; nunca dispara sozinho). | explicit-only |
| [`/forge-handoff`](skills/forge-handoff/) | Handoff entre sessões e roteador de falhas de uso real de volta à forja. | explicit-only |

Fontes únicos referenciados (nunca copiados): [`skills/_shared/`](skills/_shared/). Manifesto de co-location: [`skills/ATELIER-MAP.md`](skills/ATELIER-MAP.md). Design: [`skills/docs/architecture-blueprint.md`](skills/docs/architecture-blueprint.md).

*Mais skills a caminho — este repositório é vivo.*

## 🚀 Instalação

Via [skills.sh](https://skills.sh):

```bash
npx skills@latest add leonardomensitieri/skills
```

Ou manualmente — a constelação é **um só bloco de instalação**: copie todas as peças juntas (co-location) para o seu diretório de skills, senão as referências entre elas quebram:

```bash
# global (todas as sessões)
cp -r skills/forge-atelier skills/forge-desmonte skills/forge-grill \
      skills/forge-otimizador skills/forge-handoff \
      skills/_shared skills/ATELIER-MAP.md ~/.claude/skills/

# ou por projeto: troque ~/.claude/skills/ por .claude/skills/
```

E invoque na sessão:

```
/forge-atelier
```

---

# ⚒️ forge-atelier

> **Forje uma skill reutilizável a partir do método de um especialista — e deixe a IA executá-lo no nível dele.**

## ✨ O que é

Todo especialista carrega um método que sabe **de reflexo** — o raciocínio clínico, o workflow, a prática repetível que ele nunca escreveu por inteiro. A **forge-atelier** extrai esse método tácito e o reconstrói como uma skill reutilizável, testável e executável por IA.

Não é um gerador de prompt. É uma **extração deliberada, em espiral, multi-sessão**: a IA pergunta, o especialista responde, o mapa do método se fecha — um gap por turno, até que dê para construir a partir dele.

> *"Transforme meu método em uma skill"* · *"Codifique como eu faço X"* · *"Capture meu workflow como algo reutilizável"*

## 🌀 Como funciona — os três movimentos

| Movimento | Nome | O que acontece |
|:---:|---|---|
| **I** | **Desmontar** | O método é decomposto em *funções* e *dependências reais* — não na forma superficial habitual. Cada turno persegue **um único gap**, o mais valioso ainda tácito. |
| **II** | **Remontar** | O Construtor sintetiza a nova `SKILL.md` *para um executor de IA* — léxico embutido, divulgação progressiva, harness de avaliação — e valida contra prompts de teste reais. |
| **III** | **Transcender** | Com a skill madura, ela é auto-otimizada contra o próprio harness. Nunca roda sozinho: é caro e o passo mais sujeito a Goodhart do sistema. |

### 🔁 O ciclo nunca fecha

O Movimento II não entrega um produto final — entrega um **protótipo**. O uso real expõe onde o método ainda era tácito (ou simplesmente errado), e cada falha vira um novo gap que **reabre a espiral** naquele ponto. *"Pronto" é sempre provisório.*

> [!NOTE]
> A `forge-atelier` é o **ponto de entrada de uma constelação** de skills cooperantes (`forge-desmonte`, `forge-grill`, `forge-otimizador`, `forge-handoff` e `_shared/`). Este repositório publica a **constelação completa** — todas co-localizadas em [`skills/`](skills/) para que as referências entre elas resolvam. Instale a pasta inteira junto; se uma peça faltar, a forja falha de forma explícita — nunca silenciosa — e te avisa qual.

## 🧭 Quando usar (e quando não)

**Use quando** alguém quer transformar expertise, protocolo ou um jeito de fazer uma tarefa recorrente em algo que a IA executa no nível dele — e topa engajar ao longo da sessão (depositar material, responder uma pergunta por turno).

**Não use quando:**
- A tarefa é simples e bem especificada, sem expertise oculta → use o `skill-creator` comum, mais leve.
- Você quer uma resposta rápida ou um output único, não um método reproduzível.
- Não existe prática repetível por baixo — não há nada a desmontar.

## 🫁 Uma sessão, em um fôlego

> Deposite o que existe (mesmo que seja quase nada) → diga como é um **bom resultado** e escolha o modo *lean* ou *full* → o Desmonte quebra o método em funções e acha o maior buraco → o Grill fura **só aquele buraco**, uma pergunta por vez → re-desmonta → repete até você dizer "chega" e a Forja concordar que dá para construir → o Construtor escreve a `SKILL.md` e a testa contra o alvo → **o protótipo roda no mundo real, cada falha vira um novo gap, e a espiral gira de novo.**

---

<div align="center">

Feito com ⚒️ por **Leonardo Abreu** · *AI Skills for Builders*

**Claude Code · automação · vibe coding**

</div>
