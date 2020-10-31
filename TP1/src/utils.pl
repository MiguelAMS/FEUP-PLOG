playMove(Player, State, NewState):-
	readRow(Row, NextRow),
	readColumn(Column, NextColumn),
	updateMove(State, NextRow, NextColumn, Player, NewState).


updateMove(InitialMatrix, R, C, Player, FinalMatrix):-
	playRow(R, InitialMatrix, C, Player, FinalMatrix),
	display_game(FinalMatrix).
	
playRow(1, [Row|RestRow], C, Player, [NewRow|RestRow]):-
	playColumn(C, Row, Player, NewRow).
	
playRow(NRow, [Row|RestRow], C, Player, [Row|NewRow]):-
	NRow > 1,
	N is NRow - 1,
	playRow(N, RestRow, C, Player, NewRow).
	
playColumn(1, [_|RestColumn], Player, [Player|RestColumn]).
playColumn(NColumn, [P|RestColumn], Player, [P|NewColumn]):-
	NColumn > 1,
	N is NColumn - 1,
	playColumn(N, RestColumn, Player, NewColumn).
