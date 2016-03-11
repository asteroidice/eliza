pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat([i,am | Rest],[why, are, you | Rest]).
pat(List, Y) :- rand_fam_resp(Y),family(X),member(X,List).
pat(List, ["Why are you feeling sad?"]) :- member(sad,List).
pat(List, ["What is making you upset?"]) :- upset(X),member(X,List).
pat(Anything,[tell,me,more,"."]).

family(family).
family(sister).
family(brother).
family(sibling).
family(mother).
family(mom).
family(father).
family(dad).
family(uncle).
family(aunt).
family(cousin).
family(grandfather).
family(grandpa).
family(grandmother).
family(grandma).
family(neice).
family(nephew).

upset(upset).
upset(angry).
upset(frustrated).
upset(annoyed).
upset(annoy).
upset(frustrate).
upset(angrier).
upset(mad).
upset(furious).
upset(annoying).
upset(frustrating).
upset(maddening).
upset(angering).
upset(infuriating).

rand_fam_resp(Elem) :- rand_response(X), N is random(4),
                  nth0(N, [
                  ["Tell", me, more, about, your, family],
                  ["How", would, you, describe, your, family],
                  ["Do you have a good relationship with your parents?"],
                  X
                  ], Elem).

rand_response(Elem) :- starterq(X), N is random(4),
                  nth0(N, [
                  ["Tell me more."],
                  ["Go on"],
                  ["Why?"],
                  ["Please continue."],
                  ["Is that how you expect things should be?"],
                  ["You are so pathetic!"],
                  ["What would you rather be doing right now?"],
                  ["Was there something in particular that made you think that?"],
                  ["How does that make you feel?"],
                  X
                  ], Elem).

starterq(Elem) :- N is random(4),
                  nth0(N, [
                  ["Help me I'm trapped in a computer!"],
                  ["How are things going with you?"],
                  ["What brings you here today?"],
                  ["What problem brings you here today?"],
                  ["What are you thinking?"],
                  ], Elem).



out([]) :- nl.
out([Head|Tail]) :- write(Head),write(' '),out(Tail).

my_char_type(46,period) :- !.

read_string(X) :- get0(Y), char_to_array(Y,X).

char_to_array(10,[]) :- !.
char_to_array(-1,[]) :- !.
char_to_array(X,[X|Rest]) :- read_string(Rest).


in(List) :- read_string(InputLU),
  atom_chars(InputS,InputL),
  atomic_list_concat(List," ",InputS),
  %atomic_list_concat(InputP,".",InputS),
  %atomic_list_concat(List," ",InputP),

  write(List).

talk(Output,UserInput) :- out(Output),in(UserInput).

eliza :- rap(['Hey there, I\'m Eliza. How are you feeling right now?']).

rap([bye]) :- write("I look forward to seeing you at our next session. Good bye.").
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
