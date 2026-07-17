#!/usr/bin/env bash
# setup/memory/install.sh
# Instala o módulo "memory" no ~/.claude do usuário: hook de symlink + protocolo de memória.
# Idempotente e não-destrutivo — seguro rodar várias vezes.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS="$CLAUDE_DIR/settings.json"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
HOOK_SRC="$SCRIPT_DIR/project-memory-symlink.sh"
HOOK_DST="$HOOKS_DIR/project-memory-symlink.sh"

say() { printf '  %s\n' "$*"; }

echo "▶ setup/memory — hook de auto-memory + protocolo"

# 0) pré-requisito: jq (necessário pra editar o settings.json com segurança)
if ! command -v jq >/dev/null 2>&1; then
  echo "✗ 'jq' não encontrado — necessário. Instale e rode de novo:"
  echo "    macOS: brew install jq    ·    Debian/Ubuntu: sudo apt install jq"
  exit 1
fi

# 1) copia o hook
mkdir -p "$HOOKS_DIR"
cp "$HOOK_SRC" "$HOOK_DST"
chmod +x "$HOOK_DST"
say "hook → $HOOK_DST"

# 2) registra no settings.json — cria se não existir, não duplica, não clobber outros hooks
[ -f "$SETTINGS" ] || echo '{}' > "$SETTINGS"
cp "$SETTINGS" "$SETTINGS.bak-$(date +%Y%m%d-%H%M%S)"
jq --arg cmd "$HOOK_DST" '
  .hooks //= {} |
  .hooks.SessionStart //= [] |
  if any(.hooks.SessionStart[]?; (.hooks[]?.command) == $cmd)
  then .
  else .hooks.SessionStart += [ { "hooks": [ { "type": "command", "command": $cmd } ] } ]
  end
' "$SETTINGS" > "$SETTINGS.tmp" && mv "$SETTINGS.tmp" "$SETTINGS"
jq empty "$SETTINGS" || { echo "✗ settings.json ficou inválido — restaure o .bak"; exit 1; }
say "settings.json → hooks.SessionStart registrado (backup salvo)"

# 3) protocolo no CLAUDE.md — append idempotente
touch "$CLAUDE_MD"
if grep -qF "## Memória — protocolo obrigatório" "$CLAUDE_MD"; then
  say "CLAUDE.md → protocolo já presente (mantido)"
else
  printf '\n' >> "$CLAUDE_MD"
  cat "$SCRIPT_DIR/memory-protocol.md" >> "$CLAUDE_MD"
  say "CLAUDE.md → protocolo adicionado"
fi

echo "✓ pronto. Abra qualquer projeto com 'claude' e a pasta ./memory aparece sozinha."
