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

/* Macierze delta */

param delta{e in E, d in D, p in P}, >=0, default 0;

/* koszt przeslania danych laczem */

param ksi{e in E} >= 0;

/* stale */

param h{d in D}, >= 0;


/* zmienna */

var x{p in P, d in D} >= 0;

/* function subjected to minimization */

minimize z: sum{e in E,d in D, p in P} ksi[e] * delta[e,d,p] * x[d,p];

/* Constraints */

s.t. c1{d in D} : sum{p in P}(x[d,p]) == h[d];

end;
