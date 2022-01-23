%row selection até ser válido
rowSelection(Row):- write('Insert Row '),
                    read(Input),
                    (alphabet(Input,R) ->
                    Row is R;
                    Input = 'r' ->
                    play;
                    nl,write('Insert Row Again (Correctly) '),
                    rowSelection(Row)).

%column selection até ser válido
columnSelection(Column):- write('Insert Column '),
                          read(Input),
                          (number(Input) -> 
                          ((Input >= 1, Input =< 8) ->
                          Column is Input;
                          nl,write('Insert Column Again (Correctly) '),
                          columnSelection(Column));
                          Input = 'r' ->
                          play;
                          nl,write('Insert Column Again (Correctly) '),
                          columnSelection(Column)).

%replace elements

%altera o valor de empty para peça caso seja possível
changeList([H|T],[Value|T],1,Value) :- H = empty.
changeList([H|T],[H|T2],Column,Value):- Column > 1,
                                        Column2 is Column - 1,
                                        changeList(T,T2,Column2,Value).

%altera o valor empty recorrendo ao predicado changeList para a peça caso seja possível
changeBoard([H|T],[H2|T],1,Column,Value):- changeList(H,H2,Column,Value).
changeBoard([H|T],[H|T2],Row,Column,Value):- Row > 1,
                                             Row2 is Row - 1,
                                             changeBoard(T,T2,Row2,Column,Value).

%Rules
%vê se é possível colocar a peça em algum dos cantos
checkAllAI(S,1,1,Value):- checkBoardAI(S,1,2,Value), checkBoardAI(S,2,1,Value).
checkAllAI(S,1,8,Value):- checkBoardAI(S,1,7,Value), checkBoardAI(S,2,8,Value).
checkAllAI(S,8,1,Value):- checkBoardAI(S,8,2,Value), checkBoardAI(S,7,1,Value).
checkAllAI(S,8,8,Value):- checkBoardAI(S,8,7,Value), checkBoardAI(S,7,8,Value).

%vê se é possível colocar a peça em alguma das margens
checkAllAI(S,1,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoardAI(S,2,Column,Value),checkBoardAI(S,1,Column2,Value),checkBoardAI(S,1,Column3,Value).
checkAllAI(S,8,Column,Value):- Column2 is Column + 1, Column3 is Column - 1,
                             checkBoardAI(S,7,Column,Value),checkBoardAI(S,8,Column2,Value),checkBoardAI(S,8,Column3,Value).
checkAllAI(S,Row,1,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoardAI(S,Row,2,Value),checkBoardAI(S,Row2,1,Value),checkBoardAI(S,Row3,1,Value).
checkAllAI(S,Row,8,Value):- Row2 is Row + 1, Row3 is Row - 1,
                          checkBoardAI(S,Row,7,Value),checkBoardAI(S,Row2,8,Value),checkBoardAI(S,Row3,8,Value).

%vê se é possível colocar a peça no meio do tabuleiro                        
checkAllAI(S,Row,Column,Value):- Row2 is Row + 1,Row3 is Row - 1,Column2 is Column + 1,Column3 is Column - 1,
                               checkBoardAI(S,Row2,Column,Value),
                               checkBoardAI(S,Row3,Column,Value),
                               checkBoardAI(S,Row,Column2,Value),
                               checkBoardAI(S,Row,Column3,Value).

%essencial para ver o valor numa linha específica
checkListAI([H|T],1,Value):- \+ H = Value.
checkListAI([H|T],Column,Value):- Column > 1,
                                  Column2 is Column - 1,
                                  checkListAI(T,Column2,Value).

%essencial para depois de chegar à coluna pretendida, ver o valor numa linha específica
checkBoardAI([H|T],1,Column,Value):- checkListAI(H,Column,Value).
checkBoardAI([H|T],Row,Column,Value):- Row > 1,
                                     Row2 is Row - 1,
                                     checkBoardAI(T,Row2,Column,Value).

%vê se a jogada obedece às regras e se é um lugar vazio ou não
checkAI(S,Row,Column,P1,P2):- masterRuleAI(S,Row,Column,P1,P2),
                              checkBoardAI(S,Row,Column,P1),
                              checkBoardAI(S,Row,Column,P2).

%principal predicado relativo a regras (obedecendo à regra de não poder tocar adversário a menos que toque numa peça igual)
masterRuleAI(S,Row,Column,P,P2):- checkAllAI(S,Row,Column,P2);
                                \+ checkAllAI(S,Row,Column,P2), \+ checkAllAI(S,Row,Column,P).


%vê quais os valid moves numa linha específica e faz append dos moves válidos
playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,9,P1,P2,L1,L2):- playableColumnAI(S,Row,9,P1,P2,L1,L1).
playableColumnAI(S,Row,Column,P1,P2,L1,L2):- checkAI(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     SubL = [Row,Column], append(L1,[SubL],L3),
                                     playableColumnAI(S,Row,Column1,P1,P2,L3,L2);
                                     \+ checkAI(S,Row,Column,P1,P2),
                                     Column1 is Column + 1,
                                     playableColumnAI(S,Row,Column1,P1,P2,L1,L2).

%obtém a lista de valid_moves para os 2 jogadores fazendo append linha a linha para cada
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


%esencial para saber se houve empate, vê em linha específica
emptyColumn(S,Row,9,Value).
emptyColumn(S,Row,Column,Value):- checkBoardAI(S,Row,Column,Value),
                                  Column1 is Column + 1,
                                  emptyColumn(S,Row,Column1,Value).

%esencial para saber se houve empate (nada está vazio)
emptyRow(S,9,Column,Value).
emptyRow(S,Row,Column,Value):- emptyColumn(S,Row,Column,Value),
                               Row1 is Row + 1,
                               emptyRow(S,Row1,Column,Value).

%muda apenas se a jogada obedecer às regras, caso contrário repete o pedido de jogada
doChanging(S,SNew,P,P2):- repeat,
                rowSelection(Row),
                columnSelection(Column),
                masterRuleAI(S,Row,Column,P,P2),
                changeBoard(S,SNew,Row,Column,P).


%Proceed
canProceed(S):- write('Insert \'n\' to Proceed '),
                read(Input),
                (Input = 'n' ->
                true;
                Input = 'r' ->
                play;
                nl,write('Insert \'n\' to Proceed (Correctly) '),
                canProceed(S)).

%Return to Menu
returnToMenu:- write('Insert \'n\' to Return to the Menu Screen'),
               read(Input),
               (Input = 'n' ->
                true;
                nl, write('Going Back to the Menu Screen')   ) ,
                play.

