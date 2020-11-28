makeMove(Player, State, NewState):-
	repeat,
		once(readColumn(NewColumn)),
		once(readRow(NewRow)),
		checkValid(NewRow, NewColumn, State),
	symbol(Player, S),
	updateMove(State, NewRow, NewColumn, S, TempState),
	repulsions(NewRow, NewColumn, TempState, NewState).



updateMove(Board, Row, Col, Player, FinalBoard):-
	playRow(Row, Board, Col, Player, FinalBoard).
	
playRow(1, [Row|RestRow], Col, Player, [NewRow|RestRow]):-
	playColumn(Col, Row, Player, NewRow).
	
playRow(NRow, [Row|RestRow], C, Player, [Row|NewRow]):-
	NRow > 1,
	N is NRow - 1,
	playRow(N, RestRow, C, Player, NewRow).
	
playColumn(1, [_|RestColumn], Player, [Player|RestColumn]).

playColumn(NColumn, [Col|RestColumn], Player, [Col|NewColumn]):-
	NColumn > 1,
	N is NColumn - 1,
	playColumn(N, RestColumn, Player, NewColumn).



checkValid(Row, Column, Board):-
	Row > 0,
	Column > 0,
	nth1(Row, Board, NewRow),
	nth1(Column, NewRow, Content),
	(
		Content == empty ->
		(
			true
		);
		(
			Content == 'Black' ->
			(
				write('Invalid position, square occupied by black.\n'),
				fail
			);
			(
				write('Invalid position, square occupied by red.\n'),
				fail
			)
		)
	).



getContent(Row, Column, State, Content):-
	Row > 0,
	Column > 0,
	nth1(Row, State, NewRow),
	nth1(Column, NewRow, Content).



%%%%%%%%%%%%%% REPULSIONS %%%%%%%%%%%%%%



