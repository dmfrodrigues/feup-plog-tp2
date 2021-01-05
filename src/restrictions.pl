:-
    use_module(library(clpfd)).

:-
    reconsult('utils.pl').

max_ocupation(20).

% restrict
restrict(Classes, Students, Solution) :-
    restrict_students_options(Students, Solution),
    restrict_classes_capacity(Students, Solution),
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
    student(ID, Grade, Subjects, Options),
    solution(ID, Allocation)
) :-
    restrict_array_in_list_of_arrays(Allocation, Options, R1),
    restrict_domain(Allocation, 0, 0, R2),
    (R1 #= 1 #\/ R2 #= 1).

% Restrict each class to the maximum capacity
restrict_classes_capacity(Students, Solution) :-
    get_vars(Solution, Classes),
    max_ocupation(Max),                            
    restrict_ocupation(Classes, Max).

my_count(_, [    ], Value) :- Value #= 0.
my_count(X, [X1|L], Value) :- my_count(X, L, Value1), Value #= Value1 + (X #= X1).

restrict_ocupation([], _) :-             !.
restrict_ocupation([Class|Classes], Max) :-        
    my_count(Class, [Class|Classes], N),       
    N #=< Max,                                    
    restrict_ocupation(Classes, Max).
