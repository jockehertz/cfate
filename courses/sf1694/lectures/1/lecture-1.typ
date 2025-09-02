#set page(
  header: [#smallcaps[SF1694: Tillämpad linjär algebra]],
)

#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"

#align(center)[
  \
  #text(size: 24pt, [SF1694: Föreläsning 1]) \

  #smallcaps[Vektorer]
  \
]\

= Definition
#text(size: 14pt, [_En vektor är en storhet som har både storlek och riktning_])\

=== Norm
Vektorns storlek representeras av _normen_, som noteras följande för en vektor $arrow(v)$:
$
  ||arrow(v)||
$

Den finns med formeln:
$
||arrow(v)|| = sqrt(v_x^2 + v_y^2)
$

=== Komponentform
En vektor kan representeras av dess ortogonala komponenter med följande syntax:
$
arrow(v) = vec(v_x, v_y)
$

== Parallella vektorer 
\
$
"En vektor" arrow(v) "är parallell med en vektor" arrow(u) "omm" t arrow(u) = arrow(v) "där" t in RR
$

= Algebra med vektorer

$
"Låt" arrow(v) = vec(v_1, v_2, dots.v, v_n) "samt" arrow(u) = vec(u_1, u_2, dots.v, u_n)
$

== Addition
$
arrow(v) + arrow(u) = vec(v_1 + u_1, dots.v, v_n + u_n)
$

== Subtraktion
$
arrow(v) - arrow(u) = arrow(u) + (-arrow(v))
$
#pagebreak()
== Multiplikation
=== Skalär-vektor multiplikation 
$
"Låt" t in RR \
t arrow(v) = vec(t v_1, dots.v, t v_n)
$

=== Vektor-vektor multiplikation 
 + *Skalärprodukt*
 Skalärprodukt noteras med $dot$, och heter just skalärprodukt då svaret är en skalär ($RR$) \
 Det finns två definitioner för skalärprodukt: \
 \
 *Definition 1.* 
 $
  arrow(v) dot arrow(u) = norm(arrow(v)) dot norm(arrow(u)) cos(theta) \
  "Där" theta "är vinkeln mellan" arrow(v) "och" arrow(u)\, "samt" theta in [0, pi]
 $
 
 *Definition 2.* 
 $
  arrow(v) dot arrow(u) = v_1 u_1 + v_2 u_2 + dots + v_n u_n 
 $

  2. *Vektorprodukt*
  Detta gås inte igenom den här föreläsningen. \

  == Projektion
  Projektionen av $arrow(u) "på" arrow(v)$ är vektorn 
  $
    "proj"_(arrow(v))arrow(u) = arrow(u)_v = 
    frac(arrow(u) dot arrow(v), norm(arrow(v))^2) dot arrow(v) = 
    (arrow(u) dot hat(v)) dot hat(v) "där" hat(v) = frac(arrow(v), norm(arrow(v)))
  $

  === Definition.
  Att $arrow(u)_v$ är _projektionen_ betyder att $arrow(u) - arrow(u)_v$ är det kortaste avståndet mellan punkten $P = (u_x, u_y)$ och linjen parallell med $arrow(v)$, d.v.s. $(arrow(u)-arrow(u)_v) "och" arrow(u)_v$ är vinkelräta.
