#!/usr/bin/env bash
# SessionStart: expõe a pasta de auto-memory do projeto como ./memory e a ignora no git.
# Contrato: sem stdout (SessionStart injeta stdout no contexto) e nunca bloqueia a sessão.
set -uo pipefail

input="$(cat)"
command -v jq >/dev/null 2>&1 || exit 0

transcript="$(printf '%s' "$input" | jq -r '.transcript_path // empty')"
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty')"
[ -n "$transcript" ] && [ -n "$cwd" ] || exit 0

# pasta canônica de auto-memory = irmã do arquivo de transcript
memdir="$(dirname "$transcript")/memory"
mkdir -p "$memdir" 2>/dev/null || true

# symlink ./memory na raiz do projeto — nunca sobrescreve uma pasta 'memory' real
link="$cwd/memory"
if [ ! -e "$link" ] || [ -L "$link" ]; then
  ln -snf "$memdir" "$link" 2>/dev/null || true
fi

# se for repo git, ignora o symlink localmente (nunca commitar/publicar)
if gitdir="$(git -C "$cwd" rev-parse --absolute-git-dir 2>/dev/null)"; then
  prefix="$(git -C "$cwd" rev-parse --show-prefix 2>/dev/null || true)"  # "" na raiz, "sub/" em subpasta
  line="/${prefix}memory"
  exclude="$gitdir/info/exclude"
  grep -qxF "$line" "$exclude" 2>/dev/null || printf '%s\n' "$line" >> "$exclude"
fi

exit 0
