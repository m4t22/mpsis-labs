# MPSiS 2018/2019
# Model L-P LAB3
# Ogolna uwaga kazdy element uzywany w rownaniu/nierownosci musi
# zostac zadeklarowany po indeksach
# http://kt.agh.edu.pl/~kamisinski/teaching/mpsis/lab/L3/ufap_A_link_path.html

/* Zmienne indeksowe */

param P_numb, integer, >= 0;
param E_numb, integer, >= 0;
param D_numb, integer, >= 0;

/* Deklaracja indeksow */

set P, default {1..P_numb};
set E, default {1..E_numb};
set D, default {1..D_numb};

/* zmienne */

var x{p in P, d in D} >= 0;
var u{d in D, p in P}, integer >= 0;
var y{e in E}, integer >=0;

/* stale */

param delta{e in E, d in D, p in P}, >=0, default 0;
param h{d in D}, >= 0;
param KSI{e in E} >= 0;
param k{e in E} >= 0, default 5;
param W >= 0;
param M >= 0;

/* funkcja celu */

minimize z: sum{e in E,d in D, p in P}(KSI[e]*y[e] + k[e]*u[d,p]);

/* Ograniczenia */
s.t. c1{e in E} : sum{d in D, p in P}(delta[e,d,p]*h[d]*u[d,p]) <= M* y[e];
s.t. c2{d in D} : sum{p in P}(u[d,p]) == 1;


end;