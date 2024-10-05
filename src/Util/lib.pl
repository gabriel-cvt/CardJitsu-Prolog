:- use_module(library(readutil)).
:- use_module(library(time)).


pressionar_tecla :-
    write('Pressione a tecla ENTER para continuar...'), nl,
    read_line_to_codes(user_input, _),
    true.

get_user_input(Input) :-
    write("\nDigite sua escolha: "),
    read_line_to_string(user_input, Input).

clearScreen :- tty_clear.

pressionar_tecla :- 
    input("\nAperte qualquer tecla para continuar... ", _),
    clearScreen.

input_number(Text, N) :- 
    input(Text, OutputAux),
    normalize_space(atom(Output) , OutputAux),
    (atom_number(Output, N) ->  true; N = -1).


% Regra principal para iniciar a barra de carregamento
barra_carregamento :-
    carregar(0).

% Regra para atualizar a barra de carregamento
carregar(Percent) :-
    Percent =< 100,
    write('\r['),  % \r para retornar ao início da linha
    imprimir_barra(Percent), 
    format('] ~d%', [Percent]),
    flush_output,   % Garante que a barra seja impressa imediatamente
    sleep(0.03),    % Atraso de 30ms para o efeito visual
    NovoPercent is Percent + 1,  % Incrementa o percentual de 1 em 1
    carregar(NovoPercent).

% Regra para imprimir a barra de acordo com a porcentagem
imprimir_barra(Percent) :-
    NumHash is Percent // 2,    % Cada # representa 2% agora
    NumHifens is 50 - NumHash,  % Restante da barra com -
    imprimir_simbolo(NumHash, '#'),
    imprimir_simbolo(NumHifens, '-').

% Regra auxiliar para imprimir símbolos repetidamente
imprimir_simbolo(0, _) :- !.
imprimir_simbolo(N, Simbolo) :-
    N > 0,
    write(Simbolo),
    N1 is N - 1,
    imprimir_simbolo(N1, Simbolo).
