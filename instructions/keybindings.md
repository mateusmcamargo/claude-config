# Atalhos em uso

Lista dos atalhos configurados nas máquinas de Mateus. Atualizar este arquivo sempre que um atalho for criado, alterado ou removido.

## Hyprland (sistema)

`SUPER` é a tecla Windows.

| Atalho | Ação |
|---|---|
| `SUPER+Q` | Abre o terminal (kitty) |
| `SUPER+E` | Abre o gerenciador de arquivos (Thunar) |
| `SUPER+F` | Abre o Firefox |
| `SUPER+SHIFT+F` | Abre uma nova janela anônima do Firefox |
| `SUPER` (tocar e soltar, sem outra tecla) | Abre/fecha o waydeck: painel que desliza de baixo da waybar com seções de apps, busca, arquivos recentes e informações do sistema |
| `SUPER+R` | Abre o menu de aplicativos (rofi, com pastas; Tab/Shift+Tab troca de pasta) |
| `SUPER+/` (também `/` do teclado numérico ou `SUPER+AltGr+Q`) | Abre a folha de atalhos (rofi, com filtro); repetir fecha |
| `SUPER+C` | Igual ao `ALT+F4`: fecha a janela em foco; sem janela no workspace visível, abre o menu de energia |
| `ALT+F4` | Fecha a janela em foco; sem janela no workspace visível, abre o menu de energia |
| `SUPER+M` | Encerra a sessão |
| `SUPER+L` | Bloqueia a tela (hyprlock) |
| `SUPER+V` | Alterna a janela entre solta e encaixada (plugin winsnap) |
| `SUPER+SHIFT+V` | Histórico da área de transferência; o item escolhido é colado na janela ativa |
| `SUPER+SHIFT+ALT+V` | Apaga um item do histórico da área de transferência |
| `SUPER+SHIFT+W` | Reinicia o papel de parede salvo (imagem ou cena ASCII, `vitral --restore desktop`) |
| `SUPER+W` | Abre/fecha o vitral: faixa inferior para escolher o wallpaper do desktop, lock, greeter e GRUB |
| `SUPER+T` | Abre/fecha o palette: faixa inferior com previews dos temas (archangel, nord); Enter aplica via `theme.py apply --reload` |
| `SUPER+P` | Pseudo-tiling |
| `SUPER+J` | Alterna a divisão (layout dwindle) |
| `SUPER+setas` | Movem e encaixam a janela em foco, como no Windows (tabela abaixo); não trocam o foco |
| `SUPER+1..0` | Vai para o workspace 1 a 10 |
| `SUPER+SHIFT+1..0` | Move a janela para o workspace 1 a 10 |
| `SUPER+S` | Abre o Spotify |
| `SUPER+N` | Nova nota autoadesiva (Feather), perto do cursor |
| `SUPER+SHIFT+N` | Mostra ou esconde todas as notas autoadesivas |
| `SUPER+SHIFT+S` | Screenshot de uma área (seleção com o mouse) |
| `Print` / `SUPER+Print` | Screenshot do monitor em foco |
| `ALT+Print` | Screenshot da janela ativa |
| `SUPER+SHIFT+R` | Grava a tela (arrastar = área, clicar = monitor inteiro); de novo para |
| `SUPER+SHIFT+C` | Seletor de cor: clique copia a cor sob o cursor em hex; Esc ou repetir cancela |
| `ALT+TAB` / `ALT+SHIFT+TAB` | Como no Windows, só janelas do workspace atual (e as minimizadas dele): toque rápido volta para a janela anterior; segurando ALT aparece a lista, TAB/setas andam, SHIFT+TAB volta, soltar o ALT escolhe, Esc cancela |
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
| Botão ☰ (direita da barra) | Menu da janela: sempre no topo, fixar em todos os workspaces, mover para workspace, encaixar, transparência, screenshot/gravar a janela, informações (clique copia), forçar fechamento |

## Waybar

Padrão dos ícones com menu: clique esquerdo abre o menu (rofi abaixo da barra), clique do meio liga/desliga ou alterna a função principal. Menus com um gerenciador terminam em "Open manager".

| Ação | Efeito |
|---|---|
| Rolagem sobre o ícone de brilho ou volume | Ajusta o valor e mostra o aviso na tela |
| Clique no ícone de volume | Menu de som: silenciar, escolher saída (alto-falante, fone, HDMI, Bluetooth) e microfone, "Fix audio" quando o som trava, rodapé abre o pavucontrol; de novo fecha |
| Clique do meio no ícone de volume | Silencia |
| Clique direito no ícone de volume | Abre os sliders de volume (pavucontrol, de novo fecha) |
| Clique no ícone de rede | Menu do Wi-Fi: redes com sinal, conectar (pede senha se preciso), desconectar, ligar/desligar, switch de VPN (Proton, servidor mais rápido), rodapé abre o nmtui |
| Clique do meio no ícone de rede | Liga ou desliga o Wi-Fi |
| Clique no ícone do sistema (coração) | Menu do sistema: CPU, RAM, disco, GPU NVIDIA, ventoinhas, apps mais pesados (escolher um oferece fechar ou forçar), rodapé abre o btop; de novo fecha |
| Clique direito no ícone do sistema | Abre o btop (de novo fecha) |
| Clique no ícone de Bluetooth | Menu do Bluetooth: dispositivos pareados, conectar/desconectar, rodapé abre o blueman (de novo fecha) |
| Clique do meio ou direito no ícone de Bluetooth | Liga ou desliga o Bluetooth |
| Clique no wayplayer (play/pause, nome da faixa ou cava) | Pausa ou retoma; clique direito ou rolagem para cima avança; rolagem para baixo volta |
| Clique no ícone do WhatsApp (verde = mensagens não lidas) | Abre o ZapZap; de novo esconde a janela (continua recebendo mensagens em segundo plano) |
| Clique no ícone da pena (Feather) | Menu das notas: nova nota, switch "Show notes", "All notes" e uma linha por nota (escolher mostra a nota); de novo fecha |
| Clique do meio no ícone da pena | Mostra ou esconde todas as notas (o ícone fica cinza enquanto escondidas) |
| Clique no ícone de brilho | Menu de tela: luz noturna, temperatura e agenda (sliders), brilho (slider) (de novo fecha) |
| Clique do meio no ícone de brilho | Liga ou desliga a luz noturna na hora (a agenda 19:00–07:00 retoma no próximo horário) |
| Clique na câmera (esquerda) | Começa ou para a gravação de tela; clique direito alterna o áudio: nenhum → microfone → sistema |
| Clique no ícone da bateria | Menu da bateria: nível e tempo restante, escolher o perfil de energia, consumo, saúde e limite de carga (de novo fecha) |
| Clique do meio no ícone da bateria | Alterna o perfil de energia: power-saver → balanced → performance |
| Clique no sino | Menu de notificações: não perturbe, cartões com cor, ícone, título e corpo (o ✕ de cada um apaga só ela; tecla Delete também), "Clear all" no rodapé (de novo fecha) |
| Clique do meio no sino | Liga ou desliga o modo não perturbe |
| Clique no relógio | Waytile do relógio: relógio grande em ASCII, calendário do mês com o dia de hoje e a data por extenso (de novo fecha) |

## Waydeck (painel de apps, toque no SUPER)

| Ação | Efeito |
|---|---|
| Digitar | Busca em todos os apps instalados e nos arquivos recentes |
| `Cima` / `Baixo` / `Tab` | Andam pelos resultados da busca; sem busca, `Baixo` entra nos ícones |
| `Enter` / clique | Abre o resultado ou o app |
| Clique direito num arquivo recente | Abre a pasta do arquivo |
| `Esc` | Limpa a busca, depois sai do modo de edição, depois fecha |
| Lápis | Modo de edição: ícone e cor da seção, título, ordem, apagar (dois cliques), "Add app", "New section" |
| Pasta | Abre `~/.config/waydeck/sections` (um arquivo `.toml` por seção) |
| Clicar numa janela, `SUPER+R` ou um waytile | Fecha o waydeck |