checkTopLeft(1, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkTopLeft(_, 1, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkTopLeft(Row, Col, Board, UpdatedBoard):-
	Row > 2,
	Col > 2,
	AuxRow is Row-1,
	AuxCol is Col-1,
	NextAuxRow is Row-2,
	NextAuxCol is Col-2,
	getContent(AuxRow, AuxCol, Board, Piece),
	getContent(NextAuxRow, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkTopLeft(Row, Col, Board, UpdatedBoard):-
	Row > 1,
	Col > 1,
	AuxRow is Row-1,
	AuxCol is Col-1,
	updateMove(Board, AuxRow, AuxCol, empty, UpdatedBoard).


checkTop(1, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkTop(Row, Col, Board, UpdatedBoard):-
	Row > 2,
	AuxRow is Row-1,
	NextAuxRow is Row-2,
	getContent(AuxRow, Col, Board, Piece),
	getContent(NextAuxRow, Col, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, Col, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, Col, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkTop(Row, Col, Board, UpdatedBoard):-
	Row > 1,
	AuxRow is Row-1,
	updateMove(Board, AuxRow, Col, empty, UpdatedBoard).


checkTopRight(1, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkTopRight(_, 6, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkTopRight(Row, Col, Board, UpdatedBoard):-
	Row > 2,
	Col < 5,
	AuxRow is Row-1,
	AuxCol is Col+1,
	NextAuxRow is Row-2,
	NextAuxCol is Col+2,
	getContent(AuxRow, AuxCol, Board, Piece),
	getContent(NextAuxRow, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkTopRight(Row, Col, Board, UpdatedBoard):-
	Row > 1,
	Col < 6,
	AuxRow is Row-1,
	AuxCol is Col+1,
	updateMove(Board, AuxRow, AuxCol, empty, UpdatedBoard).


checkRight(_, 6, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkRight(Row, Col, Board, UpdatedBoard):-
	Col < 5,
	AuxCol is Col+1,
	NextAuxCol is Col+2,
	getContent(Row, AuxCol, Board, Piece),
	getContent(Row, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, Row, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, Row, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkRight(Row, Col, Board, UpdatedBoard):-
	Col < 6,
	AuxCol is Col+1,
	updateMove(Board, Row, AuxCol, empty, UpdatedBoard).


checkLeft(_, 1, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkLeft(Row, Col, Board, UpdatedBoard):-
	Col > 2,
	AuxCol is Col-1,
	NextAuxCol is Col-2,
	getContent(Row, AuxCol, Board, Piece),
	getContent(Row, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, Row, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, Row, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkLeft(Row, Col, Board, UpdatedBoard):-
	Col > 1,
	AuxCol is Col-1,
	updateMove(Board, Row, AuxCol, empty, UpdatedBoard).


checkBottomLeft(6, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkBottomLeft(_, 1, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkBottomLeft(Row, Col, Board, UpdatedBoard):-
	Row < 5,
	Col > 2,
	AuxRow is Row+1,
	AuxCol is Col-1,
	NextAuxRow is Row+2,
	NextAuxCol is Col-2,
	getContent(AuxRow, AuxCol, Board, Piece),
	getContent(NextAuxRow, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkBottomLeft(Row, Col, Board, UpdatedBoard):-
	Row < 6,
	Col > 1,
	AuxRow is Row+1,
	AuxCol is Col-1,
	updateMove(Board, AuxRow, AuxCol, empty, UpdatedBoard).


checkBottom(6, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkBottom(Row, Col, Board, UpdatedBoard):-
	Row < 5,
	AuxRow is Row+1,
	NextAuxRow is Row+2,
	getContent(AuxRow, Col, Board, Piece),
	getContent(NextAuxRow, Col, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, Col, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, Col, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkBottom(Row, Col, Board, UpdatedBoard):-
	Row < 6,
	AuxRow is Row+1,
	updateMove(Board, AuxRow, Col, empty, UpdatedBoard).


checkBottomRight(6, _, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkBottomRight(_, 6, Board, UpdatedBoard):-
	UpdatedBoard = Board.

checkBottomRight(Row, Col, Board, UpdatedBoard):-
	Row < 5,
	Col < 5,
	AuxRow is Row+1,
	AuxCol is Col+1,
	NextAuxRow is Row+2,
	NextAuxCol is Col+2,
	getContent(AuxRow, AuxCol, Board, Piece),
	getContent(NextAuxRow, NextAuxCol, Board, NextPiece),
	(
		(
			(Piece \= empty, NextPiece == empty) -> 
			(
				updateMove(Board, NextAuxRow, NextAuxCol, Piece, TempBoard),
				updateMove(TempBoard, AuxRow, AuxCol, empty, UpdatedBoard)
			)
		);
		UpdatedBoard = Board
	).

checkBottomRight(Row, Col, Board, UpdatedBoard):-
	Row < 6,
	Col < 6,
	AuxRow is Row+1,
	AuxCol is Col+1,
	updateMove(Board, AuxRow, AuxCol, empty, UpdatedBoard).



repulsions(Row, Column, TempState, NewState):-
	checkTopLeft(Row, Column, TempState, TempState1),
	checkTop(Row, Column, TempState1, TempState2),
	checkTopRight(Row, Column, TempState2, TempState3),
	checkRight(Row, Column, TempState3, TempState4),
	checkLeft(Row, Column, TempState4, TempState5),
	checkBottomLeft(Row, Column, TempState5, TempState6),
	checkBottom(Row, Column, TempState6, TempState7),
	checkBottomRight(Row, Column, TempState7, NewState).



%%%%%%%%%%%%%% CHECK GAME OVER %%%%%%%%%%%%%%



%CHECK 3 IN A ROW

checkLeftDiag(_, _, _, _, 0).

checkLeftDiag(Row, Col, Board, Piece, No):-
	Row < 7,
	Col < 7,
	getContent(Row, Col, Board, Piece),
	NewRow is Row-1,
	NewCol is Col-1,
	Aux is No-1,
	checkLeftDiag(NewRow, NewCol, Board, Piece, Aux),
	!.

checkRightDiag(_, _, _, _, 0).

checkRightDiag(Row, Col, Board, Piece, No):-
	Row < 7,
	Col < 7,
	getContent(Row, Col, Board, Piece),
	NewRow is Row-1,
	NewCol is Col+1,
	Aux is No-1,
	checkRightDiag(NewRow, NewCol, Board, Piece, Aux),
	!.

checkCol(_, _, _, _, 0).

checkCol(Row, Col, Board, Piece, No):-
	Row < 7,
	Col < 7,
	getContent(Row, Col, Board, Piece),
	NewRow is Row-1,
	Aux is No-1,
	checkCol(NewRow, Col, Board, Piece, Aux),
	!.

checkRow(_, _, _, _, 0).

checkRow(Row, Col, Board, Piece, No):-
	Row < 7,
	Col < 7,
	getContent(Row, Col, Board, Piece),
	NewCol is Col-1,
	Aux is No-1,
	checkRow(Row, NewCol, Board, Piece, Aux),
	!.


checkThree(Row, Col, Board, Piece):-
	Row > 0,
	Col > 0,
	checkLeftDiag(Row, Col, Board, Piece, 3);
	checkRightDiag(Row, Col, Board, Piece, 3);
	checkCol(Row, Col, Board, Piece, 3);
	checkRow(Row, Col, Board, Piece, 3).

checkThree(Row, Col, Board, Piece):-
	Row > 0,
	Col > 0,
	NewRow is Row-1,
	checkThree(NewRow, Col, Board, Piece).

checkThree(Row, Col, Board, Piece):-
	Row > 0,
	Col > 0,
	NewCol is Col-1,
	checkThree(Row, NewCol, Board, Piece).



%CHECK 8 PIECES

checkPieces(_, _, _, _, 0).

checkPieces(Row, Col, Piece, Board, No):-
	Row > 0,
	Col > 0,
	getContent(Row, Col, Board, Content),
	(
		(Content == Piece) -> 
			Aux is No-1;
			Aux is No
	),
	NewCol is Col-1,
	checkPieces(Row, NewCol, Piece, Board, Aux).

checkPieces(Row, Col, Piece, Board, No):-
	Col =< 0,
	NewCol is 6,
	NewRow is Row-1,
	checkPieces(NewRow, NewCol, Piece, Board, No).
