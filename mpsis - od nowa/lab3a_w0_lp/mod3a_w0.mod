# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param E_n, integer, >= 1; # liczba lukow 
param P_n, integer, >= 1; # liczba sciezek
param D_n, integer, >= 1; # liczba zapotrzebowan

/* Set of variable indices */
set E, default {1..E_n};
set P, default {1..P_n};
set D, default {1..D_n};

/* Constants */
param delta{e in E, d in D, p in P}, binary, default 0;
param h{d in D}, >= 0;
param KSI{e in E}, >= 0;

/* Decision variables */
var x{d in D, p in P} >= 0;
var y{e in E} >= 0;

/* Objective function 'z' */
minimize z: sum{e in E} KSI[e]*y[e];

/* Constraints */

s.t. C1{d in D}: sum{p in P} x[d,p] == h[d];
s.t. C2{e in E}: sum{d in D, p in P} delta[e,d,p]*x[d,p] == y[e];

end;
