# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param C_n, integer, >= 1; # liczba kolorow
param V_n, integer, >= 1; # liczba wezlow

/* Set of variable indices */
set C, default {1..C_n};
set V, default {1..V_n};

/* Constants */

param neigh{v in V, w in V}, binary, default 0;


/* Decision variables */
var x{v in V, k in C}, binary;
var y{k in C}, binary;


/* Objective function 'z' */
minimize f: sum{k in C}y[k]; 

/* Constraints */
s.t. C1{i in V}: sum{k in C} x[i,k] = 1;
s.t. C2{i in V, j in V, k in C : neigh[i,j] == 1}: x[i,k] + x[j,k] <= 1;
s.t. C3{k in C}: sum{i in V} x[i,k] <= V_n*y[k]; 

data;

param V_n := 7;
param C_n := 4;

param neigh  :=
1 2 1
1 3 1
1 4 1
2 1 1
2 4 1
2 5 1
3 1 1
3 4 1
3 6 1
4 1 1
4 2 1
4 5 1
4 7 1
4 6 1
4 3 1
5 2 1
5 7 1
5 4 1
6 3 1
6 4 1
6 7 1
7 6 1
7 4 1
7 5 1
;

end;
