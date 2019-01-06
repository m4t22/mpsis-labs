# MPSiS 2018/2019
# Model UFAP, P/L

/* Number of vertexes, edges, dispositions */
param P_count, integer, >= 0;
param E_count, integer, >= 0;
param D_count, integer, >= 0;

/* Sets of vertexes, edges and dispositions */
set P, default {1..P_count};
set E, default {1..E_count};
set D, default {1..D_count};

/* Requirements */
param h{d in D} >= 0;
param LAM{e in E, d in D, p in P} >= 0, default 0;

/* KSI */
param KSI{e in E} >= 0;

/* Decision variables */
var x{d in D, p in P} >= 0;

/* Objective function 'z' */
minimize z: sum{e in E, d in D, p in P} KSI[e]*LAM[e,d,p]*x[d,p];

/* Constraints */
s.t. c2{d in D} : h[d] == sum{p in P} x[d,p];

end;