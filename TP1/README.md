






# PLOG 2020/2021 - TP1

## Group T04_Gekitai2
| Name             | Number    | E-Mail             |
| ---------------- | --------- | ------------------ |
| Miguel Silva        | 201806388 | up201806388@fe.up.pt                |
| Rodrigo Abrantes         | 201506561| up201506561@fe.up.pt                |

----
## Installation and Execution
In order to execute or program the following steps must be made:
- Install and and run SICStus Prolog
- Go to File > Working Directory and navigate to the  _src_  folder where you downloaded the code.
- Go to File > Consult and select the file  [_gekitai.pl_](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/gekitai.pl).
- Alternatively to the last 2 steps, go to File > load and select the file gekitai.pl on the src folder.
- Type  `play.`  into the SICStus console and the game will start.

## Gekitai
- Game description:

Gekitai is a 2-person strategy board game. It is played on a 6x6 grid with a total of 16 pieces, 8 for each side (black or red). On their turn, each played places one of it's pieces on any open space of the board (squares not occupied by either a black or a red piece). When a new piece is placed, it causes the other pieces adjacent to it to be pushed or repelled away, moving it one piece outwards or off the board if there's no space for the said piece. If there are 2 or more lined-up pieces a newly placed piece cannot push them. 
In order to win the game, a player has to either line up 3 of their pieces in a row or have all 8 of their pieces on the board at the same time.

