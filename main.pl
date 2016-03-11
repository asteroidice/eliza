pat([bye],[bye]).
pat([hello | _ ], [hello, there]).
pat(List, ["Let's talk about you, not me"]) :- direct(X),member(X,List).
pat(List, Y) :- rand_fam_resp(Y),family(X),member(X,List).
pat(List, Y) :- rand_school_resp(Y),school(X),member(X,List).
pat(List, Y) :- rand_work_resp(Y),work(X),member(X,List).

pat(List, ["What does love mean to you?"]) :- member(love,List).
pat(List, ["What exactly is making you feel sad?"]) :- member(sad,List).
pat(List, ["What seems to be making you upset?"]) :- upset(X),member(X,List).
pat([i,am | Rest],[why, are, you | Rest]).
pat(Anything,X) :- rand_response(X).

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


work(job).
work(work).
work(career).
work(paid).
work(salary).
work(boss).
work(intern).



direct(eliza).
direct(you).
direct(counselor).
direct(therapist).

school(school).
school(class).
school(grade).
school(grades).
school(classes).
school(homework).
school(professor).
school(classmates).
school(test).
school(tests).

rand_work_resp(R) :- rand_response(X), N is random(6),
                  nth0(N, [
                    ["Is there a problem at work?"],
                    ["Do you enjoy what you do at work?"],
                    ["What does your job entail?"],
                    ["Do you find yourself spending a lot of time in the office?"],
                    ["How do you feel about your Boss?"],
                    X
                  ], R).

rand_fam_resp(Elem) :- rand_response(X), N is random(4),
                  nth0(N, [
                  ["Tell", me, more, about, your, family],
                  ["How", would, you, describe, your, family],
                  ["Do you have a good relationship with your parents?"],
                  X
                  ], Elem).

rand_school_resp(Elem) :- rand_response(X), N is random(11),
                  nth0(N, [
                  ["Tell me more about school."],
                  ["How do you like school?"],
                  ["Do you enjoy school?"],
                  ["Is school feeling stressful for you?"],
                  ["What do you enjoy most about school?"],
                  ["What classes are you taking?"],
                  ["What is your major?"],
                  ["What do you like to do outside of classes?"],
                  ["How is the homework load for you?"],
                  ["Do you like the school you're attending?"],
                  X
                  ], Elem).

rand_response(Elem) :- starterq(X), N is random(10),
                  nth0(N, [
                  ["Tell me more."],
                  ["Go on"],
                  ["Why?"],
                  ["Please continue."],
                  ["Is that how you expect things should be?"],
                  ["What would you rather be doing right now?"],
                  ["Was there something in particular that made you think that?"],
                  ["How does that make you feel?"],
                  X
                  ], Elem).

starterq(Elem) :- N is random(5),
                  nth0(N, [
                  ["Help me I'm trapped in a computer!"],
                  ["How are things going with you?"],
                  ["What brings you here today?"],
                  ["What problem brings you here today?"],
                  ["What are you thinking?"]
                  ], Elem).



out([]) :- nl.
out([Head|Tail]) :- write(Head),write(' '),out(Tail).

my_char_type(46,period) :- !.

read_string(X) :- get0(Y), char_to_array(Y,X).

char_to_array(10,[]) :- !.
char_to_array(-1,[]) :- !.
char_to_array(X,[X|Rest]) :- read_string(Rest).


in(List) :- read_string(InputL),
  atom_chars(InputS,InputL),
  atomic_list_concat(List," ",InputS),
  %atomic_list_concat(InputP,".",InputS),
  %atomic_list_concat(List," ",InputP).

talk(Output,UserInput) :- out(Output),in(UserInput).

eliza :- rap(['Hey there, I\'m Eliza. How are you feeling right now? (please use lower case and no punctuation for your input)']).

rap([bye]) :- write("I look forward to seeing you at our next session. Good bye.").
rap(Output) :-
  talk(Output, UserInput),
  pat(UserInput, NewOutput),
  rap(NewOutput).
