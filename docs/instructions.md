# Instruções globais

A pasta `instructions/` contém as instruções que o Claude Code lê no início de toda sessão, em qualquer projeto. O script de instalação copia cada arquivo `.md` dessa pasta para `~/.claude/`.

## Arquivos

| Arquivo | Destino | Conteúdo |
|---|---|---|
| `CLAUDE.md` | `~/.claude/CLAUDE.md` | Preferências de código: comentários em inglês e indentação de 4 espaços |
| `keybindings.md` | `~/.claude/keybindings.md` | Atalhos de teclado e mouse em uso (Hyprland, barra de título, Waybar, VSCodium, Neovim e outros programas) |

O `CLAUDE.md` importa o `keybindings.md` com a referência `@keybindings.md`, resolvida a partir do diretório do próprio arquivo. Por esse motivo, os dois arquivos precisam ficar na mesma pasta.

## Regras de instalação

1. Um arquivo idêntico ao do repositório não é alterado, o que torna a execução repetida segura.
2. Um arquivo existente e diferente é copiado para `<nome>.bak-<data e hora>` antes de ser substituído.
3. Arquivos de `~/.claude` que não existem em `instructions/` não são alterados.

## Manutenção

Ao criar, alterar ou remover um atalho, atualizar `instructions/keybindings.md`. Alterações feitas diretamente em `~/.claude/CLAUDE.md` ou `~/.claude/keybindings.md` voltam ao repositório com o script `sync-from-local`, que copia apenas os arquivos já presentes em `instructions/`.
