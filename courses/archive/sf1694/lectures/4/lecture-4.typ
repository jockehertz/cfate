#set page(
  header: [#smallcaps[SF1694: Tillämpad linjär algebra]]
)

\

#align(center)[
  #text(size: 24pt, [SF1694: Föreläsning 4]) \
  #smallcaps[Linjära ekvationssystem, fortsättning]
]
\
\
= Linjärkombination

== Definition.
$
arrow(b) "kallas för en linjärkombination av vektorerna" arrow(v)_1, arrow(v)_2, dots, arrow(v)_n "om" arrow(b) "kan skrivas:" \
arrow(b) = c_1 arrow(v)_1 + c_2 arrow(v)_2, dots, c_n arrow(v)_n \
"där" c_1, c_2, dots c_n in RR
$

== Exempel
$
arrow(a)_1 = vec(1, 0, 2), arrow(a)_2 = vec(2, -1, 1), arrow(b) = vec(5, -2, 4)
$

Är $arrow(b)$ en linjärkombination av $arrow(a)_1 "och" arrow(a)_2$? \

=== Lösning
Låt $s$ och $t$ vara parametrar, $arrow(b)$ är då en linjärkombination av $arrow(a)_1 "och" arrow(a)_2$ (ligger i planet som spänns upp av $arrow(a)_1 "och" arrow(a)_2$) omm:
$

s, t in RR \
s arrow(a)_1 + t arrow(a)_2 = arrow(b) \
s vec(1, 0, 2) + t vec(2, -1, 1) \


"Totalmatrisen skrivs då som följer:"\

mat(delim: "[",
arrow(a)_1, arrow(a)_2, arrow(b) 
) 
= 
mat(delim: "[", 
  1, 2, 5;
  0, -1, -2;
  2, 1, 4
)\

"Efter Gauss-Jordan elimination ges följande lösningsmatris:"\
mat(delim: "[",
  1, 0, 1;
  0,1,2;
  0,0,0
)\

"Ur denna kan avläsas att:"\
cases(
  s = 1,
  t = 2
)\
"Vilket ger:"\
arrow(b) = arrow(a)_1 + 2 arrow(a)_2

$

= Spann
Spannet (även _linjära höljet_) av vektorerna $arrow(a)_1 "och" arrow(a)_2$ är följande mängd:
$
"Span"(arrow(a)_1, arrow(a_2)) = {arrow(v) |
  arrow(v) = c_1 arrow(a)_1 + c_2 arrow(a)_2 "där"
  arrow(a)_1, arrow(a)_2 in RR^2 and c_1, c_2 in RR }
$


