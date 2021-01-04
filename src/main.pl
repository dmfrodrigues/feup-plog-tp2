:-
    use_module(library(clpfd)).

:-
    reconsult('declare_and_domains.pl'),
    reconsult('restrictions.pl').

%   class(S, C, Times)
% Subject S has a class C which is lectured in the
% slots contained in Times.

%   student(
%       ID,
%       Grade,
%       [S1, S2, ..., SS],
%       [
%           [O11, O12, ..., O1S],
%           [O21, O22, ..., O2S],
%           ...,
%           [ON1, ON2, ..., ONS]
%       ]
%   )
% Student with id=ID has grade Grade, is enrolled in subjects S1, S2, ..., SS
% and his options for classes at S1, S2, ..., SS are
% [O11, O12, ..., O1S], [O21, O22, ..., O2S], etc.

%   solution(ID, [A1, A2, ..., AS])
% Student with id=ID is assigned to classes A1, A2, ..., AS


% solve(+Subjects, +Students, -Solution)
% Finds a solution for the given Subjects and Students.
solve(Classes, Students, Solution) :-
    declare_and_domains(Classes, Students, Solution),       % Declare solution array
    restrict(Classes, Students, Solution),
    get_vars(Solution, Vars),
    labeling([], Vars).

get_vars([], []) :- !.
get_vars([solution(_, Vars1)|Solution], Vars) :-
    get_vars(Solution, Vars2),
    append(Vars1, Vars2, Vars).

% write_solution(A) :- write(A).

write_solution([]) :- !.
write_solution([solution(ID, Allocation)|Solution]) :-
    format('~d ', ID),
    write_sol(solution(ID, Allocation)),
    format('~n', []),
    write_solution(Solution).

write_sol(solution(_ID, [])) :- !.
write_sol(solution(ID, [A|Allocation])) :-
    format('~d ', A),
    write_sol(solution(ID, Allocation)).

print_statistics_header :- format('Resumptions~11+,Entailments~12+,Prunings~9+,Backtracks~11+,Constraints~12+,Total_runtime~14+~n', []).
print_statistics :-
    fd_statistics(resumptions, Resumptions),
    fd_statistics(entailments, Entailments),
    fd_statistics(prunings   , Prunings   ),
    fd_statistics(backtracks , Backtracks ),
    fd_statistics(constraints, Constraints),
    statistics(total_runtime, [_, Total_runtime]),
    format('~d~11+,~d~12+,~d~9+,~d~11+,~d~12+,~d~14+~n', [Resumptions, Entailments, Prunings, Backtracks, Constraints, Total_runtime]).

:-
    Classes = [
        class(1, 1, []),
        class(1, 2, []),
        class(2, 3, []),
        class(2, 4, []),
        class(2, 5, [])
    ],
    Students = [
        student(201800170, 17, [1,2], [[2, 3], [1, 4], [1, 3]]),
        student(201806429, 18, [1,2], [[1, 4], [2, 5], [1, 5]])
    ],
    solve(Classes, Students, Solution),
    write_solution(Solution),
    print_statistics_header,
    print_statistics.
