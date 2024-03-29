:-
    use_module(library(clpfd)).

:-
    reconsult('utils.pl').

max_ocupation(20).

% restrict
restrict(_Classes, Students, Solution) :-
    restrict_students_options(Students, Solution),
    restrict_classes_capacity(Solution),
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
    student(ID, _Grade, _Subjects, Options),
    solution(ID, Allocation)
) :-
    restrict_array_in_list_of_arrays(Allocation, Options, R1),
    restrict_domain(Allocation, 0, 0, R2),
    (R1 #= 1 #\/ R2 #= 1).

% Restrict each class to the maximum capacity
restrict_classes_capacity(Solution) :-
    get_vars(Solution, Classes),
    max_ocupation(Max),                            
    restrict_ocupation(Classes, Max).

restrict_ocupation([], _) :-             !.
restrict_ocupation([Class|Classes], Max) :-        
    restrict_count(Class, [Class|Classes], N),       
    N #=< Max,                                    
    restrict_ocupation(Classes, Max).
