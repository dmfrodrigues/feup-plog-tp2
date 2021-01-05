write_solution(Solution) :-
    format("Student ID     Class of 1st subject     Class of 2nd subject     ...~n", []),
    write_solution_cycle(Solution).

write_solution_cycle([]) :- !.
write_solution_cycle([solution(ID, Allocation)|Solution]) :-
    format("~d      ", ID),
    write_sol(solution(ID, Allocation)),
    format("~n", []),
    write_solution_cycle(Solution).

write_sol(solution(_ID, [])) :- !.
write_sol(solution(ID, [A|Allocation])) :-
    format("~d                        ", A),
    write_sol(solution(ID, Allocation)).
