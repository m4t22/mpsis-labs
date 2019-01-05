# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param E_n, integer, >= 1; # liczba lukow 
param P_n, integer, >= 1; # liczba sciezek
param D_n, integer, >= 1; # liczba zapotrzebowan
param L_n, integer, >= 1; # liczba modulow przeplywnosci

/* Set of variable indices */
set E, default {1..E_n};
set P, default {1..P_n};
set D, default {1..D_n};
set L, default {1..L_n};

/* Constants */
param delta{e in E, d in D, p in P}, binary, default 0;
param h{d in D}, >= 0;
param KSI{e in E}, >= 0;
param M{l in L}, integer, >=0;
param k{l in L}, integer, >=0;

/* Decision variables */
var x{d in D, p in P} >= 0;
var y{e in E}, integer, >= 0;
var f{e in E, l in L}, integer, >= 0;

/* Objective function 'z' */
minimize z: sum{e in E} KSI[e]*sum{d in D, p in P} delta[e,d,p]*x[d,p] + sum{e in E, l in L}f[e,l]*k[l];

/* Constraints */

s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
s.t. C2{e in E}: sum{d in D, p in P} delta[e,d,p]*x[d,p] <= sum{l in L}M[l]*f[e,l];

data;

param E_n := 16;
param P_n := 2;
param D_n := 2;
param L_n := 2;

param h :=
1 10
2 10
;

param M :=
1 1
2 5
;

param k :=
1 1
2 10
;

param KSI := 
1 30
2 10
3 90
4 10
5 10
6 30
7 35
8 40
9 10
10 15
11 50
12 45
13 90
14 25
15 30
16 35
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

