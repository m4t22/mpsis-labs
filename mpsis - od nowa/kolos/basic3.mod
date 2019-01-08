# MPSiS 2018/2019
# Model UFAP, N/L

/* Number of vertexes, edges, dispositions */
param V_count, integer, >= 0;	#wierzcholki
param E_count, integer, >= 0;	#luki
param D_count, integer, >= 0;	#zapotrzebowanie
param K_count, integer, >= 0;	# moduly

/* Sets of vertexes, edges and dispositions */	#zbiory po ktorych iterujemy
set V, default {1..V_count}; 
set E, default {1..E_count};
set D, default {1..D_count};
set K, default {1..K_count};	#modularnosc, K modulów

/* Zapotrzebowanie zwiazane z ruchem */	#macierze (tu akurat vektor)
param h{d in D} >= 0;	#wektor zawierajacy rozmiar zapotrzebowania
param s{d in D} >= 0;	#kazdemu zapotrzebowaniu przypiszemy wierzcholek gdzie startujemy
param t{d in D} >= 0;	#wezly docelowe
param m{k in K} >= 0;	#rozmiar modulu
param g{k in K} >= 0;	#koszt instalacji danego modulu

/* Aev, Bev as params */ #tu wystarcza wartosci binarne
param A{e in E, v in V}, >= 0, default 0;	#czy łącze sie zaczyna w wezle
param B{e in E, v in V}, >= 0, default 0;	#czy lacze sie konczy w wezle

# parametry modularności
param g{k in K} := 10*k; # koszt uruchomienia modułu
param m{k in k} := 100 * k; # pojemność modułu


/* Decision variables */	#slowo klucz to "var" (var jest tylko przy zmiennych)
var x{e in E, d in D} >= 0;	#mowi nam to ile ruchu przesylamy w ramach zapotrzebowania na danym laczu
var u{e in E, d in D}, binary;	#dla niezbifurkowanych, jeżeli na łączu jest jakiś ruch w danym zapotrzebowaniu to 1
var f{e in E, k in K}, integer, >= 0;		#modularnosc

/* Objective function 'z' */
minimize z: sum{e in E, k in K} f[e,k]*g[k]; # liczba modulow razy koszt

/* Constraints */
#suma tego co wychodzi ze zrodla (nic nie wplywa wiec =0) rowna sie zapotrzebowaniu
s.t. c1{d in D, v in V : v == s[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == h[d];
#prawo Kirchoffa dla wszytskich wezlow poza poczatkiem i koncem 
s.t. c2{d in D, v in V : v <> s[d] and v <> t[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == 0;#wszytsko to co wyplywa (pierwszy czlon to 0) minus to co wplywa ma wyniesc "minus" zapotrzebowanie
s.t. c3{d in D, v in V : v == t[d]} : sum{e in E} (A[e,v]*x[e,d] - B[e,v]*x[e,d]) == -h[d];
#na danej krawedzi to co przechodzi nie moze byc wieksze od wolumenu
#s.t. c4{e in E} : sum{d in D} x[e,d] <= c[e];

#dla niezbif:
#wezel poczatkowy- wszystko ma wyplynac jednym laczem
s.t. c5{d in D, v in V : v == s[d]} : sum{e in E} (A[e,v]*u[e,d]) <= 1;
#wezly tranzytowe- jednym laczem wplywa jednym wyplywa
s.t. c6{d in D, v in V : v <> s[d] and v <> t[d]} : sum{e in E} (A[e,v]*u[e,d]) <= 1;
s.t. c7{d in D, v in V : v <> s[d] and v <> t[d]} : sum{e in E} (B[e,v]*u[e,d]) <= 1;
#wezel koncowy- jednym laczem wplywa
s.t. c8{d in D, v in V : v == t[d]} : sum{e in E} (B[e,v]*u[e,d]) <= 1;
#jezeli na laczu e istnieje niezerowy ruch zapotrzebowania d to dla tego ruchu i dla tego zapotrzebowania wartosc u ma #sie ustawic na 1
s.t. c9{d in D,e in E} : x[e,d] <= M*u[e,d];

#modularnosc:
s.t. c10{e in E} : sum{d in D} x[e,d] <= sum{k in K} m[k]*f[e,k];
#dla modularnosci komentujemy c
