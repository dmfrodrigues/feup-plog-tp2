:-
    use_module(library(clpfd)).

:-
    reconsult('declare_and_domains.pl'),
    reconsult('restrictions.pl'),
    reconsult('generate.pl').

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
    format("Got vars~n", []),
    evaluate(Classes, Students, Solution, Value),
    format("About to label~n", []),
    minimize(labeling([best], Vars), Value),
    write(Value), nl,
    true.

number_of_even_in_class(_Class, [], 0).
number_of_even_in_class(Class, [solution(ID, Allocation)|RSolution], N):-
    member(Class, Allocation),
    0 is mod(ID, 2),
    number_of_even_in_class(Class, RSolution, N1),
    N is N1 + 1.
number_of_even_in_class(Class, [solution(_, _)|RSolution], N):-
    number_of_even_in_class(Class, RSolution, N).

number_of_odd_in_class(_Class, [], 0).
number_of_odd_in_class(Class, [solution(ID, Allocation)|RSolution], N):-
    member(Class, Allocation),
    1 is mod(ID, 2),
    number_of_odd_in_class(Class, RSolution, N1),
    N is N1 + 1.
number_of_odd_in_class(Class, [solution(_, _)|RSolution], N):-
    number_of_odd_in_class(Class, RSolution, N).

class_size(_, [], 0).
class_size(Class, [solution(_ID, Allocation)|T], N):-
    member(Class, Allocation),
    class_size(Class, T, N1),
    N is N1 + 1.
class_size(Class, [solution(_ID, _Allocation)|T], N):-
    class_size(Class, T, N).


all_classes_of_subject([], _, []).
all_classes_of_subject([class(Subject, Class, _)|T1], Subject, [Class|T2]):-
    all_classes_of_subject(T1, Subject, T2).
all_classes_of_subject([class(Subject, _Class, _)|T1], Subject, NClasses):-
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
    Average is Sum/TotalSubjectClasses
    .

evaluate_classes(_AllClasses, [], _Solution, 0) :- format("L92~n", []).
evaluate_classes(AllClasses, [Class|T], Solution, Value):-  format("L93~n", []),
    Class = class(Subject, ID, _),                          format("L94~n", []),
    number_of_odd_in_class(ID, Solution, Odds),             format("L95~n", []),
    number_of_even_in_class(ID, Solution, Evens),           format("L96~n", []),
    class_size(Class, Solution, ClassSize),                 format("L97~n", []),
    avg_class_size_in_subject(AllClasses, Subject, Solution, Average),  format("L98~n", []),
    Y is ClassSize/Average,                                 format("L99~n", []),

    NValue1 is 0.1*(Odds-Evens)**2 + 0.25*(1-Y)**2,         format("L101~n", []),

    evaluate_classes(AllClasses, T, Solution, NValue2),     format("L103~n", []),
    Value is NValue1 + NValue2                          ,   format("L104~n", []).

options_in_allocation([Option|T], Allocation):-
    member(Option, Allocation).
options_in_allocation([Option|T], Allocation):-
    options_in_allocation(T, Allocation).

check_allocation(student(ID1, _G, _S, Options), [solution(ID2, _Allocation)|T]):-
    ID1 \= ID2,
    check_allocation(student(ID1, _G, _S, Options), T).
check_allocation(student(ID, _G, _S, Options), [solution(ID, Allocation)|_T]):-
    !,
    options_in_allocation(Options, Allocation)
    .

evaluate_allocation([], _, 0).
evaluate_allocation([Student|T], Solution, Value):-
    (
    (check_allocation(Student, Solution)) -> 
        S is 1; S is -1
    ),
    NValue1 is 0.125*S,
    evaluate_allocation(T, Solution, NValue2),
    Value is NValue1 + NValue2
    .

evaluate(Classes, Students, Solution, Value):-          format("L131~n", []),
    evaluate_classes(Classes, Classes, Solution, C),    format("L132~n", []),
    % evaluate_allocation(Students, Solution, S),
    Value is C
    .

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
        student(201800170, 17, [1,2], [[2, 3], [1, 4], [1, 3]]),
        student(201806429, 18, [1,2], [[1, 4], [2, 5], [1, 5]])
    ],
    % generate(10, 50, 150, Classes, Students),
    solve(Classes, Students, Solution),
    write_solution(Solution),
    print_statistics_header,
    print_statistics,
    true.