## VSCodium

Esquema igual ao do VS Code no Windows.

| Atalho | Ação |
|---|---|
| `ALT+setas para cima/baixo` | Move a linha (padrão do editor) |
| `ALT+SHIFT+setas para cima/baixo` | Copia a linha para cima/baixo |
| `CTRL+ALT+setas para cima/baixo` | Adiciona cursor acima/abaixo |
| `CTRL+Q` | Seletor de painéis da barra lateral; com `CTRL` pressionado, `Q` avança (não fecha o programa) |
| `CTRL+B` | Mostra ou oculta a barra lateral; ao ocultar, o foco volta para o editor |
| `CTRL+'` | Mostra ou oculta o terminal integrado |
| `CTRL+SHIFT+'` | Novo terminal integrado |
| `CTRL+K CTRL+Z` | Modo zen |
| `CTRL+ALT+P` | Executa o arquivo Python no terminal |
| `SHIFT+ENTER` no terminal integrado | Envia nova linha (usado pelo Claude Code) |

## Neovim

Líder = `Espaço` (o which-key mostra as opções ao digitar o líder). Esquema híbrido: movimentos do vim mais os atalhos do VSCodium mais usados.

| Atalho | Ação |
|---|---|
| `ALT+setas para cima/baixo` | Move a linha ou a seleção (modos normal, inserção e visual) |
| `ALT+SHIFT+setas para cima/baixo` | Copia a linha ou a seleção |
| `CTRL+S` | Salva (todos os modos) |
| `CTRL+/` | Comenta/descomenta a linha ou a seleção |
| `CTRL+P` / `Espaço Espaço` | Procura arquivo (picker inteligente) |
| `CTRL+SHIFT+P` | Paleta de comandos |
| `CTRL+SHIFT+F` / `Espaço f g` | Busca no projeto |
| `CTRL+B` / `Espaço e` | Árvore de arquivos lateral |
| `-` / `Espaço o` | Diretório pai no oil (edita o diretório como texto) / oil flutuante |
| `CTRL+'` | Terminal flutuante (também sai dele) |
| `CTRL+,` / `Espaço a c` | Abre/fecha o Claude Code |
| `Shift+H` / `Shift+L` | Buffer anterior / próximo (abas) |
| `CTRL+H/J/K/L` | Move o foco entre janelas |
| `Espaço b d` / `Espaço b o` | Fecha o buffer / os outros buffers |
| `Espaço \|` / `Espaço -` | Divide a janela à direita / abaixo |
| `Esc` (duas vezes) no terminal | Sai do modo terminal |
| `Espaço q q` | Sai de tudo |

### Código (LSP)

| Atalho | Ação |
|---|---|
| `gd` / `gD` / `gi` / `gy` / `gr` | Definição / declaração / implementações / tipo / referências |
| `K` | Documentação sob o cursor |
| `CTRL+K` (inserção) | Ajuda de assinatura |
| `F2` / `Espaço c r` | Renomeia o símbolo |
| `CTRL+.` / `Espaço c a` | Ação de código |
| `Espaço c f` | Formata (também ao salvar; `Espaço u f` liga/desliga) |
| `Espaço c s` / `Espaço c S` | Símbolos do arquivo / do projeto |
| `Espaço c d` | Diagnóstico da linha |
| `Espaço x x` / `Espaço x X` | Diagnósticos do arquivo / do projeto |
| `Enter` no completar | Aceita; `CTRL+Espaço` abre; `Tab` pula campos de snippet |
| `]h` / `[h` | Próximo / anterior trecho alterado (git) |
| `gsa` / `gsd` / `gsr` | Adiciona / remove / troca delimitadores (surround) |

### Busca, git, debug

