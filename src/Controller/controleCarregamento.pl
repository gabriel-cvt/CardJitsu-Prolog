:- user_module('./src/Services/salvamentos.pl').
:- user_module('./src/Services/saidas.pl').
:- user_module('./src/Types/player.pl').
:- user_module('./src/Controller/controleFases.pl').
:- use_module('./src/Util/lib.pl').

novo_jogo :- 
    saidas:printNovoJogo,
    read(Nome),
    inicializa_jogador(Nome),
    carregar_fase.

inicializa_jogador(Nome) :-
    novo_jogador(Nome, Player),
    salvar_jogador(Player).

carregar_jogo :- 
    write("Verificando progresso..."),
    carregar_jogador(_, Player),
    existe_progresso(Player, Progresso),
    (Progresso -> carregar_fase ; 
    write("Você não tem nenhum progresso salvo.\nVamos começar um novo agora!"),
    pressionar_tecla,
    novo_jogo).

carregar_fase :-
    clearScreen,
    write("Carregando fase..."),
    lib:barra_carregamento,
    pressionar_tecla,
    clearScreen,
    player:carregar_jogador(_, Player),
    player:get_faixa(Player, Faixa),
    controleFases:carregar_fase_jogador(Faixa).