# claude-config

Repositório com a configuração pessoal do Claude Code de Mateus, restaurada em máquinas novas por `scripts/setup.ps1` (Windows) e `scripts/setup.sh` (Linux/macOS). Mantido por uma única pessoa: prefira soluções simples e diretas.

## Regras

- **Nunca** versionar segredos: `.credentials.json`, `history.jsonl`, tokens, `sessions/`, `projects/`. Conferir `git status` e `git diff --cached` antes de cada commit
- Nada de caminhos absolutos de usuário (como `C:/Users/...`) em arquivos versionados. O caminho do `statusLine` é gerado pelo setup em cada máquina
- `settings/settings.base.json` não contém `statusLine`: ele é sempre gerado pelo setup
- Scripts devem ser idempotentes, fazer backup antes de alterar `settings.json` e aceitar `-DryRun` / `--dry-run`
- O setup preserva as chaves do usuário que não constam em `settings.base.json`
- A variável `CLAUDE_HOME` (opcional) aponta para outro diretório no lugar de `~/.claude`, usada para testar sem alterar a configuração real
- `setup.ps1` deve funcionar no Windows PowerShell 5.1 (sem `&&`, sem `??`) e gravar JSON em UTF-8 sem BOM
- `statusline.ps1` e `statusline.sh` devem manter o mesmo layout de três linhas
- Toda mudança de comportamento atualiza o `README.md` e o documento correspondente em `docs/`

## Documentação

- Seguir as normas da ABNT: NBR 6022 e NBR 14724 para estrutura de textos, NBR 10520 para citações e NBR 6023 para referências, quando houver
- Não usar travessão (—) em nenhum texto. Usar vírgulas, parênteses, dois-pontos ou reescrever a frase
- Não usar linguagem coloquial: redação formal, impessoal e objetiva, sem gírias, abreviações informais ou perguntas retóricas
- Escrever em português do Brasil, com terminologia técnica consistente entre os documentos
- Usar títulos hierarquizados, parágrafos curtos e listas apenas para enumerações reais

## Como editar

- Mudanças mínimas: não alterar estilo nem código que não faz parte da tarefa
- Mensagens dos scripts em português do Brasil, também sem travessão e sem linguagem coloquial
- Para testar o setup, usar `CLAUDE_HOME` temporário e `-DryRun`; validar os `.sh` com `bash -n`
- Commits curtos no formato `tipo: descrição` (`feat:`, `fix:`, `docs:`)
