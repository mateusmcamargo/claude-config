# Copia a configuração atual de ~/.claude de volta para este repositório (Windows).
# Uso: .\scripts\sync-from-local.ps1
$ErrorActionPreference = 'Stop'
$ClaudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }
$root = Split-Path $PSScriptRoot -Parent
$utf8 = New-Object System.Text.UTF8Encoding $false

$src = Join-Path $ClaudeHome 'statusline.ps1'
if (Test-Path $src) {
    Copy-Item $src (Join-Path $root 'statusline\statusline.ps1') -Force
    Write-Host '[sync] statusline.ps1 copiado'
}

# Global instructions: only the files this repository already tracks
foreach ($dst in Get-ChildItem (Join-Path $root 'instructions') -Filter '*.md') {
    $src = Join-Path $ClaudeHome $dst.Name
    if (Test-Path $src) {
        Copy-Item $src $dst.FullName -Force
        Write-Host "[sync] $($dst.Name) copiado"
    }
}

$settings = Join-Path $ClaudeHome 'settings.json'
if (Test-Path $settings) {
    $cur = Get-Content $settings -Raw | ConvertFrom-Json
    $out = [ordered]@{}
    foreach ($k in 'autoUpdatesChannel', 'theme', 'permissions', 'model') {
        if ($cur.PSObject.Properties[$k]) { $out[$k] = $cur.$k }
    }
    [IO.File]::WriteAllText((Join-Path $root 'settings\settings.base.json'), (($out | ConvertTo-Json -Depth 10) + "`n"), $utf8)
    Write-Host '[sync] settings.base.json atualizado (chaves: autoUpdatesChannel, theme, permissions, model)'
}
Write-Host '[sync] Revise o resultado com "git diff" antes de registrar o commit.'
