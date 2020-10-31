



# PLOG 2020/2021 - TP1

## Group T04_Gekitai2
| Name             | Number    | E-Mail             |
| ---------------- | --------- | ------------------ |
| Miguel Silva        | 201806388 | up201806388@fe.up.pt                |
| Rodrigo Abrantes         | 201506561| up201506561@fe.up.pt                |

----

## Gekitai
- Game description:
Gekitai is a 2-person abstract strategy game played on a 6x6 grid. Each player has 8 colored markers (totaling 16) and take turns placing them anywhere on any open space on the board. When placed, a marker pushes all adjacent pieces outwards one space if there is an open space for it to move to or pushes it off the board. Pieces shoved off the board are returned to the player. If there are 2 or more lined-up pieces a newly placed piece cannot push them. 
To win the game, a player has to either line up 3 of their markers in a row or have all 8 of their markers on the board.

[Source](https://boardgamegeek.com/boardgame/295449/gekitai)

## Internal representation of the game state
- Initial situation: 
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
```
   | A | B | C | D | E | F |
---|---|---|---|---|---|---|
 1 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 2 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 3 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 4 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 5 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 6 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
```
- Intermediate Situation:
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
```
   | A | B | C | D | E | F |
---|---|---|---|---|---|---|
 1 | O | O | . | . | . | . | 
---|---|---|---|---|---|---|
 2 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 3 | . | . | X | . | . | . | 
---|---|---|---|---|---|---|
 4 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 5 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 6 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
```
-   Final Situation:
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
```
   | A | B | C | D | E | F |
---|---|---|---|---|---|---|
 1 | O | O | O | . | . | . | 
---|---|---|---|---|---|---|
 2 | X | X | . | . | . | . | 
---|---|---|---|---|---|---|
 3 | . | . | X | . | . | . | 
---|---|---|---|---|---|---|
 4 | . | . | . | O | . | . | 
---|---|---|---|---|---|---|
 5 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
 6 | . | . | . | . | . | . | 
---|---|---|---|---|---|---|
```
## TO DO: