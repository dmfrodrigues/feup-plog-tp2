:-
    use_module(library(clpfd)).

restrict_equal_arrays([], [], R) :- R #= 1.
restrict_equal_arrays([X1|L1], [X2|L2], R) :-
    restrict_equal_arrays(L1, L2, R1),
    R #<=> ((X1 #= X2) #/\ R1).

restrict_array_in_list_of_arrays(_, [], R) :- R #= 0.
restrict_array_in_list_of_arrays(L, [L1|D], R) :-
    restrict_equal_arrays(L, L1, R1),
    restrict_array_in_list_of_arrays(L, D, R2),
    R #<=> (R1 #= 1 #\/ R2 #= 1).

restrict_domain([], _, _, R) :- R #= 1.
restrict_domain([X|L], Min, Max, R) :-
    restrict_domain(L, Min, Max, R1),
    R #<=> (R1 #/\ (Min #=< X #/\ X #=< Max)).

restrict_in_list(_, [], R) :- R #= 0.
restrict_in_list(X, [X1|L], R) :-
    restrict_in_list(X, L, R1),
    R #<=> (X #= X1 #\/ R1 #= 1).

restrict_count(_, [    ], N) :- N #= 0.
restrict_count(X, [X1|L], N) :- restrict_count(X, L, N1), N #= N1 + (X #= X1).

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
