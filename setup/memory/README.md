# ⚙️ setup/memory

Instala, no seu `~/.claude/`, duas coisas que trabalham juntas:

1. **Hook `SessionStart`** (`project-memory-symlink.sh`) — em **toda sessão, todo projeto, independente das flags**, cria um symlink `./memory` na raiz do projeto apontando pra pasta de auto-memory daquele projeto (que normalmente fica escondida em `~/.claude/projects/<slug>/memory/`). Se o projeto for um repo git, adiciona `/memory` ao `.git/info/exclude` (**local — nunca commitado nem publicado**). É silencioso, idempotente e nunca bloqueia a sessão.
2. **Protocolo de memória** — três regras adicionadas ao seu `~/.claude/CLAUDE.md`: prévia + pré-aprovação antes de gravar, grill rápido pra eliminar incerteza, e captura progressiva (em incrementos). *Isto é comportamental — vive no CLAUDE.md, não dá pra ser um hook.*

## Uso

```bash
bash setup/memory/install.sh
```

**Pré-requisito:** `jq` (`brew install jq` no macOS · `sudo apt install jq` no Debian/Ubuntu). Num projeto **sem git**, o passo de exclude é pulado (o symlink ainda é criado). É **idempotente** — rodar de novo não duplica nada, e faz backup do `settings.json` antes de mexer.

## Reverter

- Tire o bloco `hooks.SessionStart` do `~/.claude/settings.json` (ou restaure o backup `.bak-…`).
- Apague `~/.claude/hooks/project-memory-symlink.sh`.
- Remova as seções `## Memória` e `## Ambiente` do `~/.claude/CLAUDE.md`, se quiser.
