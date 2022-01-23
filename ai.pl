%Fazer função que retorne todas as jogadas possíveis para o compuador
%Para cada jogada avaliar com quantas jogadas possíveis o adversário fica (valor menor que 0) e o computador (valor maior que 0)
%Somar os dois valores e optar pela jogada que retorne maior valor (heurística)

%coloca a peça no sítio desejado (apenas para quando o computador joga)
move(S,[H1|H2],SNew,P):- Row is H1, Column is H2, changeBoard(S,SNew,Row,Column,P).

%invoca o predicado move e caso já tenho acabado, anuncia o fim do jogo
handleList(S,SNew,Level,P,[]):- nl,write('               Game Over!                 '),nl, inverse(P,P2), game_over(S,P2),nl.
handleList(S,SNew,1,P,[H|T]):- move(S,H,SNew,P). 

%Nível 2 de AI
handleList(S,SNew,2,P,L):- checkBestOption(S,SNew,L,P,64,M1).

%obtém-se jogador adversário com base no que está a jogar
inverse(p1,P):- P = p2.
inverse(p2,P):- P = p1.

%para cada posição, vê lista valid moves caso fosse desempenhada
checkBestOption(S,SNew,[],P,64,M1):- move(S,M1,SNew,P).
checkBestOption(S,SNew,[H],P,64,M1):- move(S,H,SNew,P).
checkBestOption(S,SNew,[H|T],p1,N,M1):- move(S,H,S2,p1),
                                  valid_moves(S2,[H2|T2]),
                                  countList(T2,N2),
                                  bestOptions(S,SNew,T,p1,N,N2,M1,H).
checkBestOption(S,SNew,[H|T],p2,N,M1):- move(S,H,S2,p2),
                                  valid_moves(S2,[H2|T2]),
                                  countList(H2,N2),
                                  bestOptions(S,SNew,T,p2,N,N2,M1,H).

                             

%vê qual é o maior e invoca checkBestOption de novo com o melhor movimento, comparando o número de jogadas que o advesário teria
bestOptions(S,SNew,[],P,N,N2,M1,M2):- checkBestOption(S,SNew,[],P,64,M1).
bestOptions(S,SNew,T,P,N,N2,M1,M2):- N > N2 ->
                                   checkBestOption(S,SNew,T,P,N2,M2);
                                   checkBestOption(S,SNew,T,P,N,M1).
                                  

%conta os elements de uma lista
countList([],0).
countList([H|T],N):- countList(T, N1),
                     N is N1 + 1.

%invoca o predicado valid moves
choose_move(S,1,[H|T]):- valid_moves(S,[H|T]).
choose_move(S,2,[H|T]):- valid_moves(S,[H|T]).
