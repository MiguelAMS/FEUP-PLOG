:-dynamic(state/2).

play:-
	initial(GameState),
	game_loop(Player1, Player2).

initial(GameState):-
    initialBoard(GameState).
    
display_game(Player, GameState):-
	printBoard(GameState),
	symbol(Player, S),
	write(S),
	write(' ('),
	symbol(S, Str),
	write(Str),
	write(') To Play:'), nl.



repeat.
repeat:-
    repeat.

game_loop(Player1, Player2):-
	initial(GameState),
    assert(state(1, GameState)),
    repeat,
		retract(state(Player, Board)),
		once(display_game(Player, Board)),
		once(playPiece(Player, Board, NextPlayer, NewBoard)),
		assert(state(NextPlayer, NewBoard)),
		gameOver(NewBoard),
	printBoard(NewBoard),
	retract(state(_,_)),
	endGame.



playPiece(Player, Board, NextPlayer, UpdatedBoard):-
	makeMove(Player, Board, UpdatedBoard),
	(
		(
			Player =:= 1,
		    NextPlayer is 2
		);
		(
			Player =:= 2,
			NextPlayer is 1
		)
	).



checkWin(Board, Player):-
	(checkPieces(6, 6, Player, Board, 8), assert(winner(Player)));
	(checkThree(7, 7, Board, Player), assert(winner(Player))).

gameOver(Board):-
	checkWin(Board, 'Black');
	checkWin(Board, 'Red').



endGame:-
	retract(winner(Player)), nl,
	write(Player),
	write(' wins the game!!!!\n').