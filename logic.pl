%Row or Column Selection

rowSelection(Row):- write('Insert Row '),
                    read(Input),
                    (alphabet(Input,R) ->
                    Row is R;
                    nl,write('Insert Row Again (Correctly) '),
                    rowSelection(Row)).

columnSelection(Column):- write('Insert Column '),
                          read(Input),
                          (number(Input) -> 
                          ((Input >= 1, Input =< 8) ->
                          Column is Input;
                          nl,write('Insert Column Again (Correctly) '),
                          columnSelection(Column));
                          nl,write('Insert Column Again (Correctly) '),
                          columnSelection(Column)).


%Replace Elements

changeList([H|T],[Value|T],1,Value) :- H = empty.
changeList([H|T],[H|T2],Column,Value):- Column > 1,
                                        Column2 is Column - 1,
                                        changeList(T,T2,Column2,Value).

changeBoard([H|T],[H2|T],1,Column,Value):- changeList(H,H2,Column,Value).
changeBoard([H|T],[H|T2],Row,Column,Value):- Row > 1,
                                             Row2 is Row - 1,
                                             changeBoard(T,T2,Row2,Column,Value).

%Rules

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


check(S,Row,Column,P1,P2):- masterRule(S,Row,Column,P1,P2),
                            checkBoard(S,Row,Column,P1),
                            checkBoard(S,Row,Column,P2).




playableColumn(S,Row,9,P1,P2,N1,N1).
playableColumn(S,Row,9,P1,P2,N1,N2):- playableColumn(S,Row,9,P1,P2,N1,N1).
playableColumn(S,Row,Column,P1,P2,N1,N2):- check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     N3 is N1 + 1,
                                     playableColumn(S,Row,Column1,P1,P2,N3,N2);
                                     \+ check(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     playableColumn(S,Row,Column1,P1,P2,N1,N2).

emptyColumn(S,Row,9,Value).
emptyColumn(S,Row,Column,Value):- checkBoard(S,Row,Column,Value),
                                  Column1 is Column + 1,
                                  emptyColumn(S,Row,Column1,Value).

emptyRow(S,9,Column,Value).
emptyRow(S,Row,Column,Value):- emptyColumn(S,Row,Column,Value),
                               Row1 is Row + 1,
                               emptyRow(S,Row1,Column,Value).

masterRule(S,Row,Column,P,P2):- checkAll(S,Row,Column,P2);
                                \+ checkAll(S,Row,Column,P2), \+ checkAll(S,Row,Column,P).


%Proceed
canProceed(S):- write('Insert \'n\' to Proceed '),
                read(Input),
                (Input = 'n' ->
                true;
                nl,write('Insert \'n\' to Proceed (Correctly) '),
                canProceed(S)).