| Atalho | Ação |
|---|---|
| `Espaço f f/b/r/p/h/k/d/u` | Arquivos / buffers / recentes / projetos / ajuda / atalhos / diagnósticos / histórico de undo |
| `Espaço f w` | Palavra sob o cursor no projeto |
| `Espaço /` | Busca no buffer |
| `Espaço g g` | Lazygit |
| `Espaço g d` / `Espaço g H` / `Espaço g q` | Diff do repositório / histórico do arquivo / fecha o diffview |
| `Espaço g h s/r/p/b` | Stage / reset / preview / blame do trecho |
| `F5` / `Shift+F5` | Inicia ou continua / para a depuração |
| `F9` / `F10` / `F11` / `Shift+F11` | Breakpoint / passo sobre / dentro / fora |
| `Espaço d u` / `Espaço d e` | Painel de debug / avalia a expressão |

### Claude Code (claudecode.nvim)

| Atalho | Ação |
|---|---|
| `Espaço a f` | Foca o Claude |
| `Espaço a r` / `Espaço a C` | Retoma uma sessão / continua a última |
| `Espaço a b` | Adiciona o arquivo atual ao contexto |
| `Espaço a s` (visual) | Envia a seleção; na árvore/oil, adiciona o arquivo |
| `Espaço a a` / `Espaço a d` | Aceita / recusa o diff proposto |

### Java e Arduino

| Atalho | Ação |
|---|---|
| `Espaço j o/v/c/m` | Organiza imports / extrai variável / constante / método |
| `Espaço j t` / `Espaço j n` | Roda os testes da classe / o teste mais próximo |
| `Espaço j r` | Reinicia o jdtls |
| `Espaço r c` / `Espaço r u` | Arduino: compila / compila e envia |
| `Espaço r m` | Arduino: monitor serial |
| `Espaço r b` / `Espaço r p` / `Espaço r l` | Arduino: escolhe placa / porta / instala biblioteca |

### UI

| Atalho | Ação |
|---|---|
| `Espaço u h` / `Espaço u n` / `Espaço u c` | Inlay hints / histórico de notificações / esquemas de cor |

## Pixelangel (editor de sprites, ~/code/pixelangel)

| Atalho | Ação |
|---|---|
| `M` / `V` | Seleção retangular / mover |
| `B` / `E` / `G` | Lápis / borracha / balde |
| `L` / `U` / `I` | Linha / retângulo / conta-gotas |
| `SHIFT` arrastando | Linha trava em 0°/45°/90°; retângulo e seleção viram quadrados |
| Arrastar dentro da seleção (ferramenta de seleção) | Move os pixels selecionados |
| `CTRL+A` / `CTRL+D` / `Delete` | Seleciona tudo / tira a seleção / apaga os pixels selecionados |
| `SHIFT+N` / `CTRL+J` / `CTRL+E` | Nova camada / duplica a camada / mescla com a de baixo |
| `CTRL+SHIFT+cima` / `CTRL+SHIFT+baixo` | Sobe / desce a camada ativa |
| `ALT+cima` / `ALT+baixo` | Ativa a camada de cima / de baixo |
| `F2`, clique duplo na camada | Propriedades da camada (nome, opacidade) |
| `Esquerda` / `Direita`, `Home` / `End` | Frame anterior / próximo, primeiro / último |
| `Enter` | Toca / para a animação (em loop na tag do frame atual, se houver) |
| `ALT+N` / `ALT+SHIFT+N` / `ALT+C` | Novo frame (cópia) / novo frame vazio / apaga o frame |
| `CTRL+SHIFT+esquerda` / `CTRL+SHIFT+direita` | Move o frame ativo para a esquerda / direita |
| `F3` | Onion skin (frame anterior em rosa, próximo em ciano) |
| Clique duplo no número do frame | Propriedades do frame (duração) |
| `SHIFT`+clique nos números dos frames | Seleciona um intervalo de frames (usado pela nova tag) |
| `ALT+T` | Nova tag sobre os frames selecionados |
| Clique / clique duplo numa tag | Seleciona seus frames / propriedades da tag |
| Clique esquerdo / direito | Pinta com a cor de frente / de fundo |
| `ALT+clique` | Pega a cor com qualquer ferramenta |
| `X` | Troca as cores de frente e de fundo |
| `[` / `]` | Diminui / aumenta o pincel |
| Rolagem, `+` / `-` | Zoom no ponteiro |
| `1` / `0` | Tamanho real / ajustar à tela |
| Botão do meio arrastando, `Espaço`+arrastar | Move a vista |
| `CTRL+'` | Liga/desliga a grade de pixels |
| `CTRL+Z` / `CTRL+SHIFT+Z`, `CTRL+Y` | Desfaz / refaz |
| `CTRL+N` / `CTRL+O` / `CTRL+S` / `CTRL+SHIFT+S` | Novo / abrir / salvar (.pxa) / salvar como |
| `CTRL+SHIFT+E` | Exporta o frame atual como PNG |
| `CTRL+SHIFT+G` | Exporta um GIF animado (todos os frames ou uma tag, com escala) |
| `CTRL+Q` | Fecha (pergunta se há alterações não salvas) |
| `Esc` | Cancela o arrasto em andamento (traço, seleção, mover) |

