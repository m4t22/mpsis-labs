# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param E_n, integer, >= 1; # liczba lukow 
param P_n, integer, >= 1; # liczba sciezek
param D_n, integer, >= 1; # liczba zapotrzebowan
param K_n, integer, >= 1; # liczba prostych

/* Set of variable indices */
set E, default {1..E_n};
set P, default {1..P_n};
set D, default {1..D_n};
set K, default {1..K_n};

/* Constants */
param delta{e in E, d in D, p in P}, binary, default 0; 
param h{d in D}, >= 0;
param M := 10000;
param a{k in K};
param b{k in K};
param C := 100;
param B = 1000;

/* Decision variables */
var x{d in D, p in P} >= 0;
var y{e in E} >= 0;
var z{e in E}, >= 0;
var u{d in D, p in P}, binary, >= 0;
var r, >= 0;

/* Objective function 'z' */
maximize f: r; 

/* Constraints */
s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
# koszt liczy się tu z linearyzacji: jest y[e] ale oznaczo ruch
s.t. C2{e in E, k in K}: z[e] >= a[k]*y[e] + b[k];
# ruch na łączu równa się sumie zapotrzebowań na danym łączu (jeżeli tylko one należą do ścieżki p dla zapotrzebowania d) przemnożonych przez procent, który maksymalzujemy.
s.t. C3{e in E}: y[e] == sum{d in D, p in P} delta[e,d,p]*h[d]*u[d,p]*r;
s.t. C4{d in D}: sum{p in P} u[d,p] == 1; # zapobiega, że weźmiemy więcej niż 1 ścieżkę
s.t. C5{d in D, p in P}: x[d,p] <= M*u[d,p]; # 
#Nowe ograniczenia
s.t. C6{e in E}: sum{e in E} z[e] <= B;
s.t. C7{d in D}: sum{p in P} x[d,p] == r * h[d];
s.t. C8{e in E}: y[e] <= C;
s.t. C9: r<=1;
