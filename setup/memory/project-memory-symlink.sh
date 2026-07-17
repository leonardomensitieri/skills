#!/usr/bin/env bash
# SessionStart: exposes the project's auto-memory folder as ./memory and git-ignores it.
# Contract: no stdout (SessionStart injects stdout into context) and never blocks the session.
set -uo pipefail

input="$(cat)"
command -v jq >/dev/null 2>&1 || exit 0

transcript="$(printf '%s' "$input" | jq -r '.transcript_path // empty')"
cwd="$(printf '%s' "$input" | jq -r '.cwd // empty')"
[ -n "$transcript" ] && [ -n "$cwd" ] || exit 0

# canonical auto-memory folder = sibling of the transcript file
memdir="$(dirname "$transcript")/memory"
mkdir -p "$memdir" 2>/dev/null || true

# symlink ./memory at the project root — never clobber a real 'memory' folder
link="$cwd/memory"
if [ ! -e "$link" ] || [ -L "$link" ]; then
  ln -snf "$memdir" "$link" 2>/dev/null || true
fi

# in a git repo, ignore the symlink locally (never commit/publish it)
if gitdir="$(git -C "$cwd" rev-parse --absolute-git-dir 2>/dev/null)"; then
  prefix="$(git -C "$cwd" rev-parse --show-prefix 2>/dev/null || true)"  # "" at root, "sub/" in a subfolder
  line="/${prefix}memory"
  exclude="$gitdir/info/exclude"
  grep -qxF "$line" "$exclude" 2>/dev/null || printf '%s\n' "$line" >> "$exclude"
fi

exit 0
