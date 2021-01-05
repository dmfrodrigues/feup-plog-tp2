:-
    use_module(library(clpfd)).

:-
    reconsult('declare_and_domains.pl'),
    reconsult('restrictions.pl'),
    reconsult('generate.pl'),
    reconsult('evaluate.pl'),
    reconsult('display.pl'),
    reconsult('../stats/stats.pl').

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
solve(Classes, Students, Solution) :- solve(Classes, Students, [], Solution).
solve(Classes, Students, Options, Solution) :-
    declare_and_domains(Classes, Students, Solution),       % Declare solution array
    get_vars(Solution, Vars),
    % format(user_error, "Going to restrict~n", []),
    restrict(Classes, Students, Solution),
    % format(user_error, "Going to evaluate~n", []),
    evaluate(Classes, Students, Solution, Value),
    % format(user_error, "Going to label~n", []),
    \+(ground(Vars)), \+(ground(Value)),
    % format(user_error, "Vars  = ", []), write(user_error, Vars ), format(user_error, "~n", []),
    % format(user_error, "Value = ", []), write(user_error, Value), format(user_error, "~n", []),
    labeling([best, minimize(Value)|Options], [Value|Vars]),
    % format(user_error, "Labelled~n", []),
    % format(user_error, "Value=", []), write(user_error, Value), format(user_error, "~n", []),
    true.

get_vars([], []) :- !.
get_vars([solution(_, Vars1)|Solution], Vars) :-
    get_vars(Solution, Vars2),
    append(Vars1, Vars2, Vars).

:-
    Classes = [
        class(1, 1, []),
        class(1, 2, []),
        class(2, 3, []),
        class(2, 4, []),
        class(2, 5, [])
    ],
    Students = [
        student(201800170, 17, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806429, 18, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806430, 18, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806431, 18, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806432, 18, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806433, 18, [1,2], [[1, 3], [1, 4], [1, 5]]),
        student(201806434, 18, [1,2], [[1, 3], [1, 4], [1, 5]])
    ],
    % generate(10, 50, 150, Classes, Students),
    format('Option         ~15+,', []),                                                            print_statistics_header,
    format('(nothing)      ~15+,', []), solve(Classes, Students, [                  ], Solution1), print_statistics,
    format('leftmost       ~15+,', []), solve(Classes, Students, [leftmost          ], Solution2), print_statistics,
    format('min            ~15+,', []), solve(Classes, Students, [min               ], Solution3), print_statistics,
    format('max            ~15+,', []), solve(Classes, Students, [max               ], Solution4), print_statistics,
    format('ff             ~15+,', []), solve(Classes, Students, [ff                ], Solution5), print_statistics,
    format('anti_first_fail~15+,', []), solve(Classes, Students, [anti_first_fail   ], Solution6), print_statistics,
    format('occurrence     ~15+,', []), solve(Classes, Students, [occurrence        ], Solution7), print_statistics,
    format('ffc            ~15+,', []), solve(Classes, Students, [ffc               ], Solution8), print_statistics,
    format('max_regret     ~15+,', []), solve(Classes, Students, [max_regret        ], Solution9), print_statistics,
    % write_solution(Solution),
    true.
