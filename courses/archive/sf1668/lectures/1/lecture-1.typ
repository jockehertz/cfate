#set document(title: [SF1668: Föreläsning 1])
#set page(
  header: [
    #smallcaps[SF1668: Matematisk och numerisk analys 1]
  ]
)
#align(center)[
  \ 
  #text(size: 24pt, [SF1668: Föreläsning 1]) \
  #smallcaps[Tal och funktioner] \ 
] \

= Notation 
== Talmängder

$
NN = {..., 1, 2, 3, ...} "Naturliga talen"\
ZZ = {..., -2, -1, 0, 1, 2, ...} "Heltalen" \
QQ = {frac(a,b) | a, b in ZZ, b != 0} "Rationella talen" \
RR = "Reella talen (definitionen känner jag inte till)" 
$

== Intervall

$
[1, 5] = {x in RR | 1<= x <= 5} \
[pi, 8) = {x in RR | pi <= x < 8 } \
(pi, 8) = {x in RR | pi < x < 8} \
(-oo, oo) = RR \
"OBS!" plus.minus oo "kan inte vara med i ett slutet intervall" \
NN in ZZ in QQ in RR
$

== Funktioner

_Definition:_ Låt $X, Y$ vara två mängder. En funktion, $f: X->Y$ associerar varje element $x in X$ till _ett_ element $y in Y$. \

$X$: Definitionsmängden av $f$, noteras $D_f$. \
$Y$: Värdemängden av $f$, noteras $V_f$. $
V_f = {f(x) | x in D_f }
$\

=== Definitionsmängder

$
f + g -> D_(f+g) = D_f inter D_g\
f - g -> D_(f-g) = D_f inter D_g\
f times g -> D_(f times g) = D_f inter D_g\
frac(f, g) -> D_frac(f, g) = (D_f inter D_g)\\ {0} \
f^g \
f compose g 
$

#pagebreak()
=== Elementära funktioner 
Följande funktioner är elementära:
$
  c "där" { c in RR }\
  x^p \
  e^x \
  cos(x) \
  sin(x) \

  f^(-1)(x) | f(x) "är en elementär funktion" \
  f compose g | f and g "är elementära funktioner" \
$

=== Styckvis delade funktioner
$
abs(x) = cases(
                x\, "om" x>=0,
                -x\, "om" x<0
          )

$

