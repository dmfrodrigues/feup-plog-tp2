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

:-
    Classes = [
        class(1, 1, []),
        class(1, 2, []),
        class(2, 1, []),
        class(2, 2, []),
        class(2, 3, [])
    ],
    Students = [
        student(201806429, 18, [1,2], [[1, 2], [2, 3], [1, 3]]),
        student(201800170, 18, [1,2], [[2, 1], [3, 2], [3, 1]])
    ],
    solve(Classes, Students, Solution),
    write(Solution).
