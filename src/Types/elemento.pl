:- module(elemento, [elemento/1, show_elemento/2, prioridade_elemento/3]).

elemento(fogo).
elemento(agua).
elemento(neve).

show_elemento(fogo, "FOGO").
show_elemento(agua, "ÁGUA").
show_elemento(neve, "NEVE").

prioridade_elemento(fogo, neve).
prioridade_elemento(neve, agua).
prioridade_elemento(agua, fogo).
prioridade_elemento(_, _) :- false.