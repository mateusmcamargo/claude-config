# Configurações

As configurações base estão em `settings/settings.base.json` e são mescladas ao `~/.claude/settings.json` pelo script de instalação.

## Chaves gerenciadas

| Chave | Valor | Efeito |
|---|---|---|
| `autoUpdatesChannel` | `latest` | O Claude Code recebe as versões mais recentes assim que publicadas |
| `theme` | `dark-ansi` | Tema escuro com cores ANSI do terminal |
| `permissions.defaultMode` | `plan` | Cada sessão inicia em modo de planejamento, sem executar alterações até a aprovação do plano |
| `statusLine` | gerada | Comando da barra de status, gerado pelo setup com o caminho da máquina atual |

## Regras de mesclagem

1. O arquivo existente é copiado para `settings.json.bak-<data e hora>`.
2. As chaves de `settings.base.json` sobrescrevem as chaves de mesmo nome.
3. Objetos aninhados, como `permissions`, são mesclados campo a campo, preservando regras como `allow` e `deny` já existentes.
4. A chave `statusLine` é sempre regenerada.

## Como adicionar uma nova configuração

1. Alterar a configuração no Claude Code (por exemplo, pelo comando `/config`).
2. Executar `scripts/sync-from-local`. Apenas as chaves `autoUpdatesChannel`, `theme` e `permissions` são copiadas.
3. Para gerenciar outra chave, editar `settings/settings.base.json` manualmente e ajustar a lista de chaves nos scripts `sync-from-local`.
4. Registrar a alteração em um commit.
