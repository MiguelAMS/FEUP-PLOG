:-dynamic(state/2).

play:-
	initial(GameState),
	display_game(GameState),
	game_loop(Player1, Player2).


initial(GameState):-
    initialBoard(GameState).
    
display_game(GameState):-
    printBoard(GameState).

repeat.
repeat:-
    repeat.

game_loop(Player1, Player2):-
	initial(GameState),
	assert(move(1, Player1)),
    assert(move(2, Player2)),
    assert(state(1, GameState)),
    repeat,
	retract(state(Player, Board)),
	once(makeMove(Player, Board, NextPlayer, NewBoard)),
	assert(state(NextPlayer, NewBoard)),
	1 > 2,
	endGame.

makeMove(Player, State, NextPlayer, NewState):-
    symbol(Player, Str),
	write(Str),
	write(' Turn\n'),
	playMove(Str, State, NewState),
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

endGame.

/*
/*Initial gamestate
initial(GameState):-
    initialBoard(GameState).
    
/*displays the current board state
display_game(GameState, Player):-
    printBoard(GameState).

/*loop that allows the players to make moves until game over
game_loop(GameState):-
*/
