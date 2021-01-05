print_statistics_header :-
    format('Resumptions,Entailments,Prunings,Backtracks,Constraints,TotalRuntime~n', []),
    statistics(total_runtime, _).
print_statistics_header(_) :-
    format('Resumptions,Entailments,Prunings,Backtracks,Constraints,TotalRuntime,Value~n', []),
    statistics(total_runtime, _).
print_statistics :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d,~d,~d,~d,~d,~d~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime]).
print_statistics(Value) :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d,~d,~d,~d,~d,~d,~d~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime, Value]).
print_statistics(Value, N) :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    Total_runtimeN is Total_runtime/N,
    format('~d,~d,~d,~d,~d,~d,~d~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtimeN, Value]).

repeatN(0, _) :- !.
repeatN(N, T) :- T, N1 is N-1, repeatN(N1, T).
