:- consult('carta.pl').

baralho([Carta]) :- carta(Carta).

gerar_cartas_elemento(Elemento, Cartas) :-
    gerar_cartas_elemento(Elemento, 1, Cartas).

gerar_cartas_elemento(_, Valor, []) :- Valor < 1, Valor > 12.
gerar_cartas_elemento(Elemento, Valor, [Carta | Cartas]) :-
    Valor >= 1, Valor =< 12,
    (   Valor =< 8 -> Poder = null
    ;   Valor = 9 -> Poder = mais_dois
    ;   Valor = 10 -> Poder = menos_dois
    ;   Valor = 11 -> Poder = bloquear(Elemento)
    ;   Valor = 12 -> Poder = inverte
    ),
    carta(Elemento, Valor, Poder),
    ProxValor is Valor + 1,
    gerar_cartas_elemento(Elemento, ProxValor, Cartas).

novo_baralho(Baralho) :-
    gerar_cartas_elemento(fogo, CartasFogo),
    gerar_cartas_elemento(agua, CartasAgua),
    gerar_cartas_elemento(neve, CartasNeve),
    append(CartasFogo, CartasAgua, FogoAgua),
    append(FogoAgua, CartasNeve, BaralhoTemp),
    embaralhar(BaralhoTemp, Baralho).

pegar_carta([], none, []).
pegar_carta([Carta|Cartas], Carta).

embaralhar(Lista, ListaEmbaralhada) :-
    length(Lista, N),
    gerar_indices(N, Indices),
    permutar_lista(Lista, Indices, ListaEmbaralhada).

gerar_indices(N, Indices) :-
    findall(X, between(0, N-1, X), Indices).

permutar_lista([], _, []).
permutar_lista(Lista, [Index | Indices], [Elemento | ListaEmbaralhada]) :-
    nth0(Index, Lista, Elemento),
    delete(Lista, Elemento, ListaSemElemento),
    permutar_lista(ListaSemElemento, Indices, ListaEmbaralhada).