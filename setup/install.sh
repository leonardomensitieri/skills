#!/usr/bin/env bash
# setup/install.sh — roda todos os módulos de setup disponíveis (cada subpasta com um install.sh).
set -uo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"

echo "═══ Setup — Claude Code (Leonardo) ═══"
found=0
for mod in "$DIR"/*/install.sh; do
  [ -f "$mod" ] || continue
  found=1
  bash "$mod"
done
[ "$found" = 1 ] || echo "  (nenhum módulo encontrado em $DIR/*/install.sh)"
echo "═══ concluído ═══"
