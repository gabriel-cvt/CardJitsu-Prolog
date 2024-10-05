:- use_module(library(readutil)).

caminho_jogador :- './src/Repositories/jogador.txt'.

salvar_jogador(Jogador) :-
    open(caminho_jogador, write, Stream),
    write(Stream, Jogador),
    write(Steam, '.'),
    nl(Stream),
    close(Stream).

carregar_jogador(_, Jogador) :-
    open(caminho_jogador, read, Stream),
    read(Stream, Jogador),
    close(Stream).

existe_progresso(player(_,_, Progresso)) :-
    Progresso \= 0.

carregar_instrucoes(_, Texto) :-
    open('./src/Repositories/instrucoes.txt', read, Stream),
    read(Stream, Texto),
    close(Stream)
.