# Preparação de máquina nova

Este documento descreve a sequência recomendada para configurar o Claude Code em uma máquina nova.

## 1. Instalar os pré-requisitos

| Item | Windows | Linux e macOS |
|---|---|---|
| Git | Git for Windows (inclui o Git Bash) | Gerenciador de pacotes (`apt`, `brew`) |
| Claude Code | Instalador oficial, conforme a documentação do produto | Instalador oficial, conforme a documentação do produto |
| jq | Não necessário | `sudo apt install jq` ou `brew install jq` |
| GitHub CLI (opcional) | `winget install GitHub.cli` | `apt` ou `brew` |

## 2. Executar a instalação

Utilizar o comando de uma linha descrito no [README](../README.md) ou clonar o repositório e executar o script correspondente ao sistema operacional.

## 3. Autenticar

```bash
claude        # primeira execução: autenticação da conta
gh auth login # opcional, para operações com o GitHub
```

## 4. Verificar

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
