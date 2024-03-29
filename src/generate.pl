:-
    use_module(library(random)),
    use_module(library(lists)),
    use_module(library(samsort)).

:-
    reconsult('utils.pl'),
    reconsult('declare_and_domains.pl').

% generate(+NSubjects, +NClasses, +NStudents, -Classes, -Students)
generate(NSubjects, NClasses, NStudents, Classes, Students) :-
    generate_classes(NSubjects, NClasses, Classes),
    generate_students(Classes, NStudents, Students),
    true.

% generate_students(+Classes, +NStudents, -Students) 

generate_students(_, 0, []):- !.
generate_students(Classes, NStudents, [student(ID, Grade, Subjects, Options)|T]) :-
    ID = NStudents,
    random(1, 20, Grade),
    random(1, 5, NSubjects),
    random(3, 6, NOptions),
    findAllSubjects(Classes, TotalSubjects),
    generate_subjects(TotalSubjects, NSubjects, Subjects),
    generate_options(Classes, Subjects, NOptions, Options),
    N1 is NStudents - 1,
    generate_students(Classes, N1, T).


findAllSubjects([], []).
findAllSubjects([class(Subject, _, _)|CT], [Subject | ST]):-
    findAllSubjects(CT, ST).

generate_subjects([], _, []):- !.   
generate_subjects(_, 0, []):- !.
generate_subjects(Subjects, NSubjects, [Subject|T]):-
    random_member(Subject, Subjects), 
    delete(Subjects, Subject, RSubjects),
    N1 is NSubjects - 1,
    generate_subjects(RSubjects, N1, T).

get_option(_, [], []).
get_option(Classes, [Subject|ST], [Class|OT]):-
    subject_classes(Classes, Subject, SubjClasses),
    random_member(Class, SubjClasses),
    get_option(Classes, ST, OT).

generate_options(_, _, 0, []):- !.
generate_options(Classes, Subjects, NOptions, [Option|T]) :-
    get_option(Classes, Subjects, Option),
    N1 is NOptions - 1,
    generate_options(Classes, Subjects, N1, T).


%generate_classes
generate_classes(NSubjects, NClasses, Classes) :-
    get_random_sizes_adding_up(NSubjects, NClasses, Answer),
    generate_classes_cycle(Answer, 1, 1, Classes).

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
