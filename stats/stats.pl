print_statistics_header :- format('Resumptions~11+,Entailments~12+,Prunings~9+,Backtracks~11+,Constraints~12+,Total_runtime (ms)~19+~n', []).
print_statistics :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d~11+,~d~12+,~d~9+,~d~11+,~d~12+,~d~14+~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime]).
