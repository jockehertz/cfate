#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"

#set page(
  header: [#smallcaps[SF1668: Matematisk och numerisk analys I]]
)

#align(center)[
  #text(size: 24pt, [SF1668: Föreläsning 3]) \

  #smallcaps[Kontinutitet] \
] \


= Definition \

$
"Låt" f: D_f -> V_f, c in D_f \
f in C <=> lim_(x -> c^-)(f(x)) = lim_(x -> c^+)(f(x))
$

=== I ord
Låt $f$ vara en funktion och $c$ vara ett element i $f$s definitionsmängd.
$f$ är då kontinuerlig omm vänstergränsvärdet av $f$ vid $c$ är detsamma som högergränsvärdet av $f$ vid $c$


= _Sats_

$
f, g in C[c] => cases(
  f plus.minus g in C[c],
  f dot g in C[c],
  k dot f in C[c] | k in RR,
  frac(f, g) in C[c] | g(c) != 0,
  f^frac(m, n) = (root(n, f))^m \, f^frac(m, n) in C[c] | m \, n in NN and f(c) >= 0 
) 
$

== Fakta

_Alla_ elementära funktioner är kontinuerliga.


= Utvidgning
$
f: X -> Y  \ c in.not X and f in C[c] and lim_(x -> 0) = L => F(x) = cases(f(x) \, &x!=c, L\, &x = c)
$

$F$ kallas då för den _kontinuerliga utvidgningen_ av $f$.


= Satser om kontinuitet 

== Sats om min/max 

$
f(x) in C[a, b] => exists p, q in [a, b] : f(p) <= f(x) <= f(p) forall x in [a, b]
$

== Sats om mellanliggande värde 
$
f in C[a,b], s in {[f(a), f(b)] union [f(b), f(a)]} : exists c in [a, b] : f(c) = s 
$
