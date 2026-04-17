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
#kthblock("Elektromagnetism")[
  #table(
    stroke: none,
    columns: 3,
    table.header([*Matematisk notation*], [*Storhet*], [*Enhet*]),
    $q$,         [Laddning],                  [$[C]$],
    $e$,         [Elementära laddningen],     [$1.6 dot 10^(-19) space [C]$],
    $epsilon_0$, [Vakuumpermittivitet],       [$8.85 dot 10^(-12) space [F/m]$],
    $rho$,       [Volymladdningstäthet],      [$[C m^(-3)]$],
    $sigma$,     [Ytladdningstäthet],         [$[C m^(-2)]$],
    $lambda$,    [Linjär laddningstäthet],    [$[C m^(-1)]$],
    $U$,         [Potentialenergi],           [$J$],
    $V$,         [Potential],                 [$V$],
    $C$,         [Capacitans],                [$F$],
    $arrow(B)$,  [Magnetfältet],              [$T [N/(A m)]$],
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
#kthblock("Elektromagnetism")[
  #table(
    stroke: none,
    columns: 2,
    align: horizon,
    table.header([*Formel*], [*Beskrivning*]),
    [$arrow(F) = k (q_1 q_2)/r^2 | k = 1/(4 pi epsilon_0)$],                      [Coulombs lag],
    [$arrow(E) = 1/(4 pi epsilon_0) q_s/r^2 hat(r) | q_s "är källans laddning"$], [Formel för det elektriska fältet från en punktladdning],
    [$arrow(E)_"TOT" = sum_n arrow(E)(P_n)$],                                     [Elektriska fältet från flera punktladdningar],
    [$arrow(E) = lambda/(2 pi epsilon_0) 1/r hat(r)$],                            [Elektriska fältet från en oändligt lång linjär laddning],
    [$arrow(E) = sigma/(2 epsilon_0) hat(n)$],                                    [Elektriska fältet från en oändligt stor laddad platta],
    [$Phi_E eq.triple integral.double arrow(E) dot hat(n) space d A$],                    [Elektriska fältets flöde],
    [$Phi_E = integral.surf arrow(E) dot hat(n) space d A = integral.triple arrow(nabla) dot arrow(E) space d V$], [Gauss sats, tillämpad på elektriska fält],
    [$arrow(nabla) dot arrow(E) = rho/epsilon_0$], [Maxwells första ekvation, Gauss lag],
    [$Delta U eq.triple -q integral arrow(E) dot d arrow(r)$], [Potentialenergidifferens, definition],
    [$Delta V eq.triple (Delta U)/q = integral arrow(E) dot d arrow(r)$], [Potentialdifferens, definition],
    [$arrow(E) = - arrow(nabla) V$], [Relationen mellan potential och det elektriska fältet],
    [$C eq.triple Q/(Delta V) | Q "är lagrad ladding"$], [Capacitans, definition],
    [$C = (epsilon_r epsilon_0 A)/d$], [Capacitans utifrån area av och avstånd mellan två plattor, separerade av ett dielektrum med relativ permittivitet $epsilon_r$],
    [$C_"TOT" = sum_n C_n$], [Ekvivalent kapacitans för $n$ parallellkopplade kondensatorer],
    [$1/C_"TOT" = sum_n 1/C_n$], [Ekvivalent kapacitans för $n$ seriekopplade kondensatorer],
    [$U_C = Q^2/(2 C) = (C (Delta V)^2)/2$], [Energi lagrad i en kondensator],
    [$I eq.triple Phi_q = integral.double arrow(j) dot d arrow(A)$], [Definition av elektrisk ström],
    [$arrow(F) = q arrow(v) times arrow(B)$], [Kraften från ett magnetfält på en laddning med hastighet $arrow(v)$ relativt fältet],
    [$arrow(F) = I arrow(l) times arrow(B)$], [Kraften på en rak ledare med ström $I$ genom sig och längden $arrow(l)$ med riktning],
    [$arrow(F) = integral I arrow(d l) times arrow(B) = - integral I arrow(B) times arrow(d l)$], [Kraften på en godtycklig ledare $arrow(l)$]
)
]
