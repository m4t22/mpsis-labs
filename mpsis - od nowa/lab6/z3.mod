# MPSiS 2018/2019
# Model 1a

param N_n := 3;

set N, default {1..N_n};

/* Decision variables */
var x{n in N}, integer, >= 0;

/* Objective function 'z' */
minimize z: 2*x[1]+2*x[2]+3*x[3];

/* Constraints */

s.t. C1: 2*x[1] + x[2] + 4*x[3] >= 1;
s.t. C2: x[1] + 2*x[2] = 1;


