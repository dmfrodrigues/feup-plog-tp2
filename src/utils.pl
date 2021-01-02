:-
    use_module(library(clpfd)).

restrict_equal_arrays([], []) :- !.
restrict_equal_arrays([X1|L1], [X2|L2]) :-
    X1 #= X2,
    restrict_equal_arrays(L1, L2).
