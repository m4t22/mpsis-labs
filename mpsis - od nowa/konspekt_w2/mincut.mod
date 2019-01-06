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
var d{v in V, w in V}, binary, >= 0; # wskazanie lukow nalezacych do rozciecia
var p{v in V}, binary, >= 0; # wskazanie, czy wierzcholek jest ze zrodlem czy z ujsciem

/* Objective function 'z' */
minimize g: sum{v in V, w in V: neigh[v,w] == 1} c[v,w]*d[v,w]; 

/* Constraints */
s.t. C1{v in V, w in V: neigh[v,w] == 1}: d[v,w] - p[v] + p[w] >= 0;
s.t. C2: p[s] = 1;
s.t. C3: p[t] = 0;


data;

param V_n := 6;

param neigh  :=
1 2 1
1 4 1
2 1 1
2 4 1
2 3 1
3 2 1
3 4 1
3 5 1
3 6 1
4 1 1
4 2 1
4 3 1
4 5 1
5 4 1
5 3 1
5 6 1
6 3 1
6 5 1
;

param c :=
1 2 7
1 4 2
2 1 7
2 4 6
2 3 9
3 2 9
3 4 9
3 5 7
3 6 6
4 1 2
4 2 6
4 3 9
4 5 7
5 4 7
5 3 7
5 6 6
6 3 6
6 5 6
;

end;