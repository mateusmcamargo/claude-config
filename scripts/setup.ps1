# Instala a configuração do Claude Code nesta máquina (Windows PowerShell 5.1 ou superior).
# Uso: .\scripts\setup.ps1 [-DryRun]
# Também pode ser executado sem clonar: irm <url> | iex
param([switch]$DryRun)

$ErrorActionPreference = 'Stop'
$Repo = 'mateusmcamargo/claude-config'
$ClaudeHome = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME '.claude' }

function Info($m) { Write-Host "[setup] $m" }
function Plan($m) { if ($DryRun) { Write-Host "[simulação] $m" } else { Info $m } }

# Localiza a raiz do repositório; se executado via irm | iex, baixa uma cópia temporária
$root = $null
if ($PSScriptRoot) { $root = Split-Path $PSScriptRoot -Parent }
if (-not $root -or -not (Test-Path (Join-Path $root 'settings\settings.base.json'))) {
    $tmp = Join-Path ([IO.Path]::GetTempPath()) ("claude-config-" + [guid]::NewGuid().ToString('N'))
    New-Item -ItemType Directory -Path $tmp | Out-Null
    $zip = Join-Path $tmp 'repo.zip'
    Info "Baixando $Repo..."
    Invoke-WebRequest -UseBasicParsing "https://github.com/$Repo/archive/refs/heads/main.zip" -OutFile $zip
    Expand-Archive $zip -DestinationPath $tmp
    $root = Join-Path $tmp 'claude-config-main'
}

# Pré-requisitos (apenas avisos)
foreach ($cmd in 'git', 'claude') {
    if (-not (Get-Command $cmd -ErrorAction SilentlyContinue)) {
        Write-Warning "Comando '$cmd' não encontrado no PATH. Consulte docs/new-machine.md."
    }
}

function Merge-Object($target, $source) {
    foreach ($p in $source.PSObject.Properties) {
        $cur = $target.PSObject.Properties[$p.Name]
        if ($cur -and $cur.Value -is [pscustomobject] -and $p.Value -is [pscustomobject]) {
            Merge-Object $cur.Value $p.Value
        } else {
            $target | Add-Member -NotePropertyName $p.Name -NotePropertyValue $p.Value -Force
        }
    }
}

$utf8 = New-Object System.Text.UTF8Encoding $false
$settingsPath = Join-Path $ClaudeHome 'settings.json'
$statusSrc = Join-Path $root 'statusline\statusline.ps1'
$statusDst = Join-Path $ClaudeHome 'statusline.ps1'

if (-not (Test-Path $ClaudeHome)) { Plan "Criando $ClaudeHome"; if (-not $DryRun) { New-Item -ItemType Directory -Path $ClaudeHome | Out-Null } }

# Global instructions (CLAUDE.md and the files it imports, such as keybindings.md)
$stamp = Get-Date -Format 'yyyyMMdd-HHmmss'
foreach ($src in Get-ChildItem (Join-Path $root 'instructions') -Filter '*.md') {
    $dst = Join-Path $ClaudeHome $src.Name
    if ((Test-Path $dst) -and ((Get-FileHash $dst).Hash -eq (Get-FileHash $src.FullName).Hash)) { continue }
    if (Test-Path $dst) {
        Plan "Cópia de segurança: $dst.bak-$stamp"
        if (-not $DryRun) { Copy-Item $dst "$dst.bak-$stamp" }
    }
    Plan "Copiando instruções para $dst"
    if (-not $DryRun) { Copy-Item $src.FullName $dst -Force }
}

# Estado atual das configurações
$current = New-Object psobject
if (Test-Path $settingsPath) {
    $raw = Get-Content $settingsPath -Raw
    if ($raw -and $raw.Trim()) { $current = $raw | ConvertFrom-Json }
    $backup = "$settingsPath.bak-" + (Get-Date -Format 'yyyyMMdd-HHmmss')
    Plan "Cópia de segurança: $backup"
    if (-not $DryRun) { Copy-Item $settingsPath $backup }
}

Plan "Copiando barra de status para $statusDst"
if (-not $DryRun) { Copy-Item $statusSrc $statusDst -Force }

$base = Get-Content (Join-Path $root 'settings\settings.base.json') -Raw | ConvertFrom-Json
Merge-Object $current $base
$cmd = 'powershell -NoProfile -ExecutionPolicy Bypass -File "' + ($statusDst -replace '\\', '/') + '"'
$status = [pscustomobject]@{ type = 'command'; command = $cmd }
$current | Add-Member -NotePropertyName statusLine -NotePropertyValue $status -Force

Plan "Gravando $settingsPath"
if ($DryRun) {
    Write-Host ($current | ConvertTo-Json -Depth 10)
} else {
    [IO.File]::WriteAllText($settingsPath, ($current | ConvertTo-Json -Depth 10), $utf8)
}

# Servidores MCP (registrados em ~/.claude.json pelo comando 'claude mcp', não por settings.json)
$mcp = Get-Content (Join-Path $root 'settings\mcp.json') -Raw | ConvertFrom-Json
foreach ($s in $mcp.PSObject.Properties) {
    if (-not (Get-Command claude -ErrorAction SilentlyContinue)) {
        Write-Warning "Servidor MCP '$($s.Name)' não registrado: comando 'claude' ausente."
        continue
    }
    if (-not (Get-Command $s.Value.command -ErrorAction SilentlyContinue)) {
        Write-Warning "O servidor MCP '$($s.Name)' requer '$($s.Value.command)' no PATH. Consulte docs/new-machine.md."
    }
    cmd /c "claude mcp get $($s.Name) >nul 2>&1"
    if ($LASTEXITCODE -eq 0) { Info "Servidor MCP '$($s.Name)' já registrado"; continue }
    Plan "Registrando servidor MCP '$($s.Name)'"
    if (-not $DryRun) {
        $json = $s.Value | ConvertTo-Json -Compress
        claude mcp add-json --scope user $s.Name ($json -replace '"', '\"') | Out-Null
    }
}

if (-not $DryRun) { Info 'Concluído. Execute "claude" para autenticar, se necessário.' }
