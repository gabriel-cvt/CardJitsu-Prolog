:- user_module('./src/Util/lib.pl').
:- user_module('./src/Util/controleJogo.pl').
:- user_module('./src/Controller/controleCarregamento.pl').

carregar_fase_jogador(branca) :-
    clearScreen,
    % função de texto fase branca
    pressionar_tecla,
    controleJogo:controller_jogo("O Ruivo").

carregar_fase_jogador(azul) :-
    clearScreen,
    % função de texto fase azul
    pressionar_tecla,
    controleJogo:controller_jogo("Bruxa da Neve").

carregar_fase_jogador(roxa) :-
    clearScreen,
    % função de texto fase roxa
    pressionar_tecla,
    controleJogo:controller_jogo("Caveleiro Do Mar").

carregar_fase_jogador(marrom) :-
    clearScreen,
    % função de texto fase marrom
    pressionar_tecla,
    controleJogo:controller_jogo("Punhos de Fogo").

carregar_fase_jogador(preta) :-
    clearScreen,
    % função de texto fase preta
    pressionar_tecla,
    controleJogo:controller_jogo("Olhos de Falcão").

carregar_fase_jogador(mestre) :-
    clearScreen,
    % função texto zerou o jogo
    pressionar_tecla,
    % função da interface de escolha pós-zerar jogo, retornar a variável que ele escolheu
    escolha_final(Escolha).


escolha_final(1) :-
    clearScreen,
    write("\nEntão você vai abandonar tudo que conseguiu e ir atrás da conquista novamente..."),
    pressionar_tecla,
    controleCarregamento:novo_jogo.

escolha_final(2) :-
    write("\nBem, o caminho que você fez não foi fácil.\nApós tantas batalhas, chegou o momento de descansar"),
    pressionar_tecla,
    halt(0).

escolha_final(_) :-
    write("\nPelo visto a jornada foi tão desafiadora que confundiu suas teclas...\nEscolha novamente!"),
    pressionar_tecla
    carregar_fase_jogador(mestre).