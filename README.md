# claude-config

Configuração pessoal do [Claude Code](https://claude.com/claude-code), preparada para ser restaurada em qualquer máquina com um único comando.

## Instalação rápida

Pré-requisitos: Claude Code e `git` instalados (ver [docs/new-machine.md](docs/new-machine.md)).

**Windows (PowerShell):**

```powershell
iex ((irm https://raw.githubusercontent.com/mateusmcamargo/claude-config/main/scripts/setup.ps1).TrimStart([char]0xFEFF))
```

**Linux e macOS:**

```bash
curl -fsSL https://raw.githubusercontent.com/mateusmcamargo/claude-config/main/scripts/setup.sh | bash
```

**Por clonagem do repositório:**

```bash
git clone https://github.com/mateusmcamargo/claude-config.git
cd claude-config
./scripts/setup.sh        # Linux e macOS
.\scripts\setup.ps1       # Windows
```

### Simulação sem alterações

Para listar as ações sem executá-las, use o parâmetro de simulação:

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/mateusmcamargo/claude-config/main/scripts/setup.ps1).TrimStart([char]0xFEFF))) -DryRun
```

```bash
curl -fsSL https://raw.githubusercontent.com/mateusmcamargo/claude-config/main/scripts/setup.sh | bash -s -- --dry-run
```

## Itens instalados

| Item | Destino | Descrição |
|---|---|---|
| Configurações | `~/.claude/settings.json` | Tema `dark-ansi`, canal de atualização `latest`, modo de permissão `plan` e modelo `opus` |
| Barra de status | `~/.claude/statusline.ps1` ou `statusline.sh` | Três linhas: contexto, repositório e ramo, uso semanal, modelo, tokens e tempo de sessão |
| Servidor MCP | `~/.claude.json` (escopo de usuário) | Playwright (`@playwright/mcp`) com o navegador Chromium, para o Claude Code controlar um navegador e testar aplicações. Requer Node.js e a instalação do navegador (ver [docs/new-machine.md](docs/new-machine.md)) |

O comando do Windows remove o caractere de marcação de ordem de bytes (BOM) do script, necessário para que o PowerShell 5.1 leia corretamente os acentos.

O script de instalação mescla as configurações ao `settings.json` existente: as chaves do repositório prevalecem e as demais são preservadas. Antes de qualquer alteração, é criada uma cópia de segurança. A execução repetida é segura.

## Estrutura

```
settings/    configurações base e servidores MCP em JSON
statusline/  barra de status para Windows e Linux/macOS
scripts/     setup, sync-from-local e doctor
docs/        documentação e solução de problemas
```

## Scripts

| Script | Função |
|---|---|
| `setup` | Aplica a configuração na máquina atual |
| `doctor` | Verifica pré-requisitos e se a configuração está aplicada |
| `sync-from-local` | Copia as alterações feitas em `~/.claude` de volta para o repositório |

## Manutenção

Após alterar a configuração do Claude Code, executar `sync-from-local`, revisar o `git diff` e registrar a alteração em um commit.

## Itens não versionados

Credenciais (`.credentials.json`), histórico, sessões e projetos nunca são versionados. As skills sincronizadas pertencem à conta e não precisam constar no repositório.

## Documentação

- [Preparação de máquina nova](docs/new-machine.md)
- [Configurações](docs/settings.md)
- [Barra de status](docs/statusline.md)
- [Solução de problemas](docs/troubleshooting.md)
