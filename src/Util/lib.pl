:- module(lib)
:- use_module(library(readutil)).



pressionar_tecla :-
    write('Pressione a tecla ENTER para continuar...'), nl,
    read_line_to_codes(user_input, _),
    true.


clearScreen :- tty_clear