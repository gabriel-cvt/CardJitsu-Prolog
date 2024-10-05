% Importar os módulos
:- user_module('./src/Controller/controleMenu.pl').
:- use_module('./src/Util/lib.pl').

% O predicado principal
main :- start.

% O predicado start que executa as ações
start :-
    clearScreen,
    pressionar_tecla,
    controlejogo:menu,
    halt.