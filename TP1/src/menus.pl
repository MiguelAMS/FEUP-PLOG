play:-
    initial(GameState),
    display_game(GameState, Player).

/*Initial gamestate*/
initial(GameState):-
    initialBoard(GameState).
    
/*displays the current board state*/
display_game(GameState, Player):-
    printBoard(GameState).