:-
    use_module(library(clpfd)).

:-
    reconsult('utils.pl').

number_of_even_in_class(_Class, [], N) :- N #= 0.
number_of_even_in_class(Class, [solution(ID, Allocation)|RSolution], N):-
    restrict_in_list(Class, Allocation, R),
    number_of_even_in_class(Class, RSolution, N1),
    N #= N1 + (R #= 1 #/\ mod(ID, 2) #= 0).
number_of_even_in_class(Class, [solution(_, _)|RSolution], N):-
    number_of_even_in_class(Class, RSolution, N).

number_of_odd_in_class(_Class, [], N) :- N #= 0.
number_of_odd_in_class(Class, [solution(ID, Allocation)|RSolution], N):-
    restrict_in_list(Class, Allocation, R),
    number_of_odd_in_class(Class, RSolution, N1),
    N #= N1 + (R #= 1 #/\ mod(ID, 2) #= 1).

class_size(_, [], N) :- N #= 0.
class_size(class(_, ID, _), [solution(_ID, Allocation)|T], N):-
    restrict_in_list(ID, Allocation, R),
    class_size(Class, T, N1),
    N #= N1 + (R #= 1).

all_classes_of_subject([], _, []).
all_classes_of_subject([class(Subject, Class, _)|T1], Subject, [Class|T2]):-
    all_classes_of_subject(T1, Subject, T2).
all_classes_of_subject([class(_S1, _Class, _)|T1], Subject, NClasses):-
    all_classes_of_subject(T1, Subject, NClasses)
    .

sum_classes([], _, 0).
sum_classes([Class|T], Solution, Sum):-
    class_size( Class, Solution, ClassSize),
    sum_classes(T, Solution, NSum),
    Sum is NSum + ClassSize.

avg_class_size_in_subject(Classes, Subject, Solution, Average):-
    all_classes_of_subject(Classes, Subject, SubjectClasses),
    sum_classes(SubjectClasses, Solution, Sum),
    length(SubjectClasses, TotalSubjectClasses),
    (TotalSubjectClasses == 0 -> Average is 0 ; Average is Sum/TotalSubjectClasses)
    .

evaluate_classes(_AllClasses, [], _Solution, Value) :- Value #= 0.
evaluate_classes(AllClasses, [Class|T], Solution, Value):-
    Class = class(Subject, ID, _),
    number_of_odd_in_class(ID, Solution, Odds),
    number_of_even_in_class(ID, Solution, Evens),
    class_size(Class, Solution, ClassSize),
    avg_class_size_in_subject(AllClasses, Subject, Solution, Average),

    NValue1 #= 1*(Odds-Evens)*(Odds-Evens) + 2*(ClassSize-Average)*(ClassSize-Average),

    evaluate_classes(AllClasses, T, Solution, NValue2),
    Value #= NValue1 + NValue2.

check_allocation(student(ID, _Grade, _Subjects, Options), Solution, R):-
    findall(solution(ID, A), member(solution(ID, Allocation), Solution), [solution(ID, Allocation)]),
    restrict_array_in_list_of_arrays(Allocation, Options, R).

evaluate_allocation([], _, Value) :- Value #= 0.
evaluate_allocation([Student|T], Solution, Value):-
    check_allocation(Student, Solution, R),
    NValue1 #= 1*(1-2*R),
    evaluate_allocation(T, Solution, NValue2),
    Value #= NValue1 + NValue2.

evaluate(Classes, Students, Solution, Value):-
    evaluate_classes(Classes, Classes, Solution, C),
    evaluate_allocation(Students, Solution, S),
    Value #= C + S.
