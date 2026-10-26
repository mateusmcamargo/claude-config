# Atalhos em uso

Lista dos atalhos configurados nas máquinas de Mateus. Atualizar este arquivo sempre que um atalho for criado, alterado ou removido.

## Hyprland (sistema)

`SUPER` é a tecla Windows.

| Atalho | Ação |
|---|---|
| `SUPER+Q` | Abre o terminal (kitty) |
| `SUPER+E` | Abre o gerenciador de arquivos (Thunar) |
| `SUPER+F` | Abre o Firefox |
| `SUPER+R` | Abre o menu de aplicativos (rofi, com pastas; Tab/Shift+Tab troca de pasta) |
| `SUPER+/` (também `/` do teclado numérico ou `SUPER+AltGr+Q`) | Abre a folha de atalhos (rofi, com filtro); repetir fecha |
| `SUPER+C` | Fecha a janela em foco |
| `ALT+F4` | Fecha a janela em foco; sem janela no workspace visível, abre o menu de energia |
| `SUPER+M` | Encerra a sessão |
| `SUPER+L` | Bloqueia a tela (hyprlock) |
| `SUPER+V` | Alterna a janela entre solta e encaixada (plugin winsnap) |
| `SUPER+SHIFT+V` | Histórico da área de transferência; o item escolhido é colado na janela ativa |
| `SUPER+SHIFT+ALT+V` | Apaga um item do histórico da área de transferência |
| `SUPER+SHIFT+W` | Próxima animação do papel de parede ASCII |
| `SUPER+P` | Pseudo-tiling |
| `SUPER+J` | Alterna a divisão (layout dwindle) |
| `SUPER+setas` | Movem e encaixam a janela em foco, como no Windows (tabela abaixo); não trocam o foco |
| `SUPER+1..0` | Vai para o workspace 1 a 10 |
| `SUPER+SHIFT+1..0` | Move a janela para o workspace 1 a 10 |
| `SUPER+S` / `SUPER+ALT+S` | Mostra o workspace especial "magic" / move a janela para ele |
| `SUPER+SHIFT+S` | Screenshot de uma área (seleção com o mouse) |
| `Print` / `SUPER+Print` | Screenshot do monitor em foco |
| `ALT+Print` | Screenshot da janela ativa |
| `SUPER+SHIFT+R` | Grava a tela (arrastar = área, clicar = monitor inteiro); de novo para |
| `SUPER+SHIFT+C` | Seletor de cor: clique copia a cor sob o cursor em hex; Esc ou repetir cancela |
| `SUPER+N` | Mostra as janelas minimizadas |
| `ALT+TAB` / `ALT+SHIFT+TAB` | Lista de janelas de todos os workspaces (rofi); segurando ALT, TAB desce e SHIFT+TAB sobe; soltar o ALT troca para a janela marcada; Esc cancela |
| `SUPER+Escape` | Só durante a lista do ALT+TAB: sai do submap "switcher" se ele travar |
| `SUPER+TAB` / `SUPER+SHIFT+TAB` | Próximo / anterior workspace com janelas |
| `SUPER+rolagem do mouse` | Troca de workspace |
| `SUPER+botão esquerdo` / `SUPER+botão direito` | Move / redimensiona a janela |
| Teclas de mídia, volume e brilho | Controlam o player, o volume e o brilho, com aviso na tela |

### SUPER+setas (plugin winsnap)

| Estado da janela | `SUPER+esquerda` | `SUPER+direita` | `SUPER+cima` | `SUPER+baixo` |
|---|---|---|---|---|
| Solta | Metade esquerda | Metade direita | Tela cheia | Minimiza |
| Tela cheia | Metade esquerda | Metade direita | Sem efeito | Solta, 1/4 da tela, centralizada |
| Metade esquerda | Sem efeito | Volta à posição solta anterior | Quarto superior esquerdo | Quarto inferior esquerdo |
| Metade direita | Volta à posição solta anterior | Sem efeito | Quarto superior direito | Quarto inferior direito |
| Quarto superior | Quarto ao lado | Quarto ao lado | Tela cheia | Metade do mesmo lado |
| Quarto inferior | Quarto ao lado | Quarto ao lado | Metade do mesmo lado | Solta, 1/4 da tela, centralizada |

Logo após minimizar com `SUPER+baixo`, `SUPER+cima` restaura a janela, desde que o foco não tenha sido trocado para outra janela.

## Barra de título das janelas (hyprbars e winsnap)

| Ação | Efeito |
|---|---|
| Botão vermelho | Fecha a janela |
| Botão amarelo | Minimiza a janela |
| Botão verde | Alterna entre solta e encaixada, mantendo a posição |
| Clique duplo na barra | Maximiza ou restaura |
| Clique do meio na barra | Fecha a janela |
| Arrastar a barra até a borda da tela | Encaixa em metade, quarto ou tela inteira |

## Waybar

| Ação | Efeito |
|---|---|
| Rolagem sobre o ícone de brilho ou volume | Ajusta o valor e mostra o aviso na tela |
| Clique no ícone de volume | Silencia |
| Clique no nome da faixa | Pausa ou retoma; clique direito avança; rolagem troca de faixa |
| Clique no ícone de brilho | Liga ou desliga a luz noturna na hora (a agenda 19:00–07:00 retoma no próximo horário) |
| Clique na câmera (esquerda) | Começa ou para a gravação de tela; clique direito alterna o áudio: nenhum → microfone → sistema |
| Clique no ícone da bateria | Alterna o perfil de energia: power-saver → balanced → performance |
| Clique no sino | Liga ou desliga o modo não perturbe; clique direito reabre a última; clique do meio limpa |

## VSCodium

Esquema igual ao do VS Code no Windows.

| Atalho | Ação |
|---|---|
| `ALT+setas para cima/baixo` | Move a linha (padrão do editor) |
| `ALT+SHIFT+setas para cima/baixo` | Copia a linha para cima/baixo |
| `CTRL+ALT+setas para cima/baixo` | Adiciona cursor acima/abaixo |
| `CTRL+Q` | Seletor de painéis da barra lateral; com `CTRL` pressionado, `Q` avança (não fecha o programa) |
| `CTRL+'` | Mostra ou oculta o terminal integrado |
| `CTRL+SHIFT+'` | Novo terminal integrado |
| `CTRL+K CTRL+Z` | Modo zen |
| `CTRL+ALT+P` | Executa o arquivo Python no terminal |
| `SHIFT+ENTER` no terminal integrado | Envia nova linha (usado pelo Claude Code) |

## Neovim

| Atalho | Ação |
|---|---|
| `ALT+setas para cima/baixo` | Move a linha ou a seleção (modos normal, inserção e visual) |
| `ALT+SHIFT+setas para cima/baixo` | Copia a linha ou a seleção |

## Outros programas

| Programa | Atalho ou ação | Efeito |
|---|---|---|
| Firefox | `CTRL+Q` | Desativado (não fecha o navegador) |
| Thunar | Menu de contexto | Open Terminal Here, Open in Neovim, Copy Path, Open as Root, Edit as Root |
| kitty | `CTRL+SHIFT+V` | Cola |
