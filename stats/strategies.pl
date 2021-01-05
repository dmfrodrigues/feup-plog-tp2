:-
    reconsult('../src/main.pl').

:-
    generate(2, 5, 7, Classes, Students),
    format('Option         ,', []),                                                                                                                                                                         print_statistics_header(_),
    
    format('leftmost        & step  ,', []), solve(Classes, Students, [step  , leftmost          ], _, Value01), solve(Classes, Students, [step  , leftmost          ], _, _), solve(Classes, Students, [step  , leftmost          ], _, _), print_statistics(Value01),
    format('min             & step  ,', []), solve(Classes, Students, [step  , min               ], _, Value02), solve(Classes, Students, [step  , min               ], _, _), solve(Classes, Students, [step  , min               ], _, _), print_statistics(Value02),
    format('max             & step  ,', []), solve(Classes, Students, [step  , max               ], _, Value03), solve(Classes, Students, [step  , max               ], _, _), solve(Classes, Students, [step  , max               ], _, _), print_statistics(Value03),
    format('ff              & step  ,', []), solve(Classes, Students, [step  , ff                ], _, Value04), solve(Classes, Students, [step  , ff                ], _, _), solve(Classes, Students, [step  , ff                ], _, _), print_statistics(Value04),
    format('anti_first_fail & step  ,', []), solve(Classes, Students, [step  , anti_first_fail   ], _, Value05), solve(Classes, Students, [step  , anti_first_fail   ], _, _), solve(Classes, Students, [step  , anti_first_fail   ], _, _), print_statistics(Value05),
    format('occurrence      & step  ,', []), solve(Classes, Students, [step  , occurrence        ], _, Value06), solve(Classes, Students, [step  , occurrence        ], _, _), solve(Classes, Students, [step  , occurrence        ], _, _), print_statistics(Value06),
    format('ffc             & step  ,', []), solve(Classes, Students, [step  , ffc               ], _, Value07), solve(Classes, Students, [step  , ffc               ], _, _), solve(Classes, Students, [step  , ffc               ], _, _), print_statistics(Value07),
    format('max_regret      & step  ,', []), solve(Classes, Students, [step  , max_regret        ], _, Value08), solve(Classes, Students, [step  , max_regret        ], _, _), solve(Classes, Students, [step  , max_regret        ], _, _), print_statistics(Value08),
    nl,
    format('leftmost        & enum  ,', []), solve(Classes, Students, [enum  , leftmost          ], _, Value11), solve(Classes, Students, [enum  , leftmost          ], _, _), solve(Classes, Students, [enum, leftmost          ], _, _), print_statistics(Value11),
    format('min             & enum  ,', []), solve(Classes, Students, [enum  , min               ], _, Value12), solve(Classes, Students, [enum  , min               ], _, _), solve(Classes, Students, [enum, min               ], _, _), print_statistics(Value12),
    format('max             & enum  ,', []), solve(Classes, Students, [enum  , max               ], _, Value13), solve(Classes, Students, [enum  , max               ], _, _), solve(Classes, Students, [enum, max               ], _, _), print_statistics(Value13),
    format('ff              & enum  ,', []), solve(Classes, Students, [enum  , ff                ], _, Value14), solve(Classes, Students, [enum  , ff                ], _, _), solve(Classes, Students, [enum, ff                ], _, _), print_statistics(Value14),
    format('anti_first_fail & enum  ,', []), solve(Classes, Students, [enum  , anti_first_fail   ], _, Value15), solve(Classes, Students, [enum  , anti_first_fail   ], _, _), solve(Classes, Students, [enum, anti_first_fail   ], _, _), print_statistics(Value15),
    format('occurrence      & enum  ,', []), solve(Classes, Students, [enum  , occurrence        ], _, Value16), solve(Classes, Students, [enum  , occurrence        ], _, _), solve(Classes, Students, [enum, occurrence        ], _, _), print_statistics(Value16),
    format('ffc             & enum  ,', []), solve(Classes, Students, [enum  , ffc               ], _, Value17), solve(Classes, Students, [enum  , ffc               ], _, _), solve(Classes, Students, [enum, ffc               ], _, _), print_statistics(Value17),
    format('max_regret      & enum  ,', []), solve(Classes, Students, [enum  , max_regret        ], _, Value18), solve(Classes, Students, [enum  , max_regret        ], _, _), solve(Classes, Students, [enum, max_regret        ], _, _), print_statistics(Value18),
    nl,
    format('leftmost        & bisect,', []), solve(Classes, Students, [bisect, leftmost          ], _, Value21), solve(Classes, Students, [bisect, leftmost          ], _, _), solve(Classes, Students, [bisect, leftmost          ], _, _), print_statistics(Value21),
    format('min             & bisect,', []), solve(Classes, Students, [bisect, min               ], _, Value22), solve(Classes, Students, [bisect, min               ], _, _), solve(Classes, Students, [bisect, min               ], _, _), print_statistics(Value22),
    format('max             & bisect,', []), solve(Classes, Students, [bisect, max               ], _, Value23), solve(Classes, Students, [bisect, max               ], _, _), solve(Classes, Students, [bisect, max               ], _, _), print_statistics(Value23),
    format('ff              & bisect,', []), solve(Classes, Students, [bisect, ff                ], _, Value24), solve(Classes, Students, [bisect, ff                ], _, _), solve(Classes, Students, [bisect, ff                ], _, _), print_statistics(Value24),
    format('anti_first_fail & bisect,', []), solve(Classes, Students, [bisect, anti_first_fail   ], _, Value25), solve(Classes, Students, [bisect, anti_first_fail   ], _, _), solve(Classes, Students, [bisect, anti_first_fail   ], _, _), print_statistics(Value25),
    format('occurrence      & bisect,', []), solve(Classes, Students, [bisect, occurrence        ], _, Value26), solve(Classes, Students, [bisect, occurrence        ], _, _), solve(Classes, Students, [bisect, occurrence        ], _, _), print_statistics(Value26),
    format('ffc             & bisect,', []), solve(Classes, Students, [bisect, ffc               ], _, Value27), solve(Classes, Students, [bisect, ffc               ], _, _), solve(Classes, Students, [bisect, ffc               ], _, _), print_statistics(Value27),
    format('max_regret      & bisect,', []), solve(Classes, Students, [bisect, max_regret        ], _, Value28), solve(Classes, Students, [bisect, max_regret        ], _, _), solve(Classes, Students, [bisect, max_regret        ], _, _), print_statistics(Value28),
    nl,
    format('leftmost        & median,', []), solve(Classes, Students, [median, leftmost          ], _, Value31), solve(Classes, Students, [median, leftmost          ], _, _), solve(Classes, Students, [median, leftmost          ], _, _), print_statistics(Value31),
    format('min             & median,', []), solve(Classes, Students, [median, min               ], _, Value32), solve(Classes, Students, [median, min               ], _, _), solve(Classes, Students, [median, min               ], _, _), print_statistics(Value32),
    format('max             & median,', []), solve(Classes, Students, [median, max               ], _, Value33), solve(Classes, Students, [median, max               ], _, _), solve(Classes, Students, [median, max               ], _, _), print_statistics(Value33),
    format('ff              & median,', []), solve(Classes, Students, [median, ff                ], _, Value34), solve(Classes, Students, [median, ff                ], _, _), solve(Classes, Students, [median, ff                ], _, _), print_statistics(Value34),
    format('anti_first_fail & median,', []), solve(Classes, Students, [median, anti_first_fail   ], _, Value35), solve(Classes, Students, [median, anti_first_fail   ], _, _), solve(Classes, Students, [median, anti_first_fail   ], _, _), print_statistics(Value35),
    format('occurrence      & median,', []), solve(Classes, Students, [median, occurrence        ], _, Value36), solve(Classes, Students, [median, occurrence        ], _, _), solve(Classes, Students, [median, occurrence        ], _, _), print_statistics(Value36),
    format('ffc             & median,', []), solve(Classes, Students, [median, ffc               ], _, Value37), solve(Classes, Students, [median, ffc               ], _, _), solve(Classes, Students, [median, ffc               ], _, _), print_statistics(Value37),
    format('max_regret      & median,', []), solve(Classes, Students, [median, max_regret        ], _, Value38), solve(Classes, Students, [median, max_regret        ], _, _), solve(Classes, Students, [median, max_regret        ], _, _), print_statistics(Value38),
    nl,
    format('leftmost        & middle,', []), solve(Classes, Students, [middle, leftmost          ], _, Value41), solve(Classes, Students, [middle, leftmost          ], _, _), solve(Classes, Students, [middle, leftmost          ], _, _), print_statistics(Value41),
    format('min             & middle,', []), solve(Classes, Students, [middle, min               ], _, Value42), solve(Classes, Students, [middle, min               ], _, _), solve(Classes, Students, [middle, min               ], _, _), print_statistics(Value42),
    format('max             & middle,', []), solve(Classes, Students, [middle, max               ], _, Value43), solve(Classes, Students, [middle, max               ], _, _), solve(Classes, Students, [middle, max               ], _, _), print_statistics(Value43),
    format('ff              & middle,', []), solve(Classes, Students, [middle, ff                ], _, Value44), solve(Classes, Students, [middle, ff                ], _, _), solve(Classes, Students, [middle, ff                ], _, _), print_statistics(Value44),
    format('anti_first_fail & middle,', []), solve(Classes, Students, [middle, anti_first_fail   ], _, Value45), solve(Classes, Students, [middle, anti_first_fail   ], _, _), solve(Classes, Students, [middle, anti_first_fail   ], _, _), print_statistics(Value45),
    format('occurrence      & middle,', []), solve(Classes, Students, [middle, occurrence        ], _, Value46), solve(Classes, Students, [middle, occurrence        ], _, _), solve(Classes, Students, [middle, occurrence        ], _, _), print_statistics(Value46),
    format('ffc             & middle,', []), solve(Classes, Students, [middle, ffc               ], _, Value47), solve(Classes, Students, [middle, ffc               ], _, _), solve(Classes, Students, [middle, ffc               ], _, _), print_statistics(Value47),
    format('max_regret      & middle,', []), solve(Classes, Students, [middle, max_regret        ], _, Value48), solve(Classes, Students, [middle, max_regret        ], _, _), solve(Classes, Students, [middle, max_regret        ], _, _), print_statistics(Value48),

    true.
