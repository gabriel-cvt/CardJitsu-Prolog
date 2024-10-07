:- module(lib, [pressionar_tecla/0, get_user_input/1, clearScreen/0, input_to_number/1, loading/0]).

:- use_module(library(readutil)).
:- use_module(library(time)).
:- use_module(library(sleep)).

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

% Função para exibir a barra de carregamento
loading_bar(Progress) :-
    % Define o tamanho da barra
    BarSize = 50,
    % Calcula o número de hashes e traços
    Hashes is (Progress * BarSize) // 100,
    Dashes is BarSize - Hashes,
    
    % Gera a parte da barra com hashes
    length(HashList, Hashes),
    maplist(=('#'), HashList),
    atomic_list_concat(HashList, '', HashPart),
    
    % Gera a parte da barra com traços
    length(DashList, Dashes),
    maplist(=('-'), DashList),
    atomic_list_concat(DashList, '', DashPart),
    
    % Concatena a barra
    atomic_list_concat(['[', HashPart, DashPart, ']'], Bar),
    
    % Limpa a linha anterior e exibe a nova barra com o progresso percentual
    format('\r~s ~d%', [Bar, Progress]),
    
    % Garante que a saída seja atualizada imediatamente
    flush_output,
    
    % Pausa para simular o progresso
    sleep(0.025).  % Ajuste o tempo conforme necessário

% Loop de carregamento de 0 a 100
loading :-
    nl,  % Adiciona uma nova linha após o carregamento completo
    forall(between(0, 100, Progress), loading_bar(Progress)), nl.

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