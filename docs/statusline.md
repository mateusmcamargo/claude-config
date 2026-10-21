# Barra de status

A barra de status exibe três linhas e é executada pelo Claude Code a cada atualização da interface. O Claude Code envia um JSON pela entrada padrão; o script interpreta esse conteúdo e imprime o texto formatado.

## Arquivos

| Sistema | Arquivo | Dependências |
|---|---|---|
| Windows | `statusline/statusline.ps1` | PowerShell e `git` |
| Linux e macOS | `statusline/statusline.sh` | `bash`, `jq` e `git` |

## Conteúdo exibido

| Linha | Itens |
|---|---|
| 1 | Barra de uso do contexto, nome do repositório e ramo atual |
| 2 | Barra de uso semanal, tempo até o reinício do limite e último arquivo manipulado |
| 3 | Modelo, última ação, linhas adicionadas e removidas, total de tokens, taxa de acerto do cache de prompt e duração da sessão |

A taxa de acerto do cache é a razão entre os tokens lidos do cache e o total de tokens de entrada da última chamada à API (lidos, gravados e não armazenados). Verde indica 90% ou mais, amarelo de 70% a 89% e vermelho abaixo de 70%. O item é omitido enquanto não houver chamada registrada.

A segunda linha depende dos dados de limite de uso (`rate_limits`), disponíveis apenas em alguns planos. Na ausência desses dados, são exibidos somente o arquivo atual ou nenhum item.

## Cores das barras

| Faixa de uso | Cor |
|---|---|
| Abaixo de 50% | Verde |
| De 50% a 79% | Amarelo |
| 80% ou mais | Vermelho |

## Campos lidos do JSON

`model.display_name`, `workspace.current_dir`, `context_window.used_percentage`, `context_window.current_usage`, `context_window.total_input_tokens`, `context_window.total_output_tokens`, `cost.total_duration_ms`, `cost.total_lines_added`, `cost.total_lines_removed`, `transcript_path` e `rate_limits.seven_day`.

## Teste manual

```powershell
'{"model":{"display_name":"Teste"},"context_window":{"used_percentage":42}}' | powershell -NoProfile -File statusline\statusline.ps1
```

## Personalização

As duas versões devem manter o mesmo layout. Ao alterar uma, aplicar a mudança equivalente na outra e atualizar este documento.