[Source](https://boardgamegeek.com/boardgame/295449/gekitai)

## Game Logic
### GameState representation
#### Board
To represent the board we used a list of lists, also known as a matrix. Each one of the internal lists represent a row of the board and each cell can hold the values of empty, 'Black' and 'Red', where 'Black' represents player's 1 marker and 'Red' player's 2 marker.
#### Player
In order to know which player's turn it is, we use an atom `state`that records the current player and the current board, being updated at the end of every game loop iteration.
The current player to move is displayed as Black or Red in the `display_game(Player, GameState)`predicate.
#### Game Loop
In gekitai, the first move is always done by black, proceeded by a move by red with both players taking turns in a loop until the end of the game. The game loop is processed the following way:

- Firstly, the predicate `initial(GameState)`is called initializing an empty board followed by `assert(state(1, GameState))`which asserts the current board state as GameState and the current player as black.
- We enter the loop section, having the board displayed on the screen with the predicate `display_game(Player, Board)`.
- A predicate to make the next move is called followed by the `changePlayer(Player, NextPlayer)`predicate and a new assertion, `state(NextPlayer, NewBoard)`.
- Finally, the predicate `game_over(NewBoard, Winner)`is called to verify if any player won, if the loop ends and the `endGame(Winner)` predicate is called, if not, we go back to the beginning of the loop section.
#### Possible GameStates
Here are some possible gamestates through the game:
- Initial State: 
```
initialBoard([
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty]
]).
```
- Intermediate State:
```
IntermediateBoard([
['Black', 'Black', empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, 'Red', empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty]
]).
```
-   Final State:
```
FinalBoard([
['Black', 'Black', 'Black', empty, empty, empty],
['Red', 'Red', empty, empty, empty, empty],
[empty, empty, 'Red', empty, empty, empty],
[empty, empty, empty, 'Black', empty, empty],
[empty, empty, empty, empty, empty, empty],
[empty, empty, empty, empty, empty, empty]
]).
```

### GameState Visualization
#### Board - [display.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/display.pl)
To print the game's board we used the predicates: 
`printBoard(X)` - which prints the column's indexes and calls `printMatrix`; 
`printMatrix([H|T], X)`- which prints the number index of the specific row and calls `printLine` and recursively calls itself; 
`printLine([H|T])` - displays the entire row.
For a more user friendly display, having values empty, 'Black' and 'Red' converted to **.** , **O** and **X** respectively using the predicate symbol.
```
symbol(empty, S):-  S= ' '.
symbol(1, S):-  S= 'Black'.
symbol(2, S):-  S= 'Red'.
symbol('Black', S):-  S= 'X'.
symbol('Red', S):-  S= 'O'.
```
- Initial State

![initialBoard](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/initialBoard.png)
- Intermediate State

![IntermediateBoard](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/IntermediateBoard.png)
- Final State

![FinalBoard](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/FinalBoard.png)
#### Menus - [menu.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/menu.pl)
When starting the game, the application displays a **mainMenu**, with 3 game modes available:
-   Player vs Player (PvP)
-   Player vs Computer (PvC)
-   Computer vs Computer (CvC)

![mainMenu](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/mainMenu.png)
If the chose game mode envolves a computer, the user is prompted to a **secondaryMenu** where they can select the AI's difficulty level.

![secondaryMenu](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/secondMenu.png)
#### Input validation - [input.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/input.pl)
- In-Game validation
During the game, each player is asked to play by giving the value of the row and column where they want to move the piece `readColumn(NewColumn)` and `readRow(NewRow)`. These values are then checked by the predicates `checkRow(Row, NextRow)` and `checkColumn(Column, NextColumn)`that assign the values selected by the user if the move is valid, if not, the user is asked for a new move again.

![inputError](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/img/inputError.png)
- Menu validation
In the menus, the user is asked to choose a mode by the predicate `readMenuChoice` and the  validation of the input is made by the `checkOption(MenuChoice)`and `checkOption2(MenuChoice)`predicates. If the input is valid the option chosen is then passed to one of the `makeOption`predicates.

### Valid moves - [utils.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/utils.pl)
In order to obtain the list of all possible moves that a player can make, the predicate `valid_moves(+GameState, +Player, -ListOfMoves)` was implemented. This predicate uses the predicate  `findall(Template, Goal, Bag)`  to get all the solutions for the auxiliary predicate  `possible_move(Player, Board, Row, Col, UpdatedBoard)`. This predicate iterates through all the board, placing the Player's piece on in any empty square. By calling this helper predicate inside the findall predicate, we get a list of all the valid moves that can be made with the current game state. 
This module is used for the AI section, so that the program can evaluate all possible boards and choose the best one to play.
### Move Execution - [play.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/play.pl) and [utils.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/utils.pl)
The execution of every human move is finalized using the predicate`move(+GameState, +Move, -NewGameState)`. Initially, when prompting a player to make a move, the program calls the `makeMove(Player, State, NewState)` predicate, which reads the user input and validates it using the method described on the **Input validation** section of this report. After getting the desired position for the next piece, the program calls the move predicate, the argument **Move** is a list which contains the Row, Column and the current Player. This predicate will then call the `updateMove(GameState, NewRow, NewColumn, S, TempState)` updating the matrix with the new move, followed by the `repulsions(NewRow, NewColumn, TempState, NewGameState)`predicate which updates the board with the repulsions caused by the last move. 
### Game Over - [play.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/play.pl) and [utils.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/utils.pl)
At the end of every game loop the predicate `game_over(NewBoard, Winner)`is called in order to check if any of the players won the game. If so, the predicate will succeed, ending the game loop, otherwise the game loop will continue. The game_over predicate calls, for both players, the `checkWin(Board, Player)`predicate which, himself, calls 2 different predicates:

- `checkPieces(Row, Col, Piece, Board, No)`, used to check if the player won the game with 8 pieces on the board;
- `checkThree(Row, Col, Board, Piece)`, iterating the matrix looking for a three in a row, having success if it finds one.
### Board Evaluation - [utils.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/utils.pl)
Considering that gekitai doesn't have a point system of it's own, we had to find a way to implement one ourselves. This calculation is done by the predicate `value(+GameState, +Player, -Value)`. This predicate attributes extra points to a board (Points2) if the move proposed gives the win to the Player, allowing that winning moves will always be prioritized on the `findBestBoards(HighScore, [H|T], BestBoards, FinalBestBoards)`predicate that we will talk about. This predicate also calls `pointsperPiecesOnBoard(Board, Row, Column, Player, InicialPoints, FinalPoints)` which calculates the amount of pieces in the board for player **Player** returning in **FinalPoints** the total amount of points accumulated. The final value of the board will then be **FinalPoints + Points2**
### Computer Move - [utils.pl](https://github.com/MiguelAMS/FEUP-PLOG/blob/master/TP1/src/utils.pl)
All the computer moves are processed by the `choose_move(+GameState, +Player, +Level, -Move)`predicate. This predicate will have a different behavior depending on the value of Level.

- If **Value** is 1, we are playing on the easiest difficulty, so all the predicate does is generate all possible moves using the `valid_moves(+GameState, +Player, -ListOfMoves)`predicate previously mentioned, choosing a random one from **ListOfMoves** using the predicate `choose(List, ChosenList)`
- If **Value** is 2, after the valid_moves call and before the choose_call, **choose_move** calls the predicate `findBestMove(ListBoards, Player, BestBoards)` which returns in **BestBoards** the boards with the highest value according to our board evaluation technique talked about previously. **findBestMove** calls the predicates `allBoardsPoints([H|T], ListBoards, Player, FinalListOfBoards)`, which uses the predicate `value(GameState, Player, Value)` to give each board points. Afterwards the predicate `findBestBoards(HighScore, [H|T], BestBoards, FinalBestBoards)` is called selecting only the boards with the highest points.
This way, the only boards sent to the **choose** predicate call are the ones that give the computer the highest winning chances.
### Conclusions 
At first, the development of this project gave us some difficulties since Prolog is a brand new programming language to us. However, working on the project through the weeks helped our understanding of the language's syntax and made us more confortable at working with it. With that being said, the development of this project significantly improved our understanding of a logic based programming language such as Prolog.
In regards to any bugs or known issues we believe there are none, having all required features implemented correctly.
To conclude, concerning possible improvements, we could've done a better job with the game's AI (Artificial Intelligence), developing a better `value(+GameState, +Player, -Value)`predicate, that not only uses the amount of pieces on the board or a possible win threat but also the possibility of creating a 2 in a row (giving us winning chances in the next turn), etc.
### Bibliography
- [SICStus Prolog User's Manual](https://sicstus.sics.se/sicstus/docs/latest4/pdf/sicstus.pdf)
- [SWI-Prolog](https://www.swi-prolog.org/)
- Moodle slides