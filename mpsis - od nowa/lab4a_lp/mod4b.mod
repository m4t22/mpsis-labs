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

/* Decision variables */
var x{d in D, p in P} >= 0;
var y{e in E} >= 0;
var m{e in E, k in K};
var u{e in E, k in K}, binary, >= 0;

/* Objective function 'z' */
#minimize z: sum{e in E} sqrt(y[e]);
minimize z: sum{e in E, k in K} m[e,k]*a[k]+ sum{e in E, k in K}u[e,k]*b[k];

/* Constraints */

s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
s.t. C2{e in E}: sum{k in K} m[e,k] == y[e];
s.t. C3{e in E}: sum{k in K} u[e,k] == 1;
s.t. C4{e in E}: sum{d in D, p in P} delta[e,d,p]*x[d,p] == y[e];
s.t. C5{e in E, k in K}: m[e,k] <= u[e,k]*M;
s.t. C6{e in E, k in K}: 0 <= m[e,k];

data;

param E_n := 16;
param P_n := 2;
param D_n := 2;
param K_n := 2;

param h :=
1 3
2 4
;

param a :=
1 2
2 5
;

param b :=
1 0
2 -6
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

