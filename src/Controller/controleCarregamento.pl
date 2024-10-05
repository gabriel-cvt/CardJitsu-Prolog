:- module(controle_carregamento, [novo_jogo/0, inicializa_jogador/1, carregar_jogo/0, carregar_fase/0]).

:- use_module('./src/Services/salvamentos.pl').  % Carrega o módulo salvamentos
:- use_module('./src/Services/saidas.pl').       % Carrega o módulo saidas
:- use_module('./src/Types/player.pl').          % Carrega o módulo player
:- use_module('./src/Controller/controleFases.pl'). % Carrega o módulo controleFases
:- use_module('./src/Util/lib.pl').              % Carrega o módulo lib

% Iniciar novo jogo
novo_jogo :- 
    lib:clearScreen,
    saidas:printNovoJogo,
    lib:get_user_input(Nome),
    inicializa_jogador(Nome),
    carregar_fase.

% Inicializar jogador
inicializa_jogador(Nome) :-
    player:novo_jogador(Nome, Player),
    salvamentos:salvar_jogador(PlayerCriado).

% Carregar jogo salvo
carregar_jogo :- 
    lib:clearScreen,
    write("Verificando progresso...\n"),
    % lib:barra_carregamento,
    salvamentos:carregar_jogador(Player),
    (salvamentos:existe_progresso(Player) 
    ->  carregar_fase
    ;   write("Você não tem nenhum progresso salvo.\nVamos começar um novo agora!\n"),
        lib:pressionar_tecla,
        novo_jogo).

% Carregar a fase do jogador
carregar_fase :-
    lib:clearScreen,
    write("Carregando fase..."),
    % lib:barra_carregamento,
    lib:clearScreen,
    salvamentos:carregar_jogador(Player),
    player:get_faixa(Player, Faixa),
    controle_fase:fase_jogador(Faixa).
