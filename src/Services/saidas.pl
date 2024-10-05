printMenu :-
    write("======= Bem vindo ao Dojo! ======="),
    write("Qual vai ser a sua escolha para hoje?"),
    write("1 - Começar novo jogo"),
    write("2 - Carregar jogo"),
    write("3 - Checar faixas"),
    write("4 - Instruções"),
    write("5 - Sair do jogo").

printNovoJogo :-
    write("Começando uma nova aventura ninja..."),
    write("Qual é o seu nome?").

ler_instrucoes :-
    carregar_instrucoes(_, Instrucoes),
    write(Instrucoes).