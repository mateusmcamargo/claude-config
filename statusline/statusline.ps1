# Claude Code status line for Windows (PowerShell).
# Line 1: context bar, repo (branch).
# Line 2: weekly usage bar, time until reset, current file.
# Line 3: model, last action, lines added/removed, tokens, session time.
# No jq needed. Requires git in PATH.

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$raw = [Console]::In.ReadToEnd()
try { $d = $raw | ConvertFrom-Json } catch { $d = $null }

function Get-Or($v, $default) { if ($null -ne $v -and "$v" -ne "") { $v } else { $default } }
function Limit($t, $n) { if ($t.Length -gt $n) { $t.Substring(0, $n - 1) + [char]0x2026 } else { $t } }

$model = Get-Or $d.model.display_name (Get-Or $d.model.id "?")
$cwd   = Get-Or $d.workspace.current_dir (Get-Or $d.cwd "")
$pct   = [int][math]::Floor([double](Get-Or $d.context_window.used_percentage 0))
$tin   = [double](Get-Or $d.context_window.total_input_tokens 0)
$tout  = [double](Get-Or $d.context_window.total_output_tokens 0)
$ms    = [double](Get-Or $d.cost.total_duration_ms 0)
$added   = [int](Get-Or $d.cost.total_lines_added 0)
$removed = [int](Get-Or $d.cost.total_lines_removed 0)
$transcript = Get-Or $d.transcript_path ""

# --- Repository and branch ---
$repo = ""; $branch = ""
if ($cwd) {
    $top = git -C $cwd rev-parse --show-toplevel 2>$null
    if ($top) { $repo = Split-Path $top -Leaf } else { $repo = Split-Path $cwd -Leaf }
    $branch = git -C $cwd branch --show-current 2>$null
    if (-not $branch -and $top) {
        $sha = git -C $cwd rev-parse --short HEAD 2>$null
        if ($sha) { $branch = "detached@$sha" }
    }
}

# --- File and last action: most recent tool use in the transcript ---
$file = ""; $action = ""
if ($transcript -and (Test-Path $transcript)) {
    $lastFile = $null; $lastName = $null; $lastInput = $null
    foreach ($line in (Get-Content $transcript -Tail 300 -ErrorAction SilentlyContinue)) {
        try {
            $o = $line | ConvertFrom-Json
            if ($o.type -eq "assistant") {
                foreach ($c in $o.message.content) {
                    if ($c.type -eq "tool_use") {
                        $lastName = $c.name; $lastInput = $c.input
                        if ($c.input.file_path) { $lastFile = $c.input.file_path }
                    }
                }
            }
        } catch { }
    }
    if ($lastFile) { $file = Split-Path $lastFile -Leaf }
    if ($lastName) {
        switch ($lastName) {
            "Bash"      { $action = "Bash: " + ("$($lastInput.command)" -replace "\s+", " ") }
            "Grep"      { $action = "Grep: $($lastInput.pattern)" }
            "Glob"      { $action = "Glob: $($lastInput.pattern)" }
            "WebSearch" { $action = "WebSearch: $($lastInput.query)" }
            default     { $action = $lastName }
        }
        $action = Limit $action 45
    }
}
if (-not $file -and $cwd) {
    $st = git -C $cwd status --porcelain 2>$null | Select-Object -First 1
    if ($st) { $file = Split-Path ($st.Substring(3).Trim()) -Leaf }
}

# --- Colors and bar ---
$e = [char]27
$reset = "$e[0m"; $dim = "$e[2m"; $cyan = "$e[36m"; $magenta = "$e[35m"
$green = "$e[32m"; $red = "$e[31m"; $yellow = "$e[33m"
if     ($pct -ge 80) { $color = $red }
elseif ($pct -ge 50) { $color = $yellow }
else                 { $color = $green }

$width = 10
$filled = [math]::Min($width, [int][math]::Floor($pct * $width / 100))
$bar = ([string][char]0x2588) * $filled + ([string][char]0x2591) * ($width - $filled)

# --- Tokens and time ---
function Format-Tokens($n) {
    if     ($n -ge 1000000) { "{0:N1}M" -f ($n / 1000000) }
    elseif ($n -ge 1000)    { "{0:N1}k" -f ($n / 1000) }
    else                    { "{0:N0}" -f $n }
}
$tokens = (Format-Tokens ($tin + $tout)) -replace ",", "."

$secs = [int][math]::Floor($ms / 1000)
$h = [math]::Floor($secs / 3600); $m = [math]::Floor(($secs % 3600) / 60); $s = $secs % 60
if     ($h -gt 0) { $dur = "${h}h${m}m" }
elseif ($m -gt 0) { $dur = "${m}m${s}s" }
else              { $dur = "${s}s" }

$sep = "$dim " + [char]0x2502 + " $reset"

# --- Line 1: context bar, repo (branch) ---
$line1 = "$color$bar $pct%$reset"
if ($repo) {
    $r = [char]::ConvertFromUtf32(0x1F4C1) + " $repo"
    if ($branch) { $r += " ($branch)" }
    $line1 += $sep + $r
}

# --- Line 2: weekly usage (Pro/Max plans only), reset time, current file ---
$parts2 = @()
$wp = $d.rate_limits.seven_day.used_percentage
if ($null -ne $wp -and "$wp" -ne "") {
    $wpct = [int][math]::Floor([double]$wp)
    if     ($wpct -ge 80) { $wc = $red }
    elseif ($wpct -ge 50) { $wc = $yellow }
    else                  { $wc = $green }
    $wf = [math]::Min($width, [int][math]::Floor($wpct * $width / 100))
    $wbar = ([string][char]0x2588) * $wf + ([string][char]0x2591) * ($width - $wf)
    $parts2 += "$wc$wbar $wpct%$reset"
    try {
        $wr = $d.rate_limits.seven_day.resets_at
        if ($wr) {
            $left = [DateTimeOffset]::FromUnixTimeSeconds([long]$wr) - [DateTimeOffset]::UtcNow
            if ($left.TotalSeconds -gt 0) {
                if ($left.Days -gt 0) { $eta = "$($left.Days)d$($left.Hours)h" }
                else                  { $eta = "$($left.Hours)h$($left.Minutes)m" }
                $parts2 += "resets in $eta"
            }
        }
    } catch { }
}
if ($file) { $parts2 += [char]::ConvertFromUtf32(0x1F4C4) + " $file" }
$line2 = $parts2 -join $sep

# --- Line 3: model, last action, lines changed, tokens, session time ---
$parts3 = @("$magenta$model$reset")
if ($action) { $parts3 += ([string][char]0x26A1) + " $action" }
$parts3 += "$green+$added$reset $red-$removed$reset"
$parts3 += "$cyan$tokens tok$reset"
$parts3 += ([string][char]0x23F1) + " $dur"
$line3 = $parts3 -join $sep

Write-Output $line1
if ($line2) { Write-Output $line2 }
Write-Output $line3