## Vitral (navegador de wallpapers, ~/code/vitral)

| Atalho | Ação |
|---|---|
| `Tab` / `SHIFT+Tab`, `1`..`4` | Troca a aba: Desktop, Lock, Greeter, GRUB |
| `esquerda` / `direita` ou `h` / `l`, `Home` / `End` | Navegam pela faixa (no Desktop, já aplica como preview) |
| `Enter` / clique duplo | Confirma: grava a escolha no alvo da aba |
| `Esc` / clique fora da faixa | Fecha e volta ao wallpaper salvo do desktop |
| `/` | Filtra por nome |
| `p` (aba Lock) | Fecha e roda o hyprlock para testar |
| Clique / rolagem | Seleciona / rola a faixa |

## Outros programas

| Programa | Atalho ou ação | Efeito |
|---|---|---|
| Firefox | `CTRL+Q` | Desativado (não fecha o navegador) |
| Thunar | Menu de contexto | Open Terminal Here, Open in Neovim, Copy Path, Open as Root, Edit as Root |
| kitty | `CTRL+SHIFT+V` | Cola |

## Feather (notas autoadesivas)

Atalhos dentro de uma nota (o `SUPER+N` e o `SUPER+SHIFT+N` estão na seção Hyprland).

| Atalho | Ação |
|---|---|
| `CTRL+N` | Nova nota |
| Clique do meio no cabeçalho | Fecha a nota (continua salva) |
| `CTRL+W` | Fecha a nota (continua salva; reabre pela "All notes" ou pelo menu da waybar) |
| `CTRL+D` | Apaga a nota (vai para a lixeira, com desfazer) |
| `CTRL+B` / `CTRL+I` / `CTRL+SHIFT+X` | Negrito / itálico / riscado na seleção |
| `CTRL+L` | Alterna a caixa de seleção da linha (`- [ ]` / `- [x]`) |
| `CTRL+SHIFT+L` | Alterna o marcador de lista `- ` da linha |
| `CTRL+Z` / `CTRL+SHIFT+Z` | Desfaz / refaz |
| `CTRL+F` | Abre a "All notes" com o foco na busca |
| `Esc` | Tira o foco do texto (na "All notes": limpa a busca, depois fecha) |
| `Enter` numa lista | Continua a lista; numa linha de lista vazia remove o marcador |
| Clique em `[ ]` / `[x]` | Alterna a caixa sem mover o cursor |
| `CTRL`+clique num link | Abre o link |
| Clique duplo no cabeçalho | Recolhe ou expande a nota |
| Arrastar o cabeçalho / o canto inferior direito | Move / redimensiona (`SUPER`+botões do mouse também funcionam) |
| `@ 18:00` ou `@ 2026-11-12 09:00` numa linha | Lembrete: notificação laranja no horário; clicar abre a nota |