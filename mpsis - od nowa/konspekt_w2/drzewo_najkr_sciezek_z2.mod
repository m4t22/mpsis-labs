# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param V_n, integer, >= 1; # liczba wezlow

/* Set of variable indices */
set V, default {1..V_n};

/* Constants */
param s := 1;
param w{i in V, j in V}, >= 0;

/* matrixes */
param neigh{i in V, j in V}, binary, default 0;

/* Decision variables */
var x{i in V, j in V} >= 0; # wielkosc przeplywu na laczu
var y{i in V, j in V}, binary, >= 0; # czy luk jest uzywany

/* Objective function 'z' */
minimize z: sum{i in V, j in V: neigh[i,j]==1} w[i,j]*y[i,j];

/* Constraints */
s.t. C1: sum{i in V : neigh[s,i] == 1} x[s,i] = V_n - 1;
s.t. C2{i in V: i <> s}: sum{j in V: neigh[i,j] == 1} x[i,j] - sum{j in V: neigh[j,i] == 1} x[j,i] = -1;
s.t. C3{i in V, j in V}: x[i,j] <= (V_n - 1) * y[i,j];

/* Input data */

data;

param V_n := 6;


param w := 
1 2 7
1 3 6
1 4 9
2 1 7
2 3 2
3 2 2
3 1 6
3 4 9
3 5 7
4 1 9
4 3 9
4 5 7
4 6 6
5 3 7 
5 4 7
5 6 6
6 4 6
6 5 6
;

param neigh :=
1 2 1
1 3 1
1 4 1
2 1 1
2 3 1
3 2 1
3 1 1
3 4 1
3 5 1
4 1 1
4 3 1
4 5 1
4 6 1
5 3 1 
5 4 1
5 6 1
6 4 1
6 5 1
;

end;
