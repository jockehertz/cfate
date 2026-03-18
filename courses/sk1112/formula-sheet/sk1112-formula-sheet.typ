#import "./lib.typ": *

 // PREAMBLE

#set document(
  author: "Joakim Hertzberg",
  title: [Formelblad för SK1112: Fysik I])
#set text(lang: "se", font: kth.fonts.sans)
#set page()


#show title: set text(fill: kth.colors.blue, font: kth.fonts.sans, size: kth.text-size.title, weight: 700)

#align(center)[
  #title() \
  Joakim Hertzberg \
]

// CONTENT
#show heading: set text(fill: kth.colors.blue, font: kth.fonts.sans)

= Storheter och enheter

#kthblock("Vågrörelselära")[
  #table(
    stroke: none,
    columns: 3,
    table.header([*Matematisk notation*], [*Storhet*], [*Enhet*]),
    $s_0$,    [Högsta amplitud],     [Beror på vågen],
    $delta$,  [Vänsterförskjutning], $[m]$,
    $k$,      [Vinkelrepetens],      $["rad" m^(-1)]$,
    $omega$,  [Vinkelhastighet],     $["rad" s^(-1)]$,
    $rho$,    [Densitet],            $["Kg" m^(-3)]$,
    $c$,      [Våghastighet],        $[m s^(-1)]$,
    $rho c$,  [Aukutisk impedans],   $["Kg" m^(-1) s^(-1)]$,
  )
]

#pagebreak()

= Formler
#kthblock("Vågrörelselära")[
  #table(
    stroke: none,
    columns: 2,
    table.header([*Formel*], [*Beskrivning*]),
  $s = s_0 sin(k x - omega t + delta) = s_0 sin( (2 pi) / lambda x - (2 pi) / T t + delta)$, [Amplituden av vågen vid ett  \ visst läge och en viss tidpunkt],
  $v = (partial s)/(partial t) = - omega s_0 cos(k x - omega t + delta)$, [Partikelhastighet],
  $I = 1/2 omega^2 s_0^2 rho c$, [Ljudintensitet],
  $I = P/(4 pi r^2) e^(alpha r)$, [Ljudintensitet från ljudeffekt]

)
]
