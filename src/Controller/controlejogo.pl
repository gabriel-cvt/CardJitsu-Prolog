:- module(controle_jogo, [controller_Jogo/1]).

:- use_module('./src/Types/player.pl').
:- use_module('./src/Services/jogo.pl').
:- use_module('./src/Controller/controleFases.pl').
:- use_module('./src/Services/salvamentos.pl').
:- use_module('./src/Types/faixa.pl').

controller_Jogo(NomeBot) :-

    iniciar_jogo([0, 0], PrimeiraRodada),

    vencedor_primeira_rodada_print(PrimeiraRodada, NomeBot),
    % lib:barra_carregamento,

    (PrimeiraRodada

    % Jogador Venceu a primeira rodada
        iniciar_jogo([1, 0], SegundaRodada),
        (PrimeiraRodada =:= SegundaRodada
         -> jogador_ganhou
         ;  ultima_rodada(NomeBot))

    % Jogador perdeu a primeira rodada
     ;  iniciar_jogo([0, 1], SegundaRodada),
        (PrimeiraRodada =:= SegundaRodada
        ->  jogador_perdeu
        ;   ultima_rodada(NomeBot))).

vencedor_primeira_rodada_print(Rodada, NomeBot) :-
    (Rodada
    ->  format('~s: Você ganhou a primeira, mas a próxima irei te destruir.~n', [NomeBot])
    ;   format('~s: Você está levando isso a sério? Dessa forma nunca conseguirá ser um Mestre ninja.~n', [NomeBot])).

ultima_rodada(NomeBot) :- 
    format('Pelo visto a batalha está  difícil com ~s, será necessário um desempate!~n', [NomeBot]),
    % lib:barra_carregamento,
    iniciar_jogo([1, 1], Vencedor),
    verifica_vencedor(Vencedor).

verifica_vencedor(UltimaRodada) :-
    (UltimaRodada -> jogador_ganhou ; jogador_perdeu).

jogador_ganhou :-
    salvamentos:up_jogador_partida,

    % função print jogador ganhou

    lib:pressionar_tecla,
    continuar_jogando.

jogador_perdeu :-

    % função print jogador perdeu

    lib:pressionar_tecla,
    continuar_jogando.

continuar_jogando :-

    % Função print continuar jogando.

    lib:input_to_number(Escolha),
    opcao_jogando(Escolha).

opcao_jogando(1) :-
    controle_fase:carregar_fase.

opcao_jogando(2) :-
    controle_menu: menu.

opcao_jogando(_) :-
    write("Opção inválida, tente novamente.\n"),
    lib:pressionar_tecla,
    continuar_jogando.
