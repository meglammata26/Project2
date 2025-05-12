:- module(predicate, [find_exit/2]).

% Recognize cell values
cell(Maze, coord(R,C), Value) :-
    nth0(R, Maze, Row), 
    nth0(C, Row, Value). 

% Moving from one coordinate to another 
move_coord(coord(R,C), up, coord(R2, C)) :- R2 is R - 1. 
move_coord(coord(R,C), down, coord(R2,C)) :- R2 is R + 1.
move_coord(coord(R,C), left, coord(R, C2)) :- C2 is C - 1.
move_coord(coord(R,C), right, coord(R, C2)) :- C2 is C + 1. 

% Making sure the coordinate is inside the maze
valid_coord(Maze, coord(R,C)) :-
    length(Maze, RowCount), R >= 0, R < RowCount, 
    nth0(R, Maze, Row),
    length(Row, ColCount), C >= 0, C < ColCount, 
    cell(Maze, coord(R,C), V),
    V \= w. 

% Find the start location
find_start(Maze, coord(R,C)) :-
    nth0(R, Maze, Row),
    nth0(C, Row, s).

% Follow a known path
follow_path(_, [], Coord, Coord).
follow_path(Maze, [Action|Rest], Curr, End) :-
    move_coord(Curr, Action, Next),
    valid_coord(Maze, Next),
    follow_path(Maze, Rest, Next, End).

% The main entry point 
find_exit(Maze, Actions) :-
    find_start(Maze, Start),
    ( var(Actions) -> 
        dfs(Maze, Start, [], Actions)
    ;   follow_path(Maze, Actions, Start, End), 
        cell(Maze, End, e)    
    
    ).

% DFS 
% Base case: when we reach exit 
dfs(Maze, Coord, _, []) :-
    cell(Maze, Coord, e).

% Recursive case : looking for any other possible moves
dfs(Maze, Coord, Visited, [Move|Rest]) :-
    move_coord(Coord, Move, Next),
    valid_coord(Maze, Next),
    \+ member(Next, Visited),
    dfs(Maze, Next, [Coord | Visited], Rest).

