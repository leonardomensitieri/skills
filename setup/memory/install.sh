#!/usr/bin/env bash
# setup/memory/install.sh
# Installs the "memory" module into the user's ~/.claude: symlink hook + memory protocol.
# Idempotent and non-destructive — safe to run multiple times.
set -uo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
SETTINGS="$CLAUDE_DIR/settings.json"
CLAUDE_MD="$CLAUDE_DIR/CLAUDE.md"
HOOK_SRC="$SCRIPT_DIR/project-memory-symlink.sh"
HOOK_DST="$HOOKS_DIR/project-memory-symlink.sh"

say() { printf '  %s\n' "$*"; }

echo "-> setup/memory — auto-memory hook + protocol"

# 0) prerequisite: jq (needed to edit settings.json safely)
if ! command -v jq >/dev/null 2>&1; then
  echo "x 'jq' not found — required. Install it and re-run:"
  echo "    macOS: brew install jq    |    Debian/Ubuntu: sudo apt install jq"
  exit 1
fi

# 1) copy the hook
mkdir -p "$HOOKS_DIR"
cp "$HOOK_SRC" "$HOOK_DST"
chmod +x "$HOOK_DST"
say "hook -> $HOOK_DST"

# 2) register in settings.json — create if missing, don't duplicate, don't clobber other hooks
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
jq empty "$SETTINGS" || { echo "x settings.json became invalid — restore the .bak"; exit 1; }
say "settings.json -> hooks.SessionStart registered (backup saved)"

# 3) memory protocol in CLAUDE.md — idempotent append
touch "$CLAUDE_MD"
if grep -qF "## Memory — required protocol" "$CLAUDE_MD"; then
  say "CLAUDE.md -> protocol already present (kept)"
else
  printf '\n' >> "$CLAUDE_MD"
  cat "$SCRIPT_DIR/memory-protocol.md" >> "$CLAUDE_MD"
  say "CLAUDE.md -> protocol added"
fi

echo "OK done. Open any project with 'claude' and the ./memory folder appears on its own."
