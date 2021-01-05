print_statistics_header :-
    format('Resumptions~40+,Entailments~15+,Prunings~15+,Backtracks~15+,Constraints~15+,Total_runtime (ms)~25+~n', []),
    statistics(total_runtime, _).
print_statistics_header(_) :-
    format('Resumptions~40+,Entailments~15+,Prunings~15+,Backtracks~15+,Constraints~15+,Total_runtime (ms)~25+,Value~10+~n', []),
    statistics(total_runtime, _).
print_statistics :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d~40+,~d~15+,~d~15+,~d~15+,~d~15+,~d~25+~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime]).
print_statistics(Value) :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d~40+,~d~15+,~d~15+,~d~15+,~d~15+,~d~25+,~d~10+~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime, Value]).

repeatN(0, _) :- !.
repeatN(N, T) :- T, N1 is N-1, repeatN(N1, T).
