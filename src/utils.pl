:-
    use_module(library(clpfd)).

restrict_equal_arrays([], []) :- !.
restrict_equal_arrays([X1|L1], [X2|L2]) :-
    X1 #= X2,
    restrict_equal_arrays(L1, L2).

count([], _, 0).
count([E|Es], E, N) :- !,
    count(Es, E, N1),
    N is N1+1.
count([_|Es], E, N) :-
    count(Es, E, N).

create_list_sequence(0, []) :- !.
create_list_sequence(X, [X|L]) :- X1 is X-1, create_list_sequence(X1, L).

/**
 * list_create(+X, +N, -List)
 * 
 * Create list with size N and filled with X,
 * and return it in List.
 */
list_create(X, N, List)  :- 
    length(List, N), 
    maplist(=(X), List).
