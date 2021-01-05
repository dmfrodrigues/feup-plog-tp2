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
solve(Classes, Students, Solution) :-
    declare_and_domains(Classes, Students, Solution),       % Declare solution array
    get_vars(Solution, Vars),
    format(user_error, "Going to restrict~n", []),
    restrict(Classes, Students, Solution),
    format(user_error, "Going to evaluate~n", []),
    evaluate(Classes, Students, Solution, Value),
    format(user_error, "Going to label~n", []),
    \+(ground(Vars)), \+(ground(Value)),
    format(user_error, "Vars  = ", []), write(user_error, Vars ), nl,
    format(user_error, "Value = ", []), write(user_error, Value), nl,
    labeling([minimize(Value)], [Value|Vars]),
    format(user_error, "Labelled~n", []),
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
    solve(Classes, Students, Solution),
    write_solution(Solution),
    print_statistics_header,
    print_statistics,
    true.
