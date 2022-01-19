/*Fazer função que retorne todas as jogadas possíveis para o compuador
Para cada jogada avaliar com quantas jogadas possíveis o adversário fica (valor menor que 0) e o computador (valor maior que 0)
Somar os dois valores e optar pela jogada que retorne maior valor (heurística)*/

choose_move(S, Move):- valid_moves(S, Move),
                       play_move(Level, S, Moves, Move).

valid_moves(S, Moves):-
            findall(Row-Column, check_bound(S, Row, Column, Value), Moves).

checkAll(S,1,1,Value):- checkBoard(S,1,2,Value), checkBoard(S,2,1,Value).
checkAll(S,1,8,Value):- checkBoard(S,1,7,Value), checkBoard(S,2,8,Value).
checkAll(S,8,1,Value):- checkBoard(S,8,2,Value), checkBoard(S,7,1,Value).
checkAll(S,8,8,Value):- checkBoard(S,8,7,Value), checkBoard(S,7,8,Value).

checkAll(S,1,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoard(S,2,Column,Value),checkBoard(S,1,Column2,Value),checkBoard(S,1,Column3,Value).
checkAll(S,8,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoard(S,7,Column,Value),checkBoard(S,8,Column2,Value),checkBoard(S,8,Column3,Value).
checkAll(S,Row,1,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoard(S,Row,2,Value),checkBoard(S,Row2,1,Value),checkBoard(S,Row3,1,Value).
checkAll(S,Row,8,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoard(S,Row,7,Value),checkBoard(S,Row2,8,Value),checkBoard(S,Row3,8,Value).
                        
checkAll(S,Row,Column,Value):- Row2 is Row + 1,Row3 is Row - 1,Column2 is Column + 1,Column3 is Column - 1,
                               checkBoard(S,Row2,Column,Value),
                               checkBoard(S,Row3,Column,Value),
                               checkBoard(S,Row,Column2,Value),
                               checkBoard(S,Row,Column3,Value).

checkList([H|T],1,Value):- \+ H = Value.
checkList([H|T],Column,Value):- Column > 1,
                                     Column2 is Column - 1,
                                     checkList(T,Column2,Value).

checkBoard([H|T],1,Column,Value):- checkList(H,Column,Value).
checkBoard([H|T],Row,Column,Value):- Row > 1,
                                     Row2 is Row - 1,
                                     checkBoard(T,Row2,Column,Value).


check(S,Row,Column,P1,P2,Row-Column):- masterRule(S,Row,Column,P1,P2),
                            checkBoard(S,Row,Column,P1),
                            checkBoard(S,Row,Column,P2).

masterRule(S,Row,Column,P,P2):- checkAll(S,Row,Column,P2);
                                \+ checkAll(S,Row,Column,P2), \+ checkAll(S,Row,Column,P).

play_move(1,S,Moves, Move):-random_select(Move, Moves, Rest).



