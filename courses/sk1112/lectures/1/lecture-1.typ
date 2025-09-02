#set page(header: [#smallcaps[SK1112: Fysik I]])
#import "@preview/easytable:0.1.0": easytable, elem
#import "@preview/cetz:0.4.1"
#import "@preview/cetz-plot:0.1.2"
#import elem: *

#align(center)[
  \
  #text(size: 24pt)[SK1112: Föreläsning 1] \
  #smallcaps[Experimentiell metodik]
  \
]

= Modeller

== Naturvetenskaplig metod 
Den naturvetenskapliga metoden är baserad på experiment, med följande egenskaper:
 - Dokumentation
 - Reproducerbarhet
 - Logik

== Samhällsvetenskaplig metod 
Den samhällsvetenskapliga metoden är baserad på _studier_

== Annat
Det finns många andra modeller, dessa måste inte vara i strid med varandra, men de kan vara det.

= Kurvanpassning

== Rät linje
En rät linje följer formeln $y = a x + b$ där: 
 - $y$ är den beroende variabeln
 - $a "och" b$ är konstanter
 - $x$ är den oberoende variabeln
 
#align(center)[
#figure(
 cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    size: (8,8), 
    x-tick-step: 1, 
    y-tick-step: 1,
    x-grid: true, x-min: -5, x-max: 5,
    y-grid: true, y-min: -5, y-max: 5,
    axis-style: "school-book",
    {
      plot.add(((-5, -9), (3,7)), label: $y = 2x + 1$ )
    }
  )
 }),
 caption: [En rät funktion],
 ) <rat-funktion>
]

#pagebreak()



== Potensfunktion
En potensfunktion följer formeln $y = a x^b + c$ där:
 - $y$ är den beroende variabeln
 - $a "," b "och" c$ är konstanter 
 - $x$ är den oberoende variabeln
#align(center)[
#figure(
 cetz.canvas({
  import cetz.draw: *
  import cetz-plot: *
  plot.plot(
    size: (8, 8),
    x-tick-step: 1, x-grid: true, x-min: -5, x-max: 5,
    y-tick-step: 1, y-grid: true, y-min: -5, y-max: 5,
    axis-style: "school-book",
  
  {
    plot.add(domain: (-5, 5), calc.exp, label: $y = e^x$)
  })
 }),
 caption: [En potensfunktion]
 ) <potensfunktion>
]


=== Att finna potensfunktionen givet ett visst dataset
$
y = k x^b \
log(y) = log(a x^b) \
log(y) = log(a) + log(x^b)
$
Dessa blir nu en rät linje _omm_ funktionen det kommer ifrån är en potensfunktion. 
Lutningen på linjen kommer vara lika med b, och på så vis kan man finna graden av funktionen. \


