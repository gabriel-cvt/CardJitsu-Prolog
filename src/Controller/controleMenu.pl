:- use_module('./src/Util/lib.pl').
:- use_module('./src/Services/saidas.pl').
:- user_module('./src/Controller/controleJogo.pl').
:- user_module('./src/Controller/controleCarregamento.pl').

menu :- 
    clearScreen,
    saidas:printMenu,
    lib:input_number("\nSua escolha é: ", Escolha),
    opcaoMenu(Escolha).

opcaoMenu(1) :-
    controleCarregamento:novo_jogo,
    menu.

opcaoMenu(2) :-
    controleCarregamento:carregar_jogo,
    menu.

opcaoMenu(3) :-
    % Checar faixas
    menu.

opcaoMenu(4) :-
    ler_instrucoes,
    pressionar_tecla,
    menu.

opcaoMenu(5) :-
    write("Até a próxima, jovem ninja."),
    halt(0).

opcaoMenu(_) :-
    write("Opção inválida, tente novamente."),
    pressionar_tecla,
    menu.