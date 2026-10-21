# Verifica pré-requisitos e se a configuração está aplicada (Windows).
# Uso: .\scripts\doctor.ps1
$ClaudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
$falhas = 0

function Check($ok, $nome, $dica) {
    if ($ok) { Write-Host "[ok]    $nome" }
    else { Write-Host "[falta] $nome. $dica"; $script:falhas++ }
}

Check ([bool](Get-Command git -ErrorAction SilentlyContinue)) 'git instalado' 'Instale o Git for Windows.'
Check ([bool](Get-Command claude -ErrorAction SilentlyContinue)) 'claude instalado' 'Consulte docs/new-machine.md.'
Check ([bool](Get-Command gh -ErrorAction SilentlyContinue)) 'gh instalado (opcional)' 'Necessário apenas para publicar repositórios.'

$settings = Join-Path $ClaudeHome 'settings.json'
$cfg = $null
if (Test-Path $settings) { try { $cfg = Get-Content $settings -Raw | ConvertFrom-Json } catch { } }
Check ($null -ne $cfg) 'settings.json existe e é um JSON válido' 'Execute scripts\setup.ps1.'
if ($cfg) {
    Check ($cfg.theme -eq 'dark-ansi') 'tema dark-ansi' 'Execute scripts\setup.ps1.'
    Check ($cfg.permissions.defaultMode -eq 'plan') 'modo de permissão plan' 'Execute scripts\setup.ps1.'
    Check ($null -ne $cfg.statusLine) 'statusLine configurado' 'Execute scripts\setup.ps1.'
}
Check (Test-Path (Join-Path $ClaudeHome 'statusline.ps1')) 'statusline.ps1 instalado' 'Execute scripts\setup.ps1.'

if (Get-Command claude -ErrorAction SilentlyContinue) {
    claude mcp get playwright *> $null
    Check ($LASTEXITCODE -eq 0) 'servidor MCP playwright registrado' 'Execute scripts\setup.ps1.'
}
Check ([bool](Get-Command npx -ErrorAction SilentlyContinue)) 'npx instalado (Node.js)' 'Instale o Node.js; o servidor MCP playwright o utiliza.'

if ($falhas -gt 0) { Write-Host "$falhas item(ns) pendente(s)."; exit 1 }
Write-Host 'Configuração aplicada.'
