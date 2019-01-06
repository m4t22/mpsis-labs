# MPSiS 2018/2019
# Model L-P LAB2

# Zmienne indeksowe

param E_numb, integer, >= 0;
param D_numb, integer, >= 0;
param P_numb, integer, >= 0;

# Deklaracja indeksowe

set E, default {1..E_numb};
set D, default {1..D_numb};
set P, default {1..P_numb};

# Stale

param delta{e in E, d in D, p in P} >=0, default 0;
param h{d in D} >= 0;
param KSI{e in E} >= 0;

# Zmienna

var x{d in D, p in P} >=0;

# Funkcja celu

minimize z: sum{e in E, d in D, p in P} KSI[e]*delta[e,d,p]*x[d,p];

# Ograniczenia

s.t. c1{d in D} : sum{p in P} x[d,p] == h[d];

end;

