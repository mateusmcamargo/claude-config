#!/usr/bin/env bash
# Instala a configuração do Claude Code nesta máquina (Linux e macOS).
# Uso: ./scripts/setup.sh [--dry-run]
# Também pode ser executado sem clonar: curl -fsSL <url> | bash
set -euo pipefail

REPO="mateusmcamargo/claude-config"
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
DRY_RUN=0
[ "${1:-}" = "--dry-run" ] && DRY_RUN=1

info() { echo "[setup] $*"; }
plan() { if [ "$DRY_RUN" = 1 ]; then echo "[simulação] $*"; else info "$*"; fi; }

if ! command -v jq >/dev/null 2>&1; then
  echo "Erro: 'jq' é necessário. Instale com 'sudo apt install jq' ou 'brew install jq'." >&2
  exit 1
fi

# Localiza a raiz do repositório; se executado via curl | bash, baixa uma cópia temporária
ROOT=""
if [ -n "${BASH_SOURCE[0]:-}" ] && [ -f "${BASH_SOURCE[0]}" ]; then
  ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
fi
if [ -z "$ROOT" ] || [ ! -f "$ROOT/settings/settings.base.json" ]; then
  TMP="$(mktemp -d)"
  info "Baixando $REPO..."
  curl -fsSL "https://github.com/$REPO/archive/refs/heads/main.tar.gz" | tar -xz -C "$TMP" --strip-components=1
  ROOT="$TMP"
fi

for cmd in git claude; do
  command -v "$cmd" >/dev/null 2>&1 || echo "Aviso: comando '$cmd' não encontrado no PATH. Consulte docs/new-machine.md." >&2
done

SETTINGS="$CLAUDE_HOME/settings.json"
STATUS_DST="$CLAUDE_HOME/statusline.sh"

[ -d "$CLAUDE_HOME" ] || { plan "Criando $CLAUDE_HOME"; [ "$DRY_RUN" = 1 ] || mkdir -p "$CLAUDE_HOME"; }

CURRENT='{}'
if [ -f "$SETTINGS" ]; then
  CURRENT="$(cat "$SETTINGS")"
  [ -n "${CURRENT//[[:space:]]/}" ] || CURRENT='{}'
  BACKUP="$SETTINGS.bak-$(date +%Y%m%d-%H%M%S)"
  plan "Cópia de segurança: $BACKUP"
  [ "$DRY_RUN" = 1 ] || cp "$SETTINGS" "$BACKUP"
fi

plan "Copiando barra de status para $STATUS_DST"
if [ "$DRY_RUN" != 1 ]; then
  cp "$ROOT/statusline/statusline.sh" "$STATUS_DST"
  chmod +x "$STATUS_DST"
fi

MERGED="$(jq -n --argjson cur "$CURRENT" --slurpfile base "$ROOT/settings/settings.base.json" \
  --arg cmd "bash \"$STATUS_DST\"" \
  '$cur * $base[0] * {statusLine: {type: "command", command: $cmd}}')"

plan "Gravando $SETTINGS"
if [ "$DRY_RUN" = 1 ]; then
  echo "$MERGED"
else
  echo "$MERGED" > "$SETTINGS"
fi

# Servidores MCP (registrados em ~/.claude.json pelo comando 'claude mcp', não por settings.json)
for NAME in $(jq -r 'keys[]' "$ROOT/settings/mcp.json"); do
  if ! command -v claude >/dev/null 2>&1; then
    echo "Aviso: servidor MCP '$NAME' não registrado: comando 'claude' ausente." >&2
    continue
  fi
  BIN="$(jq -r --arg n "$NAME" '.[$n].command' "$ROOT/settings/mcp.json")"
  command -v "$BIN" >/dev/null 2>&1 || echo "Aviso: o servidor MCP '$NAME' requer '$BIN' no PATH. Consulte docs/new-machine.md." >&2
  if claude mcp get "$NAME" >/dev/null 2>&1; then info "Servidor MCP '$NAME' já registrado"; continue; fi
  plan "Registrando servidor MCP '$NAME'"
  [ "$DRY_RUN" = 1 ] || claude mcp add-json --scope user "$NAME" "$(jq -c --arg n "$NAME" '.[$n]' "$ROOT/settings/mcp.json")" >/dev/null
done

[ "$DRY_RUN" = 1 ] || info 'Concluído. Execute "claude" para autenticar, se necessário.'
