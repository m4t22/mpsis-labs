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
param delta{e in E, d in D, p in P}, binary, default 0; # czy dane łącze należy do danej ścieżki dla danego zapotrzebowania
param h{d in D}, >= 0; #zapotrzebowania
param M := 10000;
#drugie big M. to jest do tego jak płacimy za odpalenie łącza. Będę wszystko z tym związane pisał kursywą
param W:= 10000; ###### big W do ograniczenia#########################
param a{k in K}; # zmienne do linearyzacji
param b{k in K}; # zmienne do linearyzacji
param C := 100; # ograniczenie przelywnosci
param B := 1000; # ograniczenie budzetowe
param kappa{e in E}, default 100; #####koszt instalacji lacza##############

/* Decision variables */
var x{d in D, p in P} >= 0; # ruch na ścieżce dla danego zapotrzebowania
var y{e in E} >= 0; # ruch na laczu
var z{e in E}, >= 0; # koszt na danym łączu
var u{d in D, p in P}, binary, >= 0; # flaga binarna, do bifurkacji, czy bierzemy ściezke czy nie
var v{e in E}, binary, >=0; ####flaga binarna, czy lacze jest instalowane czy nie ######
var r, >= 0; procentowo, jak dużo ruchu nasza sieć uciągnie przy ograniczeniu C i ograniczeniu budżetu B

/* Objective function 'z' */
maximize f: r; 

/* Constraints */
# suma ruchu na wszstkich ścieżkach dla każdego zapotrzebowania musi się równać temu zapotrzebowaniu
s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
# koszt liczy się tu z linearyzacji: jest y[e] ale oznaczo ruch #######################
s.t. C2{e in E, k in K}: z[e] >= a[k]*y[e] + b[k] +kappa[e]*v[e]; #########################
# ruch na łączu równa się sumie zapotrzebowań na danym łączu (jeżeli tylko one należą do ścieżki p dla zapotrzebowania d) przemnożonych przez procent, który maksymalzujemy.
s.t. C3{e in E}: y[e] == sum{d in D, p in P} delta[e,d,p]*h[d]*u[d,p]*r;
s.t. C4{d in D}: sum{p in P} u[d,p] == 1; # zapobiega, że weźmiemy więcej niż 1 ścieżkę
s.t. C5{d in D, p in P}: x[d,p] <= M*u[d,p]; # Ustawia u[d,p] na 1 jeżeli cokolwiek jest w x[d,p]
#Nowe ograniczenia
s.t. C6: sum{e in E} z[e] <= B; # zapewnienie, że nie przekroczymy budżetu
s.t. C7{d in D}: sum{p in P} x[d,p] == r * h[d]; ruch na ścieżce to r * zapotrzebowanie
s.t. C8{e in E}: y[e] <= C; # zapewnienie, że ruch na łączu nie zostanie przekroczony
s.t. C9: r<=1; # r jest w procentach, max 100% czyli 1
s.t. C10{e in E}: y[e]<= W*v[e]; ####### ustawia v[e] na 1, jeżeli jest jakikolwiek ruch na łączu y[e]
