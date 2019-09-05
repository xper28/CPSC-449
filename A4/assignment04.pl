%Answer 1
mother(catelyn, arya).
mother(catelyn, sansa).
mother(minisa, lysa).
mother(lysa, robin).
mother(minisa, catelyn).
sister(X,Y) :- mother(Z,X),mother(Z,Y).
cousin(X,Y) :- mother(A,X), mother(B,Y), sister(A,B), not(A=B).
granddaughter(X,Y) :- mother(Y,Z),mother(Z,X).
descendent(X,Y) :- mother(Y,X).
descendent(X,Y) :- mother(Z,X), descendent(Z,Y).

%Answer 2
member_new(X,L) :- member(X, L).

%Answer 3
subset([],_).
subset([L|T],K) :- member_new(L,K),subset(T,K). 

%Answer 4
disjoint([],_).
disjoint([L|T],K) :- \+member_new(L,K),disjoint(T,K).

%Answer 5
union([L|T],K,M) :- member_new(L,K), union(T,K,M).
union([L|T1],K,[L|T2]) :- \+member_new(L,K), union(T1,K,T2).
union([],K,K).

%Answer 6
intersection([L|T1],K,[L|T2]) :- member_new(L,K), intersection(T1,K,T2). 
intersection([L|T],K,M) :- \+member_new(L,K), intersection(T,K,M).
intersection([],K,[]).

%Answer 7
difference([L|T1],K,[L|T2]) :- \+member_new(L,K), difference(T1,K,T2). 
difference([L|T],K,M) :- member_new(L,K), difference(T,K,M). 
difference([],K,[]). 

%Answer 8
occurrences(X,[],0). 
occurrences(X,[X|T],N) :- occurrences(X,T,N1), N is N1+1.
occurrences(X,[L|T],N) :- X\=L, occurrences(X,T,N).

%Answer 9
quicksort([],[]).
quicksort([F|T],K) :- pivot(F,T,L,R), quicksort(L,KL), quicksort(R,KR), append(KL,[F|KR],K).

pivot(_,[],[],[]).
pivot(F,[M|T],[M|LK],RK) :- M =< F, pivot(F,T,LK,RK).
pivot(F,[M|T],LK,[M|RK]) :- M > F, pivot(F,T,LK,RK).

%Answer 10
edge(1,2).
edge(1,4).
edge(1,3).
edge(2,3).
edge(2,5).
edge(3,4).
edge(3,5).
edge(4,5).

path(A,B,P) :- traverse(A,B,[A],P).
traverse(A,A,_,[A]).
traverse(A,B,V,[A|P]) :-  edge(A,X), \+member_new(X,V), traverse(X,B,[X|V],P).

%Reference:https://rosettacode.org/wiki/Sorting_algorithms/Quicksort#Prolog