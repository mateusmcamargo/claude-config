# Preparação de máquina nova

Este documento descreve a sequência recomendada para configurar o Claude Code em uma máquina nova.

## 1. Instalar os pré-requisitos

| Item | Windows | Linux e macOS |
|---|---|---|
| Git | Git for Windows (inclui o Git Bash) | Gerenciador de pacotes (`apt`, `brew`) |
| Claude Code | Instalador oficial, conforme a documentação do produto | Instalador oficial, conforme a documentação do produto |
| Node.js (inclui o `npx`) | Instalador oficial ou `winget install OpenJS.NodeJS.LTS` | Gerenciador de pacotes (`apt`, `brew`) |
| jq | Não necessário | `sudo apt install jq` ou `brew install jq` |
| GitHub CLI (opcional) | `winget install GitHub.cli` | `apt` ou `brew` |

## 2. Executar a instalação

Utilizar o comando de uma linha descrito no [README](../README.md) ou clonar o repositório e executar o script correspondente ao sistema operacional.

## 3. Instalar o navegador do Playwright

O servidor MCP `playwright` utiliza o Chromium distribuído pelo Playwright. A instalação é feita uma única vez por máquina e não requer privilégios de administrador:

```bash
npx -y -p @playwright/mcp@latest playwright install chromium
```

O comando utiliza a mesma versão do Playwright empregada pelo servidor MCP, o que garante a compatibilidade do navegador. Em distribuições Linux sem suporte oficial, como o Arch Linux, o Playwright emite um aviso e instala a versão compilada para Ubuntu, que funciona normalmente.

## 4. Autenticar

```bash
claude        # primeira execução: autenticação da conta
gh auth login # opcional, para operações com o GitHub
```

## 5. Verificar

```powershell
.\scripts\doctor.ps1
```

```bash
./scripts/doctor.sh
```

O resultado deve indicar todos os itens como `[ok]`. Itens marcados como `[falta]` incluem a ação corretiva.

## Observações

- As skills sincronizadas pertencem à conta e são restauradas após a autenticação.
- Credenciais não fazem parte deste repositório e devem ser informadas em cada máquina.
