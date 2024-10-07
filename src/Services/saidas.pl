:- module(saidas, [printMenu/0, printNovoJogo/0, ler_instrucoes/0, centraliza/1]).

:- use_module('./src/Services/salvamentos.pl').
:- use_module('./src/Util/lib.pl').
:- use_module(library(ansi_term)).


printMenu :-
    centraliza_format([bold, fg(yellow)], "          ___                   _         __                      __       _        __ \n"),
    centraliza_format([bold, fg(yellow)], "         / _ )___ __ _    _  __(_)__  ___/ /__    ___ ____    ___/ /__    (_)__    / / \n"),
    centraliza_format([bold, fg(yellow)], "        / _  / -_)  ' \\  | |/ / / _  / _  / _ \\  / _ `/ _ \\  / _  / _ \\  / / _ \\  /_/  \n"),
    centraliza_format([bold, fg(yellow)], "       /____/\\__/_/_/_/  |___/_/_//_/\\_,_/\\___/  \\_,_/\\___/  \\_,_/\\___/_/ /\\___/ (_)   \n"),
    centraliza_format([bold, fg(yellow)], "                                                                         |___/                 \n"),
    centraliza_format([bold, fg(blue)], "Qual vai ser a sua escolha para hoje?\n"),
    write("\n"),
    centraliza_format([fg(blue)], "(1) Começar novo jogo    (2) Carregar jogo    (3) Checar faixas    (4) Instruções    (5) Sair do jogo\n").

printNovoJogo :-
    centraliza("Começando uma nova aventura ninja...\n"),
    centraliza("Qual é o seu nome?").

ler_instrucoes :-
    salvamentos:carregar_instrucoes(Instrucoes),
    imprimir_instrucoes(Instrucoes).


imprimir_instrucoes([]) :- nl.
imprimir_instrucoes([Linha|Linhas]) :-
    centraliza(Linha),
    imprimir_instrucoes(Linhas).


tamanho_terminal(Colunas) :-
    process_create(path(stty), ['size'], [stdout(pipe(Out))]),
    read_line_to_string(Out, Result),
    split_string(Result, " ", "", [_LinhasStr, ColunasStr]),
    number_string(Colunas, ColunasStr).

% Centraliza uma linha de texto
centraliza(Text) :-
    tamanho_terminal(Colunas),
    string_length(Text, TextLength),
    Espacos is (Colunas - TextLength) // 2,
    tab(Espacos),
    writeln(Text).

centraliza_format(Estilo, Texto) :-
    tamanho_terminal(Colunas),
    string_length(Texto, TextLength),
    Espacos is (Colunas - TextLength) // 2,
    tab(Espacos),
    ansi_format(Estilo, Texto, []).