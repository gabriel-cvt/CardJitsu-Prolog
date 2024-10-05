:- [Types_faixa].

jogador :- Player(Nome, Faixa, Partidas).

get_nome(player(Nome, _, _), Nome).

get_faixa(player(_, Faixa, _), Faixa).

get_progresso(player(_, _, Progresso), Progresso).

up_partidas_jogadas(player(Nome, Faixa, Progresso), player(Nome, Faixa, NovoProgreso)) :-
    NovoProgreso is Progresso + 1.

novo_jogador(Nome, player(Nome, branca, 0)).