:-
    use_module(library(clpfd)).

:-
    reconsult('utils.pl').

max_ocupation(20).

% restrict
restrict(Classes, Students, Solution) :-            get_vars(Solution, Vars),   write(Vars), nl,
    restrict_students_options(Students, Solution),                              write(Vars), nl,
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
    max_ocupation(Max),
    restrict_ocupation(Classes, Max).

restrict_ocupation([], _) :- !.
restrict_ocupation([Class|Classes], Max) :-
    count(Class, [Class|Classes], #=, N),
    N #=< Max,
    restrict_ocupation(Classes, Max).
