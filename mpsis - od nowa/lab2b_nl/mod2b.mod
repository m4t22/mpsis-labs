# MPSiS 2018/2019
# Model 1a

/* Number of variables */
param E_n, integer, >= 1; # liczba lukow 
param V_n, integer, >= 1; # liczba wezlow
param D_n, integer, >= 1; # liczba zapotrzebowan

/* Set of variable indices */
set E, default {1..E_n};
set V, default {1..V_n};
set D, default {1..D_n};

/* Constants */
param h{d in D}, >= 0;
param KSI{e in E}, >= 0;
param s{d in D}, >= 0;
param t{d in D}, >= 0;
param c{e in E}, >= 0, default 10;

/* matrixes */
param a{e in E, v in V}, binary, default 0;
param b{e in E, v in V}, binary, default 0;

/* Decision variables */
var x{e in E, d in D} >= 0;

/* Objective function 'z' */
minimize z: sum{e in E}(KSI[e]*sum{d in D}x[e,d]);

/* Constraints */

s.t. C1{d in D, v in V : v == s[d]}: sum{e in E}a[e,v]*x[e,d] - sum{e in E}b[e,v]*x[e,d] == h[d];
s.t. C2{d in D, v in V : v <> s[d] and v <> t[d] }: sum{e in E}a[e,v]*x[e,d] - sum{e in E}b[e,v]*x[e,d] == 0;
s.t. C3{d in D, v in V : v == t[d] }: sum{e in E}a[e,v]*x[e,d] - sum{e in E}b[e,v]*x[e,d] == -h[d];
s.t. C4{e in E}: sum{d in D}x[e,d] <= c[e];

end;
