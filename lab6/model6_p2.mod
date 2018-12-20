# MPSiS 2018/2019
# Model 6

/* Number of variables */
param n, integer, >= 1;

/* Set of variable indices, up to 'n' */
set I, default {1..n};

/* Decision variables */
var x{i in I}, integer;

/* Objective function 'z' */
maximize z: x[1] - x[2];

/* Constraints */

s.t. C1: 2*x[1] - x[2] <= 2;
s.t. C2: x[1] - 2*x[2] <= 2;
s.t. C3: 4*x[1] <= 3;
s.t. C4: x[1] >= 0;

/* Input data */

data;

param n := 2;

end;