#!/usr/bin/env bash
# Verifica pré-requisitos e se a configuração está aplicada (Linux e macOS).
# Uso: ./scripts/doctor.sh
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
falhas=0

check() { # $1=condição (0 = ok) $2=nome $3=dica
  if [ "$1" = 0 ]; then echo "[ok]    $2"; else echo "[falta] $2. $3"; falhas=$((falhas + 1)); fi
}
has() { command -v "$1" >/dev/null 2>&1; echo $?; }

check "$(has git)" 'git instalado' 'Instale o git pelo gerenciador de pacotes.'
check "$(has jq)" 'jq instalado' 'Instale com apt ou brew.'
check "$(has claude)" 'claude instalado' 'Consulte docs/new-machine.md.'
check "$(has gh)" 'gh instalado (opcional)' 'Necessário apenas para publicar repositórios.'

S="$CLAUDE_HOME/settings.json"
if [ -f "$S" ] && jq empty "$S" >/dev/null 2>&1; then v=0; else v=1; fi
check "$v" 'settings.json existe e é um JSON válido' 'Execute scripts/setup.sh.'
if [ "$v" = 0 ]; then
  check "$([ "$(jq -r .theme "$S")" = dark-ansi ]; echo $?)" 'tema dark-ansi' 'Execute scripts/setup.sh.'
  check "$([ "$(jq -r .permissions.defaultMode "$S")" = plan ]; echo $?)" 'modo de permissão plan' 'Execute scripts/setup.sh.'
  check "$([ "$(jq -r '.statusLine.command // empty' "$S")" != '' ]; echo $?)" 'statusLine configurado' 'Execute scripts/setup.sh.'
fi
check "$([ -f "$CLAUDE_HOME/statusline.sh" ]; echo $?)" 'statusline.sh instalado' 'Execute scripts/setup.sh.'

if command -v claude >/dev/null 2>&1; then
  check "$(claude mcp get playwright >/dev/null 2>&1; echo $?)" 'servidor MCP playwright registrado' 'Execute scripts/setup.sh.'
fi
check "$(has npx)" 'npx instalado (Node.js)' 'Instale o Node.js; o servidor MCP playwright o utiliza.'

if [ "$falhas" -gt 0 ]; then echo "$falhas item(ns) pendente(s)."; exit 1; fi
echo 'Configuração aplicada.'
