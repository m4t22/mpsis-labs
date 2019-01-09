# MPSiS 2018/2019
# linearyzacja problemu wypuklego, funkcja y^2

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

/* Decision variables */
var x{d in D, p in P} >= 0;
var y{e in E} >= 0;
var z{e in E}, >= 0;
var u{d in D, p in P}, binary, >= 0;

/* Objective function 'z' */
#minimize z: sum{e in E} sqrt(y[e]);
minimize v: sum{e in E} z[e];

/* Constraints */

s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
s.t. C2{e in E, k in K}: z[e] >= a[k]*y[e] + b[k]; # ograniczenie na linearyzacje
s.t. C3{e in E}: sum{d in D, p in P} delta[e,d,p]*h[d]*u[d,p] == y[e];
s.t. C4{d in D}: sum{p in P} u[d,p] == 1;
s.t. C5{d in D, p in P}: x[d,p] <= M*u[d,p];


data;

param E_n := 16;
param P_n := 2;
param D_n := 2;
param K_n := 3;

param h :=
1 3
2 4
;

param a :=
1 2
2 5
3 7
;

param b :=
1 0
2 -6
3 -12
;

# e d p
param delta :=
3,  1, 1    1
4,  1, 1    1
5,  1, 1    1
10, 1, 1    1
12, 1, 1    1
13, 1, 1    1
1,  1, 2    1
7,  1, 2    1
10, 1, 2    1
14, 1, 2    1
8,  2, 1    1
15, 2, 1    1
7,  2, 2    1
10, 2, 2    1
14, 2, 2    1
16, 2, 2    1
;

end;

