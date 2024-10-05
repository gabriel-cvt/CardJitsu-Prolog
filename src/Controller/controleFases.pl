:- module(controle_fase, [fase_jogador/1, escolha_final/1]).

:- use_module('./src/Util/lib.pl').
:- use_module('./src/Util/controleJogo.pl').
:- use_module('./src/Controller/controleCarregamento.pl').

fase_jogador(branca) :-
    lib:clearScreen,
    % função de texto fase branca
    lib:pressionar_tecla,
    controleJogo:controller_jogo("O Ruivo").

fase_jogador(azul) :-
    lib:clearScreen,
    % função de texto fase azul
    lib:pressionar_tecla,
    controleJogo:controller_jogo("Bruxa da Neve").

fase_jogador(roxa) :-
    lib:clearScreen,
    % função de texto fase roxa
    lib:pressionar_tecla,
    controleJogo:controller_jogo("Caveleiro Do Mar").

fase_jogador(marrom) :-
    lib:clearScreen,
    % função de texto fase marrom
    lib:pressionar_tecla,
    controleJogo:controller_jogo("Punhos de Fogo").

fase_jogador(preta) :-
    lib:clearScreen,
    % função de texto fase preta
    lib:pressionar_tecla,
    controleJogo:controller_jogo("Olhos de Falcão").

fase_jogador(mestre) :-
    lib:clearScreen,
    % função texto zerou o jogo
    lib:pressionar_tecla,
    % função da interface de escolha pós-zerar jogo, retornar a variável que ele escolheu
    escolha_final(Escolha).


escolha_final(1) :-
    lib:clearScreen,
    write("\nEntão você vai abandonar tudo que conseguiu e ir atrás da conquista novamente..."),
    lib:pressionar_tecla,
    controle_carregamento:novo_jogo.

escolha_final(2) :-
    write("\nBem, o caminho que você fez não foi fácil.\nApós tantas batalhas, chegou o momento de descansar"),
    lib:pressionar_tecla,
    halt(0).

escolha_final(_) :-
    write("\nPelo visto a jornada foi tão desafiadora que confundiu suas teclas...\nEscolha novamente!"),
    lib:pressionar_tecla
    controle_carregamento:fase_jogador(mestre).