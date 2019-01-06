# MPSiS 2018/2019
# Model L-N LAB2
# Ogolna uwaga kazdy element uzywany w rownaniu/nierownosci musi
# zostac zadeklarowany po indeksach

/* Zmienne indeksowe */

param V_numb, integer, >= 0;
param E_numb, integer, >= 0;
param D_numb, integer, >= 0;

/* Deklaracja indeksow */

set V, default {1..V_numb};
set E, default {1..E_numb};
set D, default {1..D_numb};

/* Macierze A i B */

param A{e in E, v in V}, >=0, default 0;
param B{e in E, v in V}, >=0, default 0;

/* Ograniczenia pojemnosci laczy */

param c{e in E}, >=0, default 10;

/* koszt przeslania danych laczem */

param KSI{e in E} >= 0;

/* stale */

param h{d in D}, >= 0;
param s{d in D}, >= 0;
param t{d in D}, >= 0;

/* zmienna */

var x{e in E, d in D} >= 0;

/* function subjected to minimization */

minimize z: sum{e in E} KSI[e]*(sum{d in D} x[e,d]);

/* Constraints */

s.t. c1{d in D, v in V : v == s[d]} : sum{e in E}(A[e,v]*x[e,d] - B[e,v]*x[e,d]) == h[d];
s.t. c2{d in D, v in V : v <> s[d] and v <> t[d]} : sum{e in E}(A[e,v]*x[e,d] - B[e,v]*x[e,d]) == 0;
s.t. c3{d in D, v in V : v == t[d]} : sum{e in E}(A[e,v]*x[e,d] - B[e,v]*x[e,d]) == -h[d];
s.t. c4{e in E} : sum{d in D} x[e,d] <= c[e]; 

end;