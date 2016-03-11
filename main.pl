pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat([i,am | Rest],[why, are, you | Rest]).
pat(List, [tell,me,more,about,your,family]) :- member(father,List).
pat(Anything,[tell,me,more,"."]).


out([]) :- nl.
out([Head|Tail]) :- write(Head),write(' '),out(Tail).

my_char_type(46,period) :- !.

read_string(X) :- get0(Y), char_to_array(Y,X).

char_to_array(10,[]) :- !.
char_to_array(-1,[]) :- !.
char_to_array(X,[X|Rest]) :- read_string(Rest).

in(List) :- read_string(InputL),atom_chars(InputS,InputL),atomic_list_concat(List," ",InputS),write(List).
talk(Output,UserInput) :- out(Output),in(UserInput).

eliza :- rap(['Hey there, I\'m Eliza. How are you feeling right now?']).

rap([bye]) :- write("This has been a good session. Good bye.").
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
