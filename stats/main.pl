:-
    reconsult('../src/generate.pl'),
    reconsult('../src/main.pl'),
    reconsult('stats.pl').

stats_dimension :-
    print_statistics_header,
    generate(10, 50,  10, Classes01, Students01), solve(Classes01, Students01, Solution01), print_statistics,
    generate(10, 50,  20, Classes02, Students02), solve(Classes02, Students02, Solution02), print_statistics,
    generate(10, 50,  30, Classes03, Students03), solve(Classes03, Students03, Solution03), print_statistics,
    generate(10, 50,  40, Classes04, Students04), solve(Classes04, Students04, Solution04), print_statistics,
    generate(10, 50,  50, Classes05, Students05), solve(Classes05, Students05, Solution05), print_statistics,
    generate(10, 50,  60, Classes06, Students06), solve(Classes06, Students06, Solution06), print_statistics,
    generate(10, 50,  70, Classes07, Students07), solve(Classes07, Students07, Solution07), print_statistics,
    generate(10, 50,  80, Classes08, Students08), solve(Classes08, Students08, Solution08), print_statistics,
    generate(10, 50,  90, Classes09, Students09), solve(Classes09, Students09, Solution09), print_statistics,
    generate(10, 50, 100, Classes10, Students10), solve(Classes10, Students10, Solution10), print_statistics,
    true.

stats_order :-
    print_statistics_header,
    generate(10, 50,  50, Classes, Students),
    solve(Classes, Students, Solution01, [leftmost       ]), print_statistics,
    solve(Classes, Students, Solution02, [min            ]), print_statistics,
    solve(Classes, Students, Solution03, [max            ]), print_statistics,
    solve(Classes, Students, Solution04, [ff             ]), print_statistics,
    solve(Classes, Students, Solution05, [anti_first_fail]), print_statistics,
    solve(Classes, Students, Solution06, [occurence      ]), print_statistics,
    solve(Classes, Students, Solution07, [ffc            ]), print_statistics,
    solve(Classes, Students, Solution08, [max_regret     ]), print_statistics,
    true.

stats_selection :-
    print_statistics_header,
    generate(10, 50,  50, Classes, Students),
    solve(Classes, Students, Solution01, [step  ]), print_statistics,
    solve(Classes, Students, Solution02, [enum  ]), print_statistics,
    solve(Classes, Students, Solution03, [bisect]), print_statistics,
    solve(Classes, Students, Solution04, [median]), print_statistics,
    solve(Classes, Students, Solution05, [middle]), print_statistics,
    true.

