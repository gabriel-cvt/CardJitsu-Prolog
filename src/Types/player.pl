:- module(player, [player/4, get_nome/2, get_faixa/2, up_faixa/2, up_partidas_jogadas/2, new_player/2]).

player(Nome, Faixa, Partidas).

faixa(branca).
faixa(azul).
faixa(roxa).
faixa(marrom).
faixa(preta).
faixa(mestre).

get_nome(player(Nome, _, _), Nome).

get_faixa(player(_, Faixa, _), Faixa).

get_progresso(player(_, _, Progresso), Progresso).

up_faixa(player(Nome, Cartas, Faixa, Partidas), player(Nome, Cartas, NovaFaixa, Partidas)) :-
    faixa_sucessor(Faixa, NovaFaixa).

faixa_sucessor(branca, azul).
faixa_sucessor(azul, roxa).
faixa_sucessor(roxa, marrom).
faixa_sucessor(marrom, preta).
faixa_sucessor(preta, mestre).

up_partidas_jogadas(player(Nome, Cartas, Faixa, Partidas), player(Nome, Cartas, Faixa, NovasPartidas)) :-
    NovasPartidas is Partidas + 1.

new_player(Nome, player(Nome, branca, 0))