:-
    reconsult('src/main.pl').

:-
    Classes = [
        class(1, 1, []),
        class(1, 2, []),
        class(2, 3, []),
        class(2, 4, []),
        class(2, 5, [])
    ],
    Students = [
        student(201800170, 17, [1,2], [[1,3], [1,4], [1,5]]),
        student(201806429, 18, [1,2], [[1,3], [1,4], [1,5]])
    ],
    solve(Classes, Students, [], Solution, Value),
    format("Value=~d~n", [Value]),
    write_solution(Solution),
    true.
