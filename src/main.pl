:-
    use_module(library(clpfd)).

:-
    reconsult('declare_and_domains.pl'),
    reconsult('restrictions.pl'),
    reconsult('generate.pl'),
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
    get_vars(Solution, Vars), write(Vars), nl,
    format("Going to restrict~n", []),
    restrict(Classes, Students, Solution),
    write(Vars), nl,
    format("Going to evaluate~n", []),
    evaluate(Classes, Students, Solution, Value),
    format("About to label~n", []),
    write(Vars), nl,
    \+(ground(Vars)), \+(ground(Value)),
    format("L45~n", []),
    labeling([], Vars),
    format("L47~n", []),
    true.

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

evaluate(Classes, Students, Solution, Value):-          get_vars(Solution, Vars),   format("L125, ", []), write(Vars), nl,
    evaluate_classes(Classes, Classes, Solution, C),                                format("L126, ", []), write(Vars), format(", ", []), write(C), nl,
    evaluate_allocation(Students, Solution, S),                                     format("L127, ", []), write(Vars), format(", ", []), write(S), nl,
    Value #= C + S.

get_vars([], []) :- !.
get_vars([solution(_, Vars1)|Solution], Vars) :-
    get_vars(Solution, Vars2),
    append(Vars1, Vars2, Vars).

% write_solution(A) :- write(A).

write_solution([]) :- !.
write_solution([solution(ID, Allocation)|Solution]) :-
    format('~d ', ID),
    write_sol(solution(ID, Allocation)),
    format('~n', []),
    write_solution(Solution).

write_sol(solution(_ID, [])) :- !.
write_sol(solution(ID, [A|Allocation])) :-
    format('~d ', A),
    write_sol(solution(ID, Allocation)).

:-
    Classes = [
        class(1, 1, []),
        class(1, 2, []),
        class(2, 3, []),
        class(2, 4, []),
        class(2, 5, [])
    ],
    Students = [
        student(201800170, 17, [1,2], [[2, 3], [2, 4], [2, 5]]),
        student(201806429, 18, [1,2], [[1, 3], [1, 4], [1, 5]])
    ],
    % generate(10, 50, 150, Classes, Students),
    solve(Classes, Students, Solution),
    write_solution(Solution),
    print_statistics_header,
    print_statistics,
    true.
