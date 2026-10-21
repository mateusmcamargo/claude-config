# Solução de problemas

## O PowerShell bloqueia a execução do script

Mensagem típica: "a execução de scripts foi desabilitada neste sistema".

Executar o script ignorando a política apenas nesta chamada:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\setup.ps1
```

## `jq` não encontrado (Linux e macOS)

Instalar o `jq` com `sudo apt install jq` ou `brew install jq` e executar o setup novamente.

## A barra de status não aparece

1. Executar `scripts/doctor` e verificar o item `statusLine configurado`.
2. Conferir se o caminho em `statusLine.command` dentro de `~/.claude/settings.json` existe.
3. Reiniciar o Claude Code.
4. Executar o teste manual descrito em [statusline.md](statusline.md) para identificar erros do script.

## Caracteres acentuados ou ícones aparecem incorretos

Utilizar um terminal com codificação UTF-8 e fonte que contenha os símbolos usados (barras e emojis). No Windows, o Windows Terminal é recomendado.

## `settings.json` inválido

O setup cria uma cópia de segurança antes de alterar o arquivo. Para restaurar:

```powershell
Copy-Item "$HOME\.claude\settings.json.bak-<data e hora>" "$HOME\.claude\settings.json" -Force
```

## Testar sem alterar a configuração real

Definir `CLAUDE_HOME` para um diretório temporário e usar a simulação:

```powershell
$env:CLAUDE_HOME = "$env:TEMP\claude-teste"
.\scripts\setup.ps1 -DryRun
```
