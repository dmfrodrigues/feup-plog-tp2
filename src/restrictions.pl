:-
    use_module(library(clpfd)).

:-
    reconsult('utils.pl').

max_ocupation(20).

% restrict
restrict(Classes, Students, Solution) :-            get_vars(Solution, Vars),   write(Vars), nl,
    % restrict_students_options(Students, Solution),                              write(Vars), nl,
    restrict_classes_capacity(Students, Solution),                              write(Vars), nl,
    true. 

% restrict_students_options(+Students, +Solution)
% 
restrict_students_options([], []) :- !.
restrict_students_options(
    [Student|Students],
    [Sol|Solution]
) :-
    restrict_student_options(Student, Sol),
    restrict_students_options(Students, Solution).    

% Apply restriction:
% - A student is either completely allocated to one of his/her chosen schedules,
% or not allocated at all.
restrict_student_options(
    student(ID, Grade, Subjects, [Option|Options]),
    solution(ID, Allocation)
) :-
    restrict_equal_arrays(Allocation, Option)
    #\/
    restrict_student_options(
        student(ID, Grade, Subjects, Options),
        solution(ID, Allocation)
    )
    #\/
    domain(Allocation, 0, 0).

% Restrict each class to the maximum capacity
restrict_classes_capacity(Students, Solution) :-
    get_vars(Solution, Classes),
    max_ocupation(Max),                             format("L44~n", []),
    restrict_ocupation(Classes, Max),               format("L45~n", []).

my_count(_, [], 0) :- !.
my_count(X, [X|L], N) :- !, my_count(X, L, N1), N is N1+1.
my_count(X, [_|L], N) :- my_count(X, L, N).

restrict_ocupation([], _) :-                        format("L47~n", []), !.
restrict_ocupation([Class|Classes], Max) :-         format("L48~n", []),
    write([Class|Classes]),nl,
    my_count(Class, [Class|Classes], N),            format("L49~n", []),
    N #=< Max,                                      format("L50~n", []),
    restrict_ocupation(Classes, Max),               format("L51~n", []).
