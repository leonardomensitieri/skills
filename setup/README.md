# ⚙️ setup

Tooling do repositório — **não são skills**. São configurações de ambiente que você instala **uma vez** no seu Claude Code.

Cada subpasta é um **módulo de setup** independente e autocontido, com seu próprio `install.sh`.

| Módulo | O que faz |
|---|---|
| [`memory/`](memory/) | Hook que expõe a auto-memory de cada projeto como `./memory` (ignorada no git) + o protocolo de captura de memória |

## Instalar tudo

```bash
bash setup/install.sh
```

## Instalar um módulo só

```bash
bash setup/memory/install.sh
```
