#!/usr/bin/env bash
# Copia a configuração atual de ~/.claude de volta para este repositório (Linux e macOS).
# Uso: ./scripts/sync-from-local.sh
set -euo pipefail
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if [ -f "$CLAUDE_HOME/statusline.sh" ]; then
  cp "$CLAUDE_HOME/statusline.sh" "$ROOT/statusline/statusline.sh"
  echo "[sync] statusline.sh copiado"
fi

# Global instructions: only the files this repository already tracks
for DST in "$ROOT"/instructions/*.md; do
  SRC="$CLAUDE_HOME/$(basename "$DST")"
  if [ -f "$SRC" ]; then
    cp "$SRC" "$DST"
    echo "[sync] $(basename "$DST") copiado"
  fi
done

if [ -f "$CLAUDE_HOME/settings.json" ]; then
  jq '{autoUpdatesChannel, theme, permissions, model} | with_entries(select(.value != null))' \
    "$CLAUDE_HOME/settings.json" > "$ROOT/settings/settings.base.json"
  echo "[sync] settings.base.json atualizado (chaves: autoUpdatesChannel, theme, permissions, model)"
fi
echo '[sync] Revise o resultado com "git diff" antes de registrar o commit.'
