# MPSiS 2018/2019
# Model 1a


/* Decision variables */
var l >= 0, integer;
var u, integer;

/* Objective function 'z' */
maximize z: -u + l;

/* Constraints */

s.t. C1: 2 + u - 2*l >= 0;
s.t. C2: 2 + 2*u - l >= 0;
s.t. C3: 3 - 4*u >= 0;

