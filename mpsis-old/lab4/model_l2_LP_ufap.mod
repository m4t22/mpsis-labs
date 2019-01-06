# MPSiS 2018/2019
# Model L-P LAB2

# Zmienne indeksowe

param E_numb, integer, >= 0;
param D_numb, integer, >= 0;
param P_numb, integer, >= 0;
param K_numb, integer, >= 0;

param M, integer, default 10000;

# Deklaracja indeksowe

set E, default {1..E_numb};
set D, default {1..D_numb};
set P, default {1..P_numb};
set K, default {1..K_numb};

# Stale

param a{k in K} >= 0;
param b{k in K} >= 0;
param delta{e in E, d in D, p in P} >=0, default 0;
param h{d in D} >= 0;
param KSI{e in E} >= 0;
param w{e in E, p in P}, binary;

# Zmienna

var x{d in D, p in P} >=0;
var y{e in E} >=0;
var m{e in E, k in K} >= 0;
var u{e in E, k in K}, binary;

# Funkcja celu

#minimize z: sum{e in E, d in D, p in P} KSI[e]*delta[e,d,p]*x[d,p];
minimize z: sum{e in E, k in K}(m[e,k]*a[k] + u[e,k]*b[k]);

# Ograniczenia

s.t. c1{d in D} : sum{p in P} x[d,p] == h[d];
s.t. c2{e in E} : sum{k in K} m[e,k] == y[e];
s.t. c3{e in E} : sum{k in K} u[e,k] == 1;
s.t. c4{e in E, k in K} : m[e,k] <= M*u[e,k];

end;

