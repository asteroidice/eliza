pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat([i, am | Rest],[why, are, you | Rest]).
pat(Anything,[tell,me,more]).

out([]) :- nl.
out([Head|Tail]) :- write(Head),write(' '),out(Tail).

in(List) :- read(InputL),atomic_list_concat(List," ",InputL).
talk(Output,UserInput) :- out(Output),in(UserInput).

eliza :- rap(['Hello, Please tell me about your problems.']).

rap([bye]) :- write(["Good bye glad to see you go."]).
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
