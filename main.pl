pattern([i,am,X],['How',long,have,you,been,X,?]).
pattern([X,you,Y,me],['What',makes,you,think,'I',Y,you,?]).
pattern([i,like,X],['Does',anyone,else,in,your,family,like,X,?]).
pattern([i,feel,X],['Do',you,often,feel,that,way,?]).

pattern([X,X,Y],['Please',you,tell,me,more,about,X]) :-
 important(X).
pattern([X],['Please',go,on,'.']).
important(father).
important(mother).
important(sister).
important(brother).
important(son).
important(daughter).
