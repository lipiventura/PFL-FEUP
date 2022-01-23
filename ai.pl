%Fazer função que retorne todas as jogadas possíveis para o compuador
%Para cada jogada avaliar com quantas jogadas possíveis o adversário fica (valor menor que 0) e o computador (valor maior que 0)
%Somar os dois valores e optar pela jogada que retorne maior valor (heurística)

checkAllAI(S,1,1,Value):- checkBoardAI(S,1,2,Value), checkBoardAI(S,2,1,Value).
checkAllAI(S,1,8,Value):- checkBoardAI(S,1,7,Value), checkBoardAI(S,2,8,Value).
checkAllAI(S,8,1,Value):- checkBoardAI(S,8,2,Value), checkBoardAI(S,7,1,Value).
checkAllAI(S,8,8,Value):- checkBoardAI(S,8,7,Value), checkBoardAI(S,7,8,Value).

checkAllAI(S,1,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoardAI(S,2,Column,Value),checkBoardAI(S,1,Column2,Value),checkBoardAI(S,1,Column3,Value).
checkAllAI(S,8,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoardAI(S,7,Column,Value),checkBoardAI(S,8,Column2,Value),checkBoardAI(S,8,Column3,Value).
checkAllAI(S,Row,1,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoardAI(S,Row,2,Value),checkBoardAI(S,Row2,1,Value),checkBoardAI(S,Row3,1,Value).
checkAllAI(S,Row,8,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoardAI(S,Row,7,Value),checkBoardAI(S,Row2,8,Value),checkBoardAI(S,Row3,8,Value).
                        
checkAllAI(S,Row,Column,Value):- Row2 is Row + 1,Row3 is Row - 1,Column2 is Column + 1,Column3 is Column - 1,
                               checkBoardAI(S,Row2,Column,Value),
                               checkBoardAI(S,Row3,Column,Value),
                               checkBoardAI(S,Row,Column2,Value),
                               checkBoardAI(S,Row,Column3,Value).

checkListAI([H|T],1,Value):- \+ H = Value.
checkListAI([H|T],Column,Value):- Column > 1,
                                     Column2 is Column - 1,
                                     checkListAI(T,Column2,Value).

checkBoardAI([H|T],1,Column,Value):- checkListAI(H,Column,Value).
checkBoardAI([H|T],Row,Column,Value):- Row > 1,
                                     Row2 is Row - 1,
                                     checkBoardAI(T,Row2,Column,Value).


checkAI(S,Row,Column,P1,P2,Row-Column):- masterRuleAI(S,Row,Column,P1,P2),
                            checkBoardAI(S,Row,Column,P1),
                            checkBoardAI(S,Row,Column,P2).

masterRuleAI(S,Row,Column,P,P2):- checkAllAI(S,Row,Column,P2);
                                \+ checkAllAI(S,Row,Column,P2), \+ checkAllAI(S,Row,Column,P).


playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,9,P1,P2,L1,L2):- playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,Column,P1,P2,L1,L2):- check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     SubL = [Row,Column], append(L1,[SubL],L3),
                                     playableColumnAI(S,Row,Column1,P1,P2,L3,L2);
                                     \+ check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     playableColumnAI(S,Row,Column1,P1,P2,L1,L2).

%obtém a lista de valid_moves para os 2 jogadores 
valid_moves(S,L):- playableColumnAI(S,1,1,p1,p2,[],L2),
                   playableColumnAI(S,2,1,p1,p2,L2,L3),
                   playableColumnAI(S,3,1,p1,p2,L3,L4),
                   playableColumnAI(S,4,1,p1,p2,L4,L5),
                   playableColumnAI(S,5,1,p1,p2,L5,L6),
                   playableColumnAI(S,6,1,p1,p2,L6,L7),
                   playableColumnAI(S,7,1,p1,p2,L7,L8),
                   playableColumnAI(S,8,1,p1,p2,L8,L9),
                   LP1 = L9,
                   playableColumnAI(S,1,1,p2,p1,[],M2),
                   playableColumnAI(S,2,1,p2,p1,M2,M3),
                   playableColumnAI(S,3,1,p2,p1,M3,M4),
                   playableColumnAI(S,4,1,p2,p1,M4,M5),
                   playableColumnAI(S,5,1,p2,p1,M5,M6),
                   playableColumnAI(S,6,1,p2,p1,M6,M7),
                   playableColumnAI(S,7,1,p2,p1,M7,M8),
                   playableColumnAI(S,8,1,p2,p1,M8,M9),
                   LP2 = M9,
                   L = [LP1|LP2].

move(S,[H1|H2],SNew,P):- Row is H1, Column is H2, changeBoard(S,SNew,Row,Column,P).


handleList(S,SNew,Level,P,[]):- nl,write('               Game Over!                 '),nl, inverse(P,P2), game_over(S,P2),nl,play.
handleList(S,SNew,1,P,[H|T]):- move(S,H,SNew,P). 

%Nível 2 de AI
%handleList(S,SNew,2,P,[]):- move(S,H,SNew,P). 
handleList(S,SNew,2,P,L):- checkBestOption(S,SNew,L,P,64,M1).

%obtém-se jogador adversário com base no que está a jogar
inverse(p1,P):- P = p2.
inverse(p2,P):- P = p1.

checkBestOption(S,SNew,[],P,64,M1):- move(S,M1,SNew,P).
checkBestOption(S,SNew,[H],P,64,M1):- move(S,H,SNew,P).
checkBestOption(S,SNew,[H|T],P,N,M1):- move(S,H,S2,P),
                                  valid_moves(S2,[H2|T2]),
                                  %nl,write([H2|T2]),nl,
                                  countList(H2,N2),
                                  bestOptions(S,SNew,T,P,N,N2,M1,H).

                             

%vê qual é o maior e invoca checkBestOption de novo com o melhor movimento
bestOptions(S,SNew,[],P,N,N2,M1,M2):- checkBestOption(S,SNew,[],P,64,M1).
bestOptions(S,SNew,T,P,N,N2,M1,M2):- N > N2 ->
                                   checkBestOption(S,SNew,T,P,N2,M2);
                                   checkBestOption(S,SNew,T,P,N,M1).
                                  

%conta os elements de uma lista
countList([],0).
countList([H|T],N):- countList(T, N1),
                     N is N1 + 1.

choose_move(S,1,[H|T]):- valid_moves(S,[H|T]).
choose_move(S,2,[H|T]):- valid_moves(S,[H|T]).
