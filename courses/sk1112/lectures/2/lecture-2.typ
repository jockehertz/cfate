#set document(title: [SK1112: Föreläsning 2])
#set page(
  header: [#smallcaps[SK1112: Fysik I]]
)

#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"
#import "@preview/easytable:0.1.0": easytable, elem

= Att beräkna fel
#align(center)[
  \
  #text(size: 24pt, [SK1112: Föreläsning 2]) \
  #smallcaps[Mätfel] \
  #figure(
    table(
      columns: 2,
      [*Nr*], [*$E_v "[lux]"$*],
      [1], [330],
      [2], [221], 
      [3], [246],
      [4], [244],
      [5], [240],
    ),
    caption: [Exempeltabell på mätvärden],
  ) <exampletable>
]
== Medelvärde 

Medelvärdet skrivs med ett streck över bokstaven, och finnes som följande:
$
overline(x) = frac(x_1 + x_2 dots x_n, n) "där" n in ZZ^+
$

== Standardavvikelse
Standardavvikelsen ($sigma$) finnes med följande ekvation:
$
sigma = sqrt(frac(x_1^2 + x_2^2 dots x_n^2, n-1))
$

== Fel hos medelvärdet
Felet hos medelvärdet finnes med detta: 
$
Delta overline(x) = frac(Delta x, sqrt(n)) \ 
"där:" \ 
Delta x "är standardavvikelsen av" x \
Delta overline(x) "är felet av medelvärdet av x"
$

== Exempel
Genom att använda datan från @exampletable:
$
overline(E)_v = frac(E_(v_1) + dots + E_(v_5), 5) = 256.2 "lux" \

Delta E_v = sqrt(frac(Delta E_(v_1)^2 + dots + Delta E_(v_5), 4)) = 42 "lux" \

Delta overline(E)_v = frac(42, sqrt(5)) approx 19 "lux" \

"ljusstyrka: " 256.2 plus.minus 19 "lux"
$

#pagebreak()
= Typer av fel
  + *Slumpmässiga fel* - Finns alltid! Reduceras med bra mätutrustning, noggranna mätningar och upprepade mätningar.

  + *Systematiska fel* - Ger samma fel varje gång. Dessa går att kompensera för.

  + *Teoreitiskt fel*
    + Experimentet påverkas inte endast av den teoretiska modellen som har valts
    + Teorin stämmer inte - tänk fram en ny.

  + *Slarv.*

== Två sätt att beräkna samma fel 
 + Absolut fel - Samma enhet som man mäter i.  Ex: $260 "lux" plus.minus 20 "lux"$
 + Relativt fel - Enhetslös. Ex: _$260$ lux med en osäkerhet på $7 percent$_ ($overline(E)_v = 260 "lux" plus.minus 7 percent$)


= Beräkna fel av funktion
Om vi har en variabel $x$ med ett fel på $plus.minus Delta x$, kan man finna felet av en funktion $f(x)$ på två sätt.

== Numerisk metod
Stoppa bara in värdena. 
$
Delta f(x) = f(x + Delta x) - f(x - Delta x)
$

== Analytisk metod
$
frac(d f, d x) approx frac(Delta y, Delta x) \
therefore Delta f approx abs(frac(d f, d x)) dot abs(Delta x) 
$
Det relativa felet i $f$ finnes med $frac(Delta f, f)$.

== För en potensfunktion av flera variabler
För en _potensfunktion_ $g(x, y, z) = x^a y^b z^c$ finnes det relativa felet som följer: 
$
  frac(Delta f, f) = sqrt(a^2(frac(Delta x, x))^2 + b^2(frac(Delta y, y))^2 + c^2(frac(Delta z, z))^2)
$


