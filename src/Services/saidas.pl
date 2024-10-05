:- module(saidas, [printMenu/0, printNovoJogo/0, ler_instrucoes/0]).

:- use_module('./src/Services/salvamentos.pl').
:- use_module('./src/Util/lib.pl').


printMenu :-
    write("======= Bem vindo ao Dojo! =======\n"),
    write("Qual vai ser a sua escolha para hoje?\n"),
    write("1 - Começar novo jogo\n"),
    write("2 - Carregar jogo\n"),
    write("3 - Checar faixas\n"),
    write("4 - Instruções\n"),
    write("5 - Sair do jogo\n").

printNovoJogo :-
    write("Começando uma nova aventura ninja...\n"),
    write("Qual é o seu nome?\n").

ler_instrucoes :-
    salvamentos:carregar_instrucoes(Instrucoes),
    imprimir_instrucoes(Instrucoes).


imprimir_instrucoes([]).
imprimir_instrucoes([Linha|Linhas]) :-
    write(Linha), nl,  % Imprime a linha e nova linha
    imprimir_instrucoes(Linhas).