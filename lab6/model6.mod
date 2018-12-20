# MPSiS 2018/2019
# Model 6

/* Number of variables */
param n, integer, >= 1;

/* Set of variable indices, up to 'n' */
set I, default {1..n};

/* Decision variables */
var x{i in I} >= 0, integer;

/* Objective function 'z' */
minimize z: 2*x[1] + 2*x[2] + 3*x[3];

/* Constraints */

s.t. C1: 2*x[1] + x[2] + 4*x[3] >= 1;
s.t. C2: x[1] + 2*x[2] = 1;
s.t. C3{i in I} : x[i] >= 0;

/* Input data */

data;

param n := 3;

end;