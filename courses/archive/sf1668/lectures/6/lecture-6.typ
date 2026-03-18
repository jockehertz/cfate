#set page(
  header: [#smallcaps[SF1668: Matematisk och numerisk analys I]]
)

#align(center)[
  #text(size: 24pt, [SF1668: Föreläsning 1])\
  #smallcaps[Implicit derivering, primitiva funktioner och extrempunkter] \
]\

= Implicit derivering 
Betrakta funktionen $F(x,y)$ i två variabler $x "och" y$, där följande gäller: \
$
F(x,y) = c | c in RR "(1)"
$
("Grafen" av detta visar nivålinjer av funktionen $F$)
*Mål*: beräkna lutningen av nivålinjen genom punkten $(x_0, y_0)$\
Om nivålinjen kring $(x_0, y_0)$ kan beskrivas som en graf av en funktion $f(x)$, kan detta göras genom att finna $frac(d, d x) f(x)$ \
Därifrån följer att $f$ uppfyller:
$
F(x, f(x)) = c 
$
$f$ kallas _implicit funktion_ för ekvation (1).

== Exempel 
Implicita funktioner för ekvationen
$
F(x,y) = x² + y² = c \
"är" f_±(x) = ±sqrt(c - x^2)
$

= Primitiva funktionen
Den primitiva funktionen, $F$, av en funktion, $f$, är definerad sådant att
$
frac(d, d x)F(x) = f(x) "och" F(x) in { f_("int") : f_("int") = integral f(x) }
$


