:-
    use_module(library(random)),
    use_module(library(samsort)).

:-
    reconsult('utils.pl').

% generate(+NSubjects, +NClasses, +NStudents, -Classes, -Students)
generate(NSubjects, NClasses, NStudents, Classes, Students) :-
    generate_classes(NSubjects, NClasses, Classes),
    true.

generate_classes(NSubjects, NClasses, Classes) :-
    get_random_sizes_adding_up(NSubjects, NClasses, Answer),
    generate_classes_cycle(Answer, 1, 1, Classes),
    write(Classes).

generate_classes_cycle([], _, _, []) :- !.
generate_classes_cycle([0|Answer], S, C, Classes) :- !, S1 is S+1, generate_classes_cycle(Answer, S1, C, Classes).
generate_classes_cycle([A|Answer], S, C, [class(S, C, [])|Classes]) :-
    A1 is A-1,
    C1 is C+1,
    generate_classes_cycle([A1|Answer], S, C1, Classes).

get_random_sizes_adding_up(NSubjects, NClasses, Answer) :-
    length(Tmp, NClasses),
    NSubjects1 is NSubjects+1,
    maplist(random(1, NSubjects1), Tmp),
    create_list_sequence(NSubjects, LSubjects),
    sort(LSubjects, LSubjectsSorted),
    list_create(Tmp, NSubjects, TmpLists),
    maplist(count, TmpLists, LSubjectsSorted, Answer).
