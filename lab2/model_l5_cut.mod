# MPSiS 2018/2019
# Model L-N LAB2
# Ogolna uwaga kazdy element uzywany w rownaniu/nierownosci musi
# zostac zadeklarowany po indeksach

/* Zmienne indeksowe */

param V_numb, integer, >= 0;

/* Deklaracja indeksow */

set V, default {1..V_numb};

/* stale */

param c{v in V, w in V}, >=0 ,default 50;
param neigh{v in V, w in V}, binary, default 0;

/* zmienna */

var p{v in V}, binary;
var b{v in V, w in V}, binary; 

/* function subjected to minimization */

minimize z: sum{v in V, w in V : neigh[v,w]==1} b[v,w]*c[v,w];

/* Constraints */

s.t. c1{v in V, w in V} : b[v,w] - p[v] + p[w] >= 0;
s.t. c2 : p[1] = 1;
s.t. c3 : p[V_numb] = 0;

data;

param V_numb := 6;

param neigh  :=
1,2     1
1,4     1
2,1     1    
2,3     1
3,2     1
3,4     1
3,6     1
4,1     1
4,3     1
4,5     1
5,4     1
5,6     1
6,3     1
6,5     1
;

param c := 
2,3 1
;

end;