#!/usr/bin/env bash
# Claude Code status line for Linux and macOS. Requires jq and git.
# Line 1: context bar, repository (branch).
# Line 2: weekly usage, time until reset, current file.
# Line 3: model, last action, lines added/removed, tokens, prompt cache, session time.

input="$(cat)"
j() { echo "$input" | jq -r "$1 // empty" 2>/dev/null; }

model="$(j '.model.display_name')"; [ -n "$model" ] || model="$(j '.model.id')"; [ -n "$model" ] || model="?"
cwd="$(j '.workspace.current_dir')"; [ -n "$cwd" ] || cwd="$(j '.cwd')"
pct="$(j '.context_window.used_percentage')"; pct="${pct%%.*}"; pct="${pct:-0}"
tin="$(j '.context_window.total_input_tokens')"; tin="${tin:-0}"
tout="$(j '.context_window.total_output_tokens')"; tout="${tout:-0}"
ms="$(j '.cost.total_duration_ms')"; ms="${ms%%.*}"; ms="${ms:-0}"
added="$(j '.cost.total_lines_added')"; added="${added:-0}"
removed="$(j '.cost.total_lines_removed')"; removed="${removed:-0}"
transcript="$(j '.transcript_path')"

repo=""; branch=""
if [ -n "$cwd" ]; then
    top="$(git -C "$cwd" rev-parse --show-toplevel 2>/dev/null)"
    if [ -n "$top" ]; then repo="$(basename "$top")"; else repo="$(basename "$cwd")"; fi
    branch="$(git -C "$cwd" branch --show-current 2>/dev/null)"
    if [ -z "$branch" ] && [ -n "$top" ]; then
        sha="$(git -C "$cwd" rev-parse --short HEAD 2>/dev/null)"
        [ -n "$sha" ] && branch="detached@$sha"
    fi
fi

# File and last action: most recent tool use in the transcript
file=""; action=""
if [ -n "$transcript" ] && [ -f "$transcript" ]; then
    last="$(tail -n 300 "$transcript" | jq -R 'fromjson? // empty' | jq -cs '
        [.[] | select(.type=="assistant") | .message.content[]? | select(.type=="tool_use")] | last // empty')"
    if [ -n "$last" ]; then
        name="$(echo "$last" | jq -r '.name')"
        fp="$(echo "$last" | jq -r '.input.file_path // empty')"
        [ -n "$fp" ] && file="$(basename "$fp")"
        case "$name" in
            Bash) action="Bash: $(echo "$last" | jq -r '.input.command' | tr -s '[:space:]' ' ')" ;;
            Grep|Glob) action="$name: $(echo "$last" | jq -r '.input.pattern')" ;;
            WebSearch) action="WebSearch: $(echo "$last" | jq -r '.input.query')" ;;
            *) action="$name" ;;
        esac
        [ "${#action}" -gt 45 ] && action="${action:0:44}…"
    fi
fi
if [ -z "$file" ] && [ -n "$cwd" ]; then
    st="$(git -C "$cwd" status --porcelain 2>/dev/null | head -n 1)"
    [ -n "$st" ] && file="$(basename "${st:3}")"
fi

e=$'\033'
reset="$e[0m"; dim="$e[2m"; cyan="$e[36m"; magenta="$e[35m"; green="$e[32m"; red="$e[31m"; yellow="$e[33m"
colorof() { if [ "$1" -ge 80 ]; then echo "$red"; elif [ "$1" -ge 50 ]; then echo "$yellow"; else echo "$green"; fi; }
bar() { # $1=percentage
    local w=10 f=$(( $1 * 10 / 100 )) out="" i
    [ "$f" -gt "$w" ] && f=$w
    for ((i = 0; i < f; i++)); do out+="█"; done
    for ((i = f; i < w; i++)); do out+="░"; done
    echo "$out"
}

total=$(( ${tin%%.*} + ${tout%%.*} ))
if   [ "$total" -ge 1000000 ]; then tokens="$(awk -v n="$total" 'BEGIN{printf "%.1fM", n/1000000}')"
elif [ "$total" -ge 1000 ];    then tokens="$(awk -v n="$total" 'BEGIN{printf "%.1fk", n/1000}')"
else tokens="$total"; fi

secs=$(( ms / 1000 )); h=$(( secs / 3600 )); m=$(( (secs % 3600) / 60 )); s=$(( secs % 60 ))
if [ "$h" -gt 0 ]; then dur="${h}h${m}m"; elif [ "$m" -gt 0 ]; then dur="${m}m${s}s"; else dur="${s}s"; fi

sep="${dim} │ ${reset}"

line1="$(colorof "$pct")$(bar "$pct") ${pct}%${reset}"
if [ -n "$repo" ]; then
    r="📁 $repo"; [ -n "$branch" ] && r+=" ($branch)"
    line1+="${sep}${r}"
fi

parts2=()
wp="$(j '.rate_limits.seven_day.used_percentage')"
if [ -n "$wp" ]; then
    wpct="${wp%%.*}"
    parts2+=("$(colorof "$wpct")$(bar "$wpct") ${wpct}%${reset}")
    wr="$(j '.rate_limits.seven_day.resets_at')"
    if [ -n "$wr" ]; then
        left=$(( wr - $(date +%s) ))
        if [ "$left" -gt 0 ]; then
            d=$(( left / 86400 )); hh=$(( (left % 86400) / 3600 )); mm=$(( (left % 3600) / 60 ))
            if [ "$d" -gt 0 ]; then parts2+=("resets in ${d}d${hh}h"); else parts2+=("resets in ${hh}h${mm}m"); fi
        fi
    fi
fi
[ -n "$file" ] && parts2+=("📄 $file")

join() { local IFS=$'\x1f'; local out="$*"; echo "${out//$'\x1f'/$sep}"; }

parts3=("${magenta}${model}${reset}")
[ -n "$action" ] && parts3+=("⚡ $action")
parts3+=("${green}+${added}${reset} ${red}-${removed}${reset}")
parts3+=("${cyan}${tokens} tok${reset}")
# Prompt cache of the last API call (current_usage is null before the first one)
cread="$(j '.context_window.current_usage.cache_read_input_tokens')"; cread="${cread:-0}"
cwrite="$(j '.context_window.current_usage.cache_creation_input_tokens')"; cwrite="${cwrite:-0}"
cnew="$(j '.context_window.current_usage.input_tokens')"; cnew="${cnew:-0}"
ctotal=$(( cread + cwrite + cnew ))
if [ "$ctotal" -gt 0 ]; then
    hit=$(( cread * 100 / ctotal ))
    if [ "$hit" -ge 90 ]; then cc="$green"; elif [ "$hit" -ge 70 ]; then cc="$yellow"; else cc="$red"; fi
    parts3+=("cache ${cc}${hit}%${reset}")
fi
parts3+=("⏱ $dur")

echo "$line1"
[ "${#parts2[@]}" -gt 0 ] && join "${parts2[@]}"
join "${parts3[@]}"
