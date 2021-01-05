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
solve(Classes, Students, Options, Solution) :- solve(Classes, Students, Options, Solution, _).
solve(Classes, Students, Options, Solution, Value) :-
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
