pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat([i,am | Rest],[why, are, you | Rest]).
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

eliza :- rap(['Hey there, Please don\'t tell me about your problems. Also I\'m very picky, so please use quotes when you talk.']).

rap([bye]) :- write("Good bye, glad to see you go.").
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
