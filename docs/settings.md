# Configurações

As configurações base estão em `settings/settings.base.json` e são mescladas ao `~/.claude/settings.json` pelo script de instalação.

## Chaves gerenciadas

| Chave | Valor | Efeito |
|---|---|---|
| `autoUpdatesChannel` | `latest` | O Claude Code recebe as versões mais recentes assim que publicadas |
| `theme` | `dark-ansi` | Tema escuro com cores ANSI do terminal |
| `permissions.defaultMode` | `plan` | Cada sessão inicia em modo de planejamento, sem executar alterações até a aprovação do plano |
| `model` | `opus` | Cada sessão inicia com o modelo Opus |
| `statusLine` | gerada | Comando da barra de status, gerado pelo setup com o caminho da máquina atual |

## Regras de mesclagem

1. O arquivo existente é copiado para `settings.json.bak-<data e hora>`.
2. As chaves de `settings.base.json` sobrescrevem as chaves de mesmo nome.
3. Objetos aninhados, como `permissions`, são mesclados campo a campo, preservando regras como `allow` e `deny` já existentes.
4. A chave `statusLine` é sempre regenerada.

## Servidores MCP

Os servidores MCP são definidos em `settings/mcp.json` e não em `settings.base.json`, pois o Claude Code os guarda em `~/.claude.json`, e não em `settings.json`. O script de instalação registra cada servidor com `claude mcp add-json --scope user`, apenas quando ainda não estiver registrado, de modo que a execução repetida não gera duplicidade. No modo de simulação, a ação é somente listada.

| Servidor | Comando | Finalidade |
|---|---|---|
| `playwright` | `npx @playwright/mcp@latest --browser chromium` | Controle de navegador para testar aplicações web. Requer Node.js |

O parâmetro `--browser chromium` faz o servidor utilizar o Chrome for Testing, distribuído pelo próprio Playwright, em vez do Google Chrome instalado no sistema. Dessa forma, o navegador não depende de instalação com privilégios de administrador e funciona em distribuições Linux sem pacote oficial do Google Chrome. O navegador é instalado uma única vez por máquina, conforme descrito em [new-machine.md](new-machine.md).

Como o script de instalação não altera servidores já registrados, uma máquina com o registro anterior deve removê-lo com `claude mcp remove playwright -s user` e executar o setup novamente.

Para adicionar outro servidor, incluir uma entrada em `settings/mcp.json` com os campos `command` e `args`. O `scripts/doctor` verifica o registro do servidor `playwright`.

## Como adicionar uma nova configuração

1. Alterar a configuração no Claude Code (por exemplo, pelo comando `/config`).
2. Executar `scripts/sync-from-local`. Apenas as chaves `autoUpdatesChannel`, `theme`, `permissions` e `model` são copiadas.
3. Para gerenciar outra chave, editar `settings/settings.base.json` manualmente e ajustar a lista de chaves nos scripts `sync-from-local`.
4. Registrar a alteração em um commit.
