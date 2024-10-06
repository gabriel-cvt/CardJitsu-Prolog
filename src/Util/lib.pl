:- module(lib, [pressionar_tecla/0, get_user_input/1, clearScreen/0, input_to_number/1, barra_carregamento/0]).

:- use_module(library(readutil)).
:- use_module(library(time)).


pressionar_tecla :-
    write('Pressione a tecla ENTER para continuar...'), nl,
    read_line_to_codes(user_input, _),
    true.

get_user_input(Input) :-
    ansi_format([fg(yellow)], '~w', ["\nDigite sua escolha: "]),
    read_line_to_string(user_input, Input).

clearScreen :- tty_clear.

input_to_number(N) :-
    get_user_input(InputAux),
    normalize_space(atom(Input), InputAux),
    (atom_number(Input, N) -> true; N = -1).

% Tá dando algum problema nesse predicado, ele está levando ao menu principal
% Regra principal para iniciar a barra de carregamento
barra_carregamento :-
    nl,
    carregar(0).

% Regra para atualizar a barra de carregamento
carregar(Percent) :-
    Percent =< 100,
    write('\r['),
    imprimir_barra(Percent), 
    format('] ~d%', [Percent]),
    flush_output,
    sleep(0.03),
    NovoPercent is Percent + 1,
    carregar(NovoPercent).

% Regra para imprimir a barra de acordo com a porcentagem
imprimir_barra(Percent) :-
    NumHash is Percent // 2,
    NumHifens is 50 - NumHash,
    imprimir_simbolo(NumHash, '#'),
    imprimir_simbolo(NumHifens, '-').

% Regra auxiliar para imprimir símbolos repetidamente
imprimir_simbolo(0, _) :- !.
imprimir_simbolo(N, Simbolo) :-
    N > 0,
    write(Simbolo),
    N1 is N - 1,
    imprimir_simbolo(N1, Simbolo).

verificar_faixa:-
    salvamentos:carregar_jogador(Jogador),
    jogador:get_faixa(Jogador, FaixaAtual),

    faixa_anteriores(FaixaAtual, FaixasAnteriores),
    faixa_restantes(FaixaAtual, FaixasRestantes),

    exibir_faixa(FaixaAtual, FaixasAnteriores, FaixasRestantes).

exibir_faixa(branca, _, FaixasRestantes) :-
    write("Você ainda não alcançou outras faixas. Vamos começar a sua jornada ninja!\n"),
    write("Faixas anteriores:\n ➤ Nenhuma\n"),
    write("Faixas restantes:\n"),
    maplist(exibir_faixa_restante, FaixasRestantes).

exibir_faixa(preta, FaixasAnteriores, _) :-
    write("Parabéns! Você conquistou a faixa preta!\n"),
    write("Faixas anteriores:\n"),
    maplist(exibir_faixa_anterior, FaixasAnteriores),
    write("Objetivo restante:\n ➤ Desafiar o sensei e virar um Mestre ninja\n").

exibir_faixa(mestre, FaixasAnteriores, _) :-
    write("Parabéns! Você é um grande mestre Ninja!\n"),
    write("Faixas anteriores:\n"),
    maplist(exibir_faixa_anterior, FaixasAnteriores).

exibir_faixa(FaixaAtual, FaixasAnteriores, FaixasRestantes) :-
    format("Você está na faixa: ~s~n", [FaixaAtual]),
    write("Faixas anteriores:\n"),
    maplist(exibir_faixa_anterior, FaixasAnteriores),
    write("Faixas restantes:\n"),
    maplist(exibir_faixa_restante, FaixasRestantes).

exibir_faixa_anterior(Faixa) :-
    format(" ➤ ~s~n", [Faixa]).

exibir_faixa_restante(Faixa) :-
    format(" ➤ ~s~n", [Faixa]).

faixa_anteriores(FaixaAtual, FaixasAnteriores) :-
    faixas(Faixas),
    append(FaixasAnteriores, [FaixaAtual|_], Faixas).

faixa_restantes(FaixaAtual, FaixasRestantes) :-
    faixas(Faixas),
    append(_, [FaixaAtual|FaixasRestantes], Faixas).