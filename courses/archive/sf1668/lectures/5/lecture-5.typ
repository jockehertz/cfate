#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"

#set page(
  header: [#smallcaps[SF1668: Matematisk och numerisk analys I]]
)

\
#align(center)[
  #text(size: 24pt, [SF1668: Föreläsning 5]) \
  #smallcaps[Tillämpningar av derivata] \
] \

= Att finna tangenten

== Enpunktsformen för räta linjen
För en linje $L_1$ som skär punkten $(a, b)$ med lutningen $k$ kan den skrivas på följande sätt:

$
  y = k(x-a)+b
$

Med hjälp av den här formen kan tangenten till vilken funktion som helst i punkten $x = a$ finnas som följer:
$
  y = f'(a)(x-a)+f(a)
$
\


=== Märk väl!
Enpunktsformsmetoden för att finna den linjära ekvationen som uppfyller tangenten med derivatan är ett första gradens taylorpolynom. Här är den allmänna formen för ett taylorpolynom:
$
f(x) = f(a) + frac(frac(d, d x)f(a), 1!)(x-a) + frac(frac(d², d²x)f(a), 2!)(x-a)^2 + dots + frac(frac(d^n, d^n x)f(a), n!)(x-a)^n
$

#pagebreak()
= (Strängt) växande och avtagande funktioner
== Strängt växande
=== Definition.
Anta $f: D_f -> V_f, I in D_f$ där $I$ är ett intervall. $f$ är då strängt växande _på $I$_ omm: \
$
  forall x_1, x_2 in I : x_1 < x_2 => f(x_1) < f(x_2)
$

== Växande
=== Definition.
Anta $f: D_f -> V_f, I in D_f$ där $I$ är ett intervall, $f$ är då växande _på $I$_ omm: \
$
forall x_1, x_2 in I: x_1 < x_2 => f(x_1) <= f(x_2)
$

== Avtagande
=== Definition.
Anta $f: D_f -> V_f, I in D_f$ där $I$ är ett intervall, $f$ är då avtagande _på $I$_ omm:
$
forall x_1, x_2 in I : x_1 < x_2 => f(x_1) >= f(x_2)
$

== Strängt avtagande
=== Definition.
Anta $f: D_f -> V_f, I in D_f$ där $I$ är ett intervall, $f$ är då strängt avtagande _på $I$_ omm: \
$
forall x_1, x_2 in I: x_1 < x_2 => f(x_1) > f(x_2)
$


== Hur man räknar på (strängt) växande eller avtagande

$
  forall x in I: f'(x) > 0 => f "är strängt växande i intervallet" I \
  forall x in I: f'(x) >= 0 => f "är växande i intervallet" I \
  forall x in I: f'(x) <= 0 => f "är avtagande i intervallet" I \
  forall x in I: f'(x) < 0 => f "är strängt avtagande i intervallet" I \
$



