eliza :- read_word_list(Input), eliza(Input), !.
eliza([bye]) :- reply(['Goodbye. I hope I have helped you']).
eliza(Input) :- pattern(Stimulus,Response),
                match(Stimulus,Response),
                match(Response,Dictionary,Output),
                reply(Output),
                read_word_list(Input1),
                !, eliza(Input1).
match([N|Pattern],Dictionary,Target) :- integer(N), lookup(N,Dictionary,LeftTarget),
                                        append(LeftTarget,RightTarget,Target),
                                        match(Pattern,Dictionary,RightTarget).
match([Word|Pattern],Dictionary,[Word|Target]) :- atom(Word),
                                                  match(Pattern,Dictionary,Target).
match([ ],Dictionary,[ ]).

%lookup(Key,Dictionary,Value)

pattern([i,am,1],['How',long,have,you,been,1,?]).
pattern([1,you,2,me],['What',makes,you,think,'I',2,you,?]).
pattern([i,like,1],['Does',anyone,else,in,your,family,like,1,?]).
pattern([i,feel,1],['Do',you,often,feel,that,way,?]).
pattern([X,X,Y],['Please',you,tell,me,more,about,1]) :-
 important(1).
pattern([1],['Please',go,on,'.']).

important(father).
important(mother).
important(sister).
important(brother).
important(son).
important(daughter).

reply([Head|Tails]) :- write(Head), write(' '), reply(Tail).
reply([ ]) :- nl.

read_word_list(Words) :-  get_char(FirstChar),
                          read_words(FirstChar,Words).
read_words(Char,[Word|Words]) :-  word_char(Char),
                                  read_word(Char,Word,NextChar),
                                  read_words(NextChar,Words).
read_words(Char,Words) :-   fill_char(Char),
                            get_char(NextChar),
                            read_words(NextChar,Words).
read_words(Char,[ ]) :- end_of_words_char(Char).
read_word(Char,Word,NextChar) :- word_chars(Char,Chars,NextChar),
                                  atom_list(Word,Chars).
word_chars(Char,[Char|Chars],FinalChar) :- word_char(Char), !,
                                            get_char(NextChar),
                                            word_chars(NextChar,Chars,FinalChar).
word_chars(Char,[ ],Char) :- not word_char(Char).
