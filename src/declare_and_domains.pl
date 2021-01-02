% This is the first module.
% It declares the solution structure and sets its variables' domains.

:-
    use_module(library(clpfd)).

:-
    use_module(library(lists)).

% declare_and_domains(Classes, Students, Solution)
% declare Solution and set the domain of those variables.
declare_and_domains(_, [], []) :- !.
declare_and_domains(Classes, [student(ID, _Grade, S, _O)|Students], [solution(ID, A)|Solution]) :-
    length(S, L), length(A, L),
    domains(Classes, S, A),
    declare_and_domains(Classes, Students, Solution).

% domains(Classes, StudentSubjects, AssignedClasses)
% Establish domain for AssignedClasses.
% For instance, domains(Classes, [1], [X]) means the domain of X is the range of classes
% that subject 1 has.
domains(_, [], []) :- !.
domains(Classes, [Subject|StudentSubjects], [AssignedClass|AssignedClasses]) :-
    !,
    subject_classes(Classes, Subject, List),
    max_member(Max, List),
    min_member(Min, List),
    domain([AssignedClass], Min, Max),
    domains(Classes, StudentSubjects, AssignedClasses).

% subject_has_N_classes(+Classes, +Subject, -N)
% Given the list of all classes Classes,
% subject Subject has N classes.
subject_classes(Classes, Subject, N) :-
    setof(Class, member(class(Subject, Class, _), Classes), N).
