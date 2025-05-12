:- module(predicate, [find_exit/2]).

% Recognize cell values
cell(Maze, coord(R,C), Value) :-
    nth0(R, Maze, Row)
    nth0(C, Row, Value)

% Moving from one coordinate to another 
move_coord(coord(R,C), up, coord(R2, C)) :- R2 is R - 1. 
move_coord(coord(R,C), down, coord(R2,C)) :- R2 is R + 1.
move_coord(coord(R,C), left, coord(R, C2)) :- C2 is C - 1.
move_coord(coord(R,C), right, coord(R, C2)) :- C2 is C + 1. 


