#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"

#let quadratic(var) = {
  calc.pow(var, 2)
}
#set text(lang: "se")

#set page(
  header: [#smallcaps[SF1668: Matematisk och numerisk analys I]]
)
\
#align(center)[
  #text(size: 24pt, [SF1668: Föreläsning 7]) \
  #smallcaps[Inversa funktioner, exponentialfunktioner, logaritmer]
] \

= Inversa funktioner
== Injektivitet, surjektivitet och bijektivitet
=== Injektivitet <injective>
*Definition.* \
En funktion $f$ kallas injektiv omm
$
x_1 != x_2 => f(x_1) != f(x_2)
$
#align(center)[
  #figure(
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(size: (8,8), axis-style: "school-book", {
        plot.add(quadratic, domain: (-10, 10), label: [$f(x)$])
        plot.add-hline(64, label: [y = 64])
        plot.add-vline(-8, 8, label: [x = ±8])
      })

    }),
    supplement: [Figur],
    caption: [En injektiv funktion]
  ) <quadratic_equation>
]

== Inversa funktioner 
=== Definition.
Den inversa funktionen av $f$ noteras som $f^(-1)$ och defineras enligt följande:
$
f: X -> Y \
f^(-1)(f(x)) = x | f: Y -> X
$

#pagebreak()

=== Grafisk tolkning
$f^(-1)(x)$ är en spegling av $f(x)$ kring $y = x$ i xy-planet.
#align(center)[
  #figure(
    cetz.canvas({
      import cetz.draw: *
      import cetz-plot: *
      plot.plot(size: (8,8), axis-style: "school-book", 
      y-max: 9, y-min: 0,
      x-max: 9, x-min: 0,
      {
        plot.add(quadratic, domain: (0,9), label: [$f(x) = x²$])
        plot.add(calc.sqrt, domain: (0,9), label: [$f^(-1)(x) = sqrt(x)$], style: (stroke: (paint: red)))
        plot.add(((0,0), (9, 9)), label: [$y = x$], style: (stroke: (paint: olive, dash: "dashed")))
      })
    }),
    supplement: [Figur],
    caption: [$f$ och $f^(-1)$]
  )
]

= Exponentialfunktioner <exponentials>
== Definition.
För $a > 0, a^0 = 1, a^n = underbrace(a dot a dot dots dot a, n "gånger")$ 
$
exists a^r forall r in QQ | m in ZZ, n in NN ~> a^frac(m, n) = root(n, a^m) \
a^r "kan utvidgas kontinuerligt till" RR "enligt följande:" \
r in.not QQ, s in QQ\
a^r = lim_(s->r)a^s
$

== Derivata
=== Generell exponentialfunktion 
$
a > 0 \
a^y = (e^ln(a))^y = e ^(ln(a)y) \
=> frac(d, d y) a^y = frac(d, d y)(e^ln(a)y) = ln(a)e^(ln(a)y) = ln(a) dot a^y
$

= Logaritmer
== Definition.
$
"För" a>0, a!=1, "är" f(x) = log_a (x) = g^(-1)(y) | g(y) = a^y \
therefore y = log_a (x) <=> x = a^y \
therefore log_a compose a^x = x \
D_(log) = (0, oo), V_(log) = RR \
$
Uttalas _logaritmen med basis_ $a$

== Logaritmregler
$
&("i") log_a (1) = 0 \
&("ii") log_a (x y) =  log_a (x) + log_a (y) \
&("iii") log_a (frac(1, x)) = - log_a (x) \
&("iv") log_a (frac(x, y)) = log_a (x) - log_a (y) \
&("v") log_a (x^y) = y log_a (x) \
&("vi") log_a (x) = frac(log_b (x), log_b (a)))
$

= Eulers tal
== Definition.
$
e = lim_(n->oo)(1 + frac(1, n))^n = frac(1, 1!) + frac(1, 2!) + frac(1, 3!) + dots
$

== Naturliga exponentialfunktionen 
Den naturliga exponentialfunktionen kan noteras $e^x$ eller $"exp"(x)$.

=== Derivata
$
frac(d, d x) e^x = e^x 
$
Härledning:
$
"Anta" lim_(h->0) frac(e^h - 1, h) = 1 ". (2)" \
frac(d, d x) e^x = lim_(h -> 0) frac(e^(x+h) - e^x, h) = lim_(h -> 0) frac(e^x e^h - e^x, h) =
lim_(h -> 0) frac(e^x (e^h - 1), h) = e^x underbrace(lim_(h -> 0) frac(e^h - 1, h), "(2)") = e^x dot 1 = e^x 
$



