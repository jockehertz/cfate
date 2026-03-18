#set document(title: [SF1668: Föreläsning 2])

#set page(
  header: [#smallcaps[SF1668: Matematisk och numerisk analys I]]
)

#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"

#align(center)[
  #text(size: 24pt, [SF1668: Föreläsning 2]) \

  #smallcaps[Gränsvärden] \

]

= Definition av gränsvärde 
\
$
forall epsilon > 0, exists delta > 0 : |f(x) - L| < epsilon,  forall x: 0 < |x-a| < delta 
$


= Oegentliga gränsvärden 

Oegentliga gränsvärden uppstår när en funktion går mot $oo$. Detta noteras genom att säga att funktionen är _lika med_ $oo$, trots att den aldrig kan vara det. Vi måste även specifiera om det är $+oo$ eller $-oo$.
$
lim_(x arrow 0) frac(1, x^2) = +oo
$


== Konvergens
Ponera följande funktion: 
$
lim_(x arrow oo) f(x) = L
$

Här säger vi att $f$ _konvergerar_ mot $L$, då $f$ aldrig kan bli lika med $L$.

\
= Räkneregler med gränsvärden
Gränsvärden följer vissa räkneregler

$
lim_(x arrow a)(f(x) + g(x)) = L + M \
lim_(x arrow a)(f(x) - g(x)) = L - M \
lim_(x arrow a)(f(x)g(x)) = L M \
lim_(x arrow a)(k f(x)) = k L \
lim_(x arrow a)(frac(f(x), g(x))) = frac(L, M) \
$


== För rationella funktioner
$
"Låt en rationell funktion" R(x) = frac(P(x), Q(x)) "där" P(x), Q(x) in QQ <=> R(x) in QQ \
"grad"(P) > "grad"(Q)
$





