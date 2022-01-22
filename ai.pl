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


%choose_move(S, Move):- valid_moves(S, Move),
%                       play_move(Level, S, Moves, Move).

%valid_moves(S, Moves):-
%            findall(Row-Column, check_bound(S, Row, Column, Value), Moves).

%play_move(1,S,Moves, Move):-random_select(Move, Moves, Rest).


playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,9,P1,P2,L1,L2):- playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,Column,P1,P2,L1,L2):- check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     SubL = [Row,Column], append(L1,[SubL],L3),
                                     playableColumnAI(S,Row,Column1,P1,P2,L3,L2);
                                     \+ check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     playableColumnAI(S,Row,Column1,P1,P2,L1,L2).


listOfAll(S,SNew,P,P2,X):- playableColumnAI(S,1,1,P,P2,[],L2),
                    playableColumnAI(S,2,1,P,P2,L2,L3),
                    playableColumnAI(S,3,1,P,P2,L3,L4),
                    playableColumnAI(S,4,1,P,P2,L4,L5),
                    playableColumnAI(S,5,1,P,P2,L5,L6),
                    playableColumnAI(S,6,1,P,P2,L6,L7),
                    playableColumnAI(S,7,1,P,P2,L7,L8),
                    playableColumnAI(S,8,1,P,P2,L8,L9),
                    X = L9, handleList(S,SNew,P,X).

handleList(S,SNew,P,[]):- nl,write('               Game Over!                 '),nl, inverse(P,P2), game_over(S,P2),nl,play.
handleList(S,SNew,P,[[H1|H2]|T]):-  Row is H1, Column is H2, changeBoard(S,SNew,Row,Column,P).

inverse(p1,P):- P = p2.
inverse(p2,P):- P = p1.