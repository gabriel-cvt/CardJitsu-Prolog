:- module(saidas, [printMenu/0, printNovoJogo/0, ler_instrucoes/0]).

:- use_module('./src/Services/salvamentos.pl').
:- use_module('./src/Util/lib.pl').
:- use_module(library(ansi_term)).


printMenu :-
    ansi_format([bold,fg(blue)], '~w', ["
         ___                   _         __                      __       _        __ \n"]),
    ansi_format([bold,fg(blue)], '~w', ["        / _ )___ __ _    _  __(_)__  ___/ /__    ___ ____    ___/ /__    (_)__    / / \n"]),
    ansi_format([bold,fg(blue)], '~w', ["       / _  / -_)  ' \\  | |/ / / _  / _  / _ \\  / _ `/ _ \\  / _  / _ \\  / / _ \\  /_/  \n"]),
    ansi_format([bold,fg(blue)], '~w', ["      /____/\\__/_/_/_/  |___/_/_//_/\\_,_/\\___/  \\_,_/\\___/  \\_,_/\\___/_/ /\\___/ (_)   \n"]),
    ansi_format([bold,fg(blue)], '~w', ["                                                                    |___/                 \n"]),
    ansi_format([bold,fg(yellow)], '~w', [\n"      Qual vai ser a sua escolha para hoje?\n"]),
    ansi_format([fg(yellow)], '~w', ["\n1 ‣ Começar novo jogo"]),
    ansi_format([fg(yellow)], '~w', ["    2 ‣ Carregar jogo"]),
    ansi_format([fg(yellow)], '~w', ["    3 ‣ Checar faixas"]),
    ansi_format([fg(yellow)], '~w', ["    4 ‣ Instruções"]),
    ansi_format([fg(yellow)], '~w', ["    5 ‣ Sair do jogo\n"]).

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