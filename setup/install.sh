#!/usr/bin/env bash
# setup/install.sh — runs every available setup module (each subfolder with an install.sh).
set -uo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "=== Setup — Claude Code ==="
found=0
for mod in "$DIR"/*/install.sh; do
  [ -f "$mod" ] || continue
  found=1
  bash "$mod"
done
[ "$found" = 1 ] || echo "  (no modules found in $DIR/*/install.sh)"
echo "=== done ==="
