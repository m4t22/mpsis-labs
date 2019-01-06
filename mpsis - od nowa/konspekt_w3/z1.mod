# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param V_n, integer, >= 1; # liczba wezlow

/* Set of variable indices */
set V, default {1..V_n};

/* Constants */
param s := 1;
param t := 6;

param c{v in V, w in V}, >= 0, default 100;
param neigh{v in V, w in V}, binary, default 0;



/* Decision variables */
var x{v in V, w in V}, >= 0;
var z, >= 0;

/* Objective function 'z' */
maximize f: z; 

/* Constraints */
s.t. C1: sum{v in V : neigh[s,v] == 1} x[s,v] - sum{v in V : neigh[v,s] == 1} x[v,s] == z;
s.t. C2: sum{v in V : neigh[t,v] == 1} x[t,v] - sum{v in V : neigh[v,t] == 1} x[v,t] == -z;
s.t. C3{v in V: v <> s and v <> t}: sum{w in V : neigh[v,w]==1} x[v,w] - sum{w in V : neigh[w,v]==1} x[w,v] == 0;
s.t. C4{v in V, w in V : neigh[v,w] == 1}: x[v,w] <= c[v,w];

data;

param V_n := 6;

param neigh  :=
1,2     1
1,3     1
2,4     1    
2,3     1
2,5     1
3,5     1
5,6     1
6,4     1
;

param c :=
1,2 30
1,3 20
2,3 10
2,4 10
2,5 10
3,5 20
5,6 30
6,4 10
;

end;
