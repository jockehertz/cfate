#import "lib.typ": *
#import "@preview/cetz:0.4.2"

 // PREAMBLE
// The orcid image is supposed to be 24px, that is equivalent to 18pt
#set document(
  author: "Joakim Hertzberg",
  title: [IS2 SG1132])
#set text(lang: "sv")
#set page()
#show title: set text(
  font: kth.fonts.sans,
  fill: kth.colors.blue,
)


#align(center)[
  #title() \
  #text(font: kth.fonts.sans)[
    Joakim Hertzberg \
    #datetime.today().display() \
  ]
]

#problem(3.66)[
  En lucka med längden $2b$ och bredden $a$ och bildar vinkeln $beta$ mot det stängda läget i horisontalplanet. Kedjan som håller luckan uppe går från en punkt $A$ i hörnet på luckan till en punkt $B$ som ligger på höjden $h = a$ över mittpunkten på luckans gångjärnskant. *Bestäm storleken av kraften i kedjan om gångjärnen är glatta*.
]

Givet att gångjärnen utgör reaktionsmoment längs x- och y-axeln, samt reaktionskrafter i alla riktningar är huvudkravet för jämvikt här att momentet kring z-axeln från gravitationskraften $F_g$ ska balanseras kedjans spännkraft $S$. D.v.s: $arrow(M_g) + arrow(M_S) = 0$. Vi kan då börja med att betrakta systemet i genomskärning i xy-planet.
#figure(caption: [Luckan i genomskärning i xy-planet])[
    #cetz.canvas({
    import cetz.draw: *
    let a = 7
    let A = ((calc.sqrt(3)*a)/2,a/2)
    content(A, [$A = ((sqrt(3)a)/2, a/2)$], anchor: "west", padding: 0.5)
    let B = (0, a)
    content(B, [$B = (0, a)$], anchor: "south", padding: 0.5)
    line((0,0), A, stroke: 4pt, name: "lucka")
    line(A, B, name: "kedja")

    line((0, 0), (a, 0), stroke: (dash: "dashed"))
    content((a/2, 0), [$a$], anchor: "north", padding: 0.5)

    line((0,0), (0, a), stroke: (dash: "dashed"))
    content((0, a/2), [$a$], anchor: "east", padding: 0.5)

    cetz.angle.angle((0,0), (a,0), "lucka", radius: 2, label: $beta$)

    let G = ((calc.sqrt(3)*a)/4, a/4)
    content(G, [$G = ((sqrt(3)a)/4, a/4)$], anchor: "south-east")

    line(G, ((calc.sqrt(3)*a)/4, 0), mark: (end: ">>"), stroke: (paint: kth.colors.dark-brick))
    content(G, [$m g$], anchor: "north-west", padding: 0.5)

    line(A, (0, a/2), stroke: (dash: "dashed"), name: "divisor")
    cetz.angle.angle("kedja.start", "kedja.end", "divisor", radius: 2, label: $beta$)
    cetz.angle.angle("divisor.start", "divisor.end", "lucka", radius: 2, label: $beta$)

    line(((calc.sqrt(3)*a)/2, 0), ((calc.sqrt(3)*a/2), a), stroke: (dash: "dashed"))
    content(((calc.sqrt(3)*a)/2, a/4), [$a/2$], anchor: "east", padding: 0.5)
    content(((calc.sqrt(3)*a)/2, 3*a/4), [$a/2$], anchor: "west", padding: 0.5)
    line(B, ((calc.sqrt(3)*a)/2, a), stroke: (dash: "dashed"))
    arc("lucka.end", start: 30deg, stop: 0deg, radius: a, stroke: (dash: "dotted"))
  })
]<fig-1>

Vi kan nu utifrån @fig-1 härleda att: 
$
arrow(M_g) = sqrt(3)/4 m g a 
$

Då endast x-kompasanten av $arrow(r_(O G))$ är rätvinklig mot tyngdkraften. Nu finner vi komposanten av spännkraften som är rätvinklig mot luckan:

$
sin(2 beta) = S_perp / S_(x y) => S_perp = sin(2 beta) S_(x y) = sin(pi/3)S_(x y) = sqrt(3)/2 S_(x y)
$
Sedan finner vi längden på luckans hävarm, som är bredden av luckan, vilket är definerat som $a$, och multiplicerar med $S_perp$:
$
arrow(M_S) = a sqrt(3)/2 S_(x y)
$

Sedan får vi:
$
|arrow(M_g)| = |arrow(M_S)| <=> sqrt(3)/4 m g a = sqrt(3)/2 a S_(x y) \
(m g)/2 = S_(x y)
$

Därefter finner vi riktningsvektorn för kedjan:
$
arrow(e_(A B)) = 1 / (|arrow(r_(A B))|) arrow(r_(A B)) \

arrow(r_(A B)) = arrow(r_(O B)) - arrow(r_(O A)) = vec(0, a, 0) - vec((sqrt(3)a)/2, a/2, b) = vec(- (sqrt(3)a)/2, a/2, -b) \

|arrow(r_(A B))| = sqrt(3/4a^2 + a^2/4 + b^2) = sqrt(a^2 + b^2) \

therefore arrow(e_(A B)) = 1/sqrt(a^2 + b^2) vec(-(sqrt(3)a)/2, a/2, -b)
$

#pagebreak()
Vi vet att den totala spännkraftens storlek $S$ gånger den här vektorn, projicerat på xy-planet blir spännkraften i xy-planet som vi beräknat:
$
| "proj"_(x y)( S arrow(e_(A B)) ) | = |arrow(S_(x y))| = (m g)/2 \
"proj"_(x y) (arrow(e_(A B))) = 1/sqrt(a^2 + b^2) vec(- (sqrt(3)a)/2, a/2, 0) \
therefore S_(x y) = S/sqrt(a^2 + b^2) abs(vec(- (sqrt(3)a)/2, a/2, 0)) = (m g)/2 \
S / sqrt(a^2 + b^2) sqrt(3/4 a^2 + a^2/4) = (m g) / 2 \
S / sqrt(a^2 + b^2) a = (m g)/2 \
S a = (m g)/2 sqrt(a^2 + b^2) \ 
S = (m g)/2 1/a sqrt(a^2 + b^2) \
S = (m g)/2 sqrt(1/a^2 (a^2 + b^2)) \
S = (m g)/2 sqrt(1 + (b/a)^2)
$






#pagebreak()

#problem(2.49)[
  En plan cirkulär skiva roterar med vinkelhastigheten $omega$ kring en vertikal axel i skivans centrum. I skivan finns en cirkulärt spår med radien $b$. Spårets väggar lutar med vinkeln $alpha$ respektive $beta$ mot skivans plan. En stålkula med massan $m$ och radien $R$ placersa i spåret och den ligger stilla relativt skivan om vinkelhastigheten $omega$ är konstant. *Bestäm de normalkrafter som verkar på kulan*.
]
#figure(caption: [Kulan i spåret på cirkelskivan, frilagd])[
#cetz.canvas({
  import cetz.draw: *
  let R = 2 
  let b = 5 
  let alph = calc.pi/4 
  let bet = calc.pi/6
  circle((0,0), radius: R, name: "kula")
  line((-calc.sqrt(R), -calc.sqrt(R)), (-calc.sqrt(0.5), -calc.sqrt(0.5)), mark: (end: ">>"), stroke: (paint: kth.colors.dark-brick), name: "na")
  content((-calc.sqrt(0.5), -calc.sqrt(0.5)), [$N_alpha$], anchor: "south", padding: 0)

  line((calc.sqrt(R/2), -calc.sqrt(3*R/2)), (calc.sqrt(0.5/2), -calc.sqrt(3*0.5/2)), mark: (end: ">>"), stroke: (paint: kth.colors.dark-green), name: "nb")
  content((calc.sqrt(0.5/2), -calc.sqrt(3*0.5/2)), [$N_beta$], anchor: "south", padding: 0)

  line((0,0), (0, -1), mark: (end: ">>"), stroke: (paint: kth.colors.dark-turquoise))
  content((0,-1), [$F_g$], anchor: "north", padding: 0.25)

  line((0,0), (1, 0), mark: (end: ">>"), stroke: (paint: kth.colors.dark-yellow))
  content((1,0), [$F_c$], anchor: "west", padding: 0.25)

  line(
    (-calc.sqrt(R), -calc.sqrt(R)),
    (-calc.sqrt(R), calc.sqrt(R)),
    stroke: (dash: "dashed"),
    name: "construction_a"
  )

  line(
    (calc.sqrt(R/2), -calc.sqrt(3*R/2)),
    (calc.sqrt(R/2), calc.sqrt(3*R/2)),
    stroke: (dash: "dashed"),
    name: "construction_b"
  )

  cetz.angle.angle("na.start", "na.end", "construction_a", label: $alpha$, radius: 1)
  cetz.angle.angle("construction_b.start", "construction_b.end", "nb", label: $beta$, radius: 1)

})
]<fig-2>

I kulans referensram bildas en centrifugalkraft $F_c$, samt två normalkrafter från ytan $N_alpha, N_beta$, och en tyngdkraft $F_g$. Se @fig-2. Här antas glatta kontakter.

*Känt:*
 - $F_g = m g$
 - $F_c = m(omega b)^2/b = m omega^2 b because v := omega r and a = v^2/r and F = m a$

Att systemet är i vila ger balansekvationerna:
#math.equation(numbering: "(1)", block: true,
$N_(alpha x) - N_(beta x) + F_c = 0$
)<balance-x>

#math.equation(numbering: "(1)", block: true,
$N_(alpha y) + N_(beta y) - F_g = 0$
)<balance-y>

$
N_(alpha x) = N_alpha sin(alpha), quad N_(alpha y) = N_alpha cos(alpha) \
N_(beta x) = N_beta sin(beta), quad N_(beta y) = N_beta cos(beta)\
$

@balance-x och @balance-y ger: 
$
cases(
  N_alpha sin(alpha) - N_beta sin(beta) + m omega^2 b = 0,
  N_alpha cos(alpha) + N_beta cos(beta) - m g = 0
)
$

#pagebreak()
Vi adderar @balance-x multiplicerat med $cos(beta)$ och @balance-y multiplicerat med $sin(beta)$ för att få bort $N_beta$:

$
cos(beta) (N_alpha sin(alpha) - N_beta sin(beta) + m omega^2 b) + sin(beta) (N_alpha cos(alpha) + N_beta cos(beta) - m g) = 0 \

N_alpha sin(alpha) cos(beta) - N_beta sin(beta) cos(beta) + m omega^2 b cos(beta) + N_alpha cos(alpha) sin(beta) + N_beta cos(beta) sin(beta) - m g sin(beta) = 0 \

N_alpha sin(alpha) cos(beta) + N_alpha cos(alpha) sin(beta) + m omega^2 b cos(beta) - m g sin(beta) = 0 \
N_alpha (sin(alpha)cos(beta) + cos(alpha)sin(beta)) = m g ( sin(beta) -  (omega^2 b)/g cos(beta)) \

because sin(u + v) = sin(u)cos(v) + sin(v)cos(u) \
N_alpha (sin(alpha + beta)) = m g (sin(beta) - (omega^2 b)/g cos(beta)) \

N_alpha = m g (sin(beta) - (omega^2 b)/g cos(beta))/sin(alpha + beta)
$

Nu subtraherar vi @balance-x multiplicerad med $cos(alpha)$ med @balance-y multiplicerad med $sin(alpha)$ för att få bort $N_alpha$:

$
cos(alpha) (N_alpha sin(alpha) - N_beta sin(beta) + m omega^2 b) - sin(alpha) (N_alpha cos(alpha) + N_beta sin(beta) - m g) = 0 \

N_alpha sin(alpha) cos(alpha) - N_beta sin(beta) cos(alpha) + m omega^2 b cos(alpha) - N_alpha cos(alpha) sin(alpha) - N_beta cos(beta) sin(alpha) + m g sin(alpha) = 0 \
- N_beta sin(beta) cos(alpha) - N_beta cos(beta) sin(alpha) + m omega^2 b cos(alpha) + m g sin(alpha) = \
m g sin(alpha) + m  omega^2 b cos(alpha) = N_beta (sin(beta) cos(alpha) + cos(beta) sin(alpha)) \

because sin(u + v) = sin(u)cos(v) + sin(v)cos(u) \

m g ( sin(alpha) + (omega^2 b)/g cos(alpha) ) = N_beta sin(alpha+beta) \

N_beta = m g ( sin(alpha) + (omega^2 b)/g cos(alpha))/sin(alpha + beta) \
$

#pagebreak()

#problem(2.32)[
  En bil körs på en cirkulär provbana med kröknigsradien $R = 100 m$. Den startar från vila i $A$ med ett gaspådrag som ger den konstanta accelerationen $a_0 = 0.3g$, där tygndaccelerationen är $g = 10 m s^(-2)$. Bestäm efter hur lång sträcka $s_1$ som bilen förlorar greppet, om friktionstalet är $mu = 0.5$. Bilen kan betraktas som liten. Undvik att räkna med tiden genom att skriva 
  $
    (d v) / (d t) = v (d v) / (d s)
  $
]

*Känt:*
 - $g = 10 m space s^(-2)$
 - $a_0 = 0.3g space m s^(-2)$
 - $mu = 0.5$
 - $R = 100 space m$

 Bilen glider när nettokraften på den överskrider friktionskraften:
 $
  F_"tot" = mu m g \
  F_"tot" = m a_"tot" \
  therefore a_"tot" = mu g \
  a_"tot" = sqrt(a_0^2 + a_r^2) "då" a_0 "är den tangentiella accelerationen, och " a_r "den radiella." \

  because a_r = v^2/R \

  mu g = sqrt(a_0^2 + v^4/R^2) \
  (mu g)^2 = a_0^2 + v^4/R^2 \
  (mu g)^2 - a_0^2 = v^4/R^2 \
  R^2((mu g)^2 - a_0^2) = v^4 \
 $
 Ovan är då villkoret som avgör när bilen börjar glida.
 $
  because (d v)/(d t) = v (d v)/(d s) and (d v)/(d t) = a_"tot" \
  v (d v)/(d s) = a_0 => v^2 = 2 a_0 s => v^4 = 4 a_0^2 s^2 \
  therefore R^2(mu^2 g^2 - a_0^2) = 4 a_0^2 s^2 \
  (R^2)/(4a_0^2)(mu^2 g^2 - a_0^2) = s^2 \
  s^2 = R^2/4 ( (mu^2 g^2)/(a_0^2) - (a_0^2)/(a_0^2)) \
  s^2 = R^2/4 ( (mu^2 g^2)/(a_0^2) - 1) \
  s = R/2 sqrt((mu^2 g^2)/a_0^2 - 1)
 $
 Substituera $mu = 0.5, g = 10, a_0 = 3, R = 100$:
 $
  s = 100/2 sqrt((0.25 dot 100)/9 - 1) \
  s = 50 sqrt(25/9 - 1) \
  s = 50 sqrt(16/9) \
  s = 50 dot 4/3 \
  s = 200/3
 $

#pagebreak()

#problem(3.50)[
  En plan partikelpendel med massan $m$ och längden $l$ släpps från vila då tråden bildar vinkeln $60 degree$ ($pi/3$ rad) med vertikalen. I nedersta läget slår pendeltråden mot en fix dubb $D$ på avståndet $l/2$ rakt under upphängningspunkten $O$. Pendeln fortsätter sin rörelse, men med kortare pendellängd. *Bestäm som funktion av vinklen $theta$ den kraft, som pendeltråden utövar på dubben*.
]

#figure(caption: [Pendeln])[
  #cetz.canvas({
    import cetz.draw: *
    let O = (0,0)
    let l = 6
    let D = (0, -l/2)
    let ball_radius = 0.3
    let stud_radius = 0.1
    let angle_a = calc.pi/3
    let angle_theta = calc.pi/6
    
    line((-l*calc.sin(angle_a),-l/2), (l*calc.sin(angle_a), -l/2), stroke: (dash: "dashed"))
    // PENDULUM
    line(O, (l*calc.sin(angle_a), -l*calc.cos(angle_a)), name: "pendulum_start")
    line("pendulum_start.end", (l*calc.sin(angle_a), -l), stroke: (dash: "dashed"), name: "h1")
    content("h1", [$h_1$], anchor: "east", padding: .1)
    content((l/2 * calc.sin(angle_a), -l/2*calc.cos(angle_a)), [$l$], anchor: "south-west", padding: .1)
    circle("pendulum_start.end", radius: ball_radius, fill: kth.colors.dark-brick)
    circle((0, -l), radius: ball_radius, stroke: (dash: "dashed"), fill: kth.colors.dark-brick)

    line(O, (0, -l), stroke: (dash: "dashed"), name: "vline")
    line((-l*calc.sin(angle_a), -l), (l*calc.sin(angle_a), -l), stroke: (dash: "dashed"))

    // STUD
    circle((-stud_radius, -l/2), (0, -l/2), fill: kth.colors.grey, name: "stud")

    line(O, (0, -l/2))

    let P = (
      (-stud_radius*calc.sin(angle_theta)),
      (-l/2 - stud_radius*calc.cos(angle_theta))
    )

    let P_2 = (
      (-stud_radius*calc.sin(angle_theta/2)),
      (-l/2 - stud_radius*calc.cos(angle_theta/2))
    )

    let ball_point_2 = (
      (-(l/2)*calc.cos(angle_theta)),
      (-l/2 - (l/2)*calc.sin(angle_theta))
    )

    line(ball_point_2, ((-(l/2)*calc.cos(angle_theta)), -l), stroke: (dash: "dashed"), name: "h2")

    content("h2", [$h_2$], anchor: "west", padding: .1)
    line(P, ball_point_2, name: "line_2")
    circle(ball_point_2, radius: ball_radius, fill: kth.colors.dark-brick, name: "ball_2")

    cetz.angle.angle("vline.start", "vline.end", "pendulum_start", radius: 1, label: [$pi/3$])

    cetz.angle.angle("line_2.start", "line_2.end", "vline.end", label: [$theta$], radius: 1)


    content(O, [$O$], anchor: "south-east", padding: .1)
    content((0, -l/2), [$D$], anchor: "north-west", padding: .1)
    content((0, -l/4), [$l/2$], anchor: "east", padding: .1)
    arc("pendulum_start.end", radius: l, start: -30deg, stop: -90deg, stroke: (dash: "dashed"))
    arc((0, -l), radius: l/2, start: -90deg, stop: -150deg, stroke: (dash: "dashed"))

    line(ball_point_2, 
      (
        ball_point_2.at(0) + calc.cos(calc.pi/6),
        ball_point_2.at(1) + calc.sin(calc.pi/6)
      ),
      mark: (end: ">>"),
      stroke: (paint: kth.colors.dark-yellow),
      name: "fr"
    )
    content("fr.end", [$arrow(F_r)$], anchor: "south-east", padding: .1)
    line(ball_point_2, (ball_point_2.at(0), ball_point_2.at(1) - 1),
  mark: (end: ">>"), stroke: (paint: kth.colors.dark-green), name: "fg")
    content("fg.end", [$arrow(F_g)$], anchor: "east", padding: .1)

    line(
      P_2, 
      (
        (P_2.at(0) - calc.sin((calc.pi - angle_theta)/2)),
        (P_2.at(1) + calc.cos((angle_theta)/2))
      ),
      mark: (end: ">>"),
      stroke: (paint: kth.colors.dark-turquoise),
      name: "fd"
  )

  content("fd.end", [$F_D$], anchor: "south-west", padding: .1)

  })

]
\

#figure(caption: [Friläggning av dubben])[
  #cetz.canvas({
    import cetz.draw: *
    let O = (0,0)
    let R = 2
    circle(O, radius: R, fill: kth.colors.grey)
    line((R, 0), (R, R), mark: (end: ">>"), name: "fr_top", stroke: (paint: kth.colors.dark-yellow))
    content("fr_top.end", [$arrow(F_r)$], anchor: "south", padding: .1)

    let down_angle = -3*calc.pi/4
    let F_r_bottom = (R*calc.cos(-calc.pi/4) + 2*calc.cos(down_angle), R*calc.sin(-calc.pi/4) + 2*calc.sin(down_angle))
    line(
      (R*calc.cos(-calc.pi/4), R*calc.sin(-calc.pi/4)),
      F_r_bottom,
      mark: (end: ">>"),
      stroke: (paint: kth.colors.dark-yellow),
      name: "fr_bottom"
    )
    content("fr_bottom.end", [$arrow(F_r)$], anchor: "north-east", padding: .1)

    line(
      (R*calc.cos(-calc.pi/8), R*calc.sin(-calc.pi/8)),
      (
        (2*calc.cos(down_angle) + calc.sqrt(R)),
        (2*calc.sin(down_angle) + calc.sqrt(R))
      ),
      mark: (end: ">>"),
      stroke: (paint: kth.colors.dark-turquoise),
      name: "fd"
    )
    content("fd.end", [$F_D$], anchor: "south-east", padding: .1)
  })
]<fig-4>

Vid botten av pendelrörelsen kommer pendelns rörelseenergi vara lika med lägesenergin i början. D.v.s: 
$
(m v^2)/2 = m g h_1
$

Det kan vi räkna ut genom att finna $h_1$

$
h_1 = l - l cos(pi/3) = l/ 2 \
therefore (m v^2)/2 = m g l/2 => v = sqrt(g l) "vid botten av rörelsen."
$

$arrow(F_r)$ kan skrivas om som:
$
F_r arrow(e_r) \
arrow(e_r) = vec(sin(theta), cos(theta)) => F_r arrow(e_t) = F_r vec(sin(theta), cos(theta))
$
Eftersom det är en cirkelrörelse kan summan av alla radiella krafter skrivas som $m v^2/r$:
$
F_r - m g cos(theta) = m v^2 /(l/2) =2 m v^2 / l \
F_r = m (2 v^2 / l + g cos(theta)) \
a_r = 2 v^2/l + g cos(theta)
$
Nu finner vi $v(theta)$. Konservation av energi ger:
$
E = (m g l)/2 "konserveras" \
therefore (m g l)/2 = (m v^2)/2 + m g h_2 \
h_2 = l/2 - l/2 cos(theta) = l/2(1 - cos(theta)) \
(m g l)/2 = (m v^2)/2 + m g l/2(1 - cos(theta)) \
m g l = m v^2 + m g l(1 - cos(theta)) \
g l = v^2 + g l(1-cos(theta)) \
g l - g l(1-cos(theta)) = v^2 \
g l cos(theta) = v^2 \
sqrt(g l cos(theta)) = v
$
Detta ger:
$
a_r = 2 (g l cos(theta))/l + g cos(theta)\
a_r = 2 g cos(theta) + g cos(theta)\
F_r = 3 m g cos(theta)
$

#pagebreak()
Från @fig-4 får vi att:
$
arrow(F_D) = -F_r arrow(e_r) + F_r arrow(e_y) = F_r (arrow(e_y) - arrow(e_r)) \
arrow(F_D) = 3 m g cos(theta)(vec(0, 1) - vec(sin(theta), cos(theta))) \
arrow(F_D) = 3 m g cos(theta)vec(-sin(theta), 1 - cos(theta)) \
F_D = 3 m g cos(theta)sqrt(sin^2(theta) + 1 - 2 cos(theta) + cos^2(theta)) \
F_D = 3 m g cos(theta)sqrt(2 - 2 cos(theta))
$
Det maximala värdet på $theta$ fanns inte med i frågan, men eftersom det finns i facit löser jag det här också. Konservation av energi ger att kulan kommer stanna precis då all rörelseenergi har övergått i lägesenergi:
$
v = sqrt(g l) and (m v^2) / 2 = m g h_2 => (m g l)/2 = m g h_2 \
l/2 = h_2 \
because h_2 = l/2 - l/2 cos(theta) \
l/2 = l/2 - l/2 cos(theta) \
cos(theta) = 0 \
theta = pi/2
$


#pagebreak()

#problem(5.11)[
  En liten kula med massan $m$ kan röra sig på en glatt horisontell bordsskiva och sitter fast i en tråd som går genom ett litet hål i bordet. Rörelsen kontrolleras genom att tråden med en kraft S dras ner och upp genom bordet så att bankkurvan blir en ellips. Största och minsta avstånd från hålet är $a$ respektive $b$. *Bestäm trådkraften i läget $B$ om kulan har farten $v_A$ i läget $A$*. Ellipsens krökningsradie i $B$ är $a^2/b$.
]

Det är känt att spännkraften $S$ agerar som centripetalkraft, vilket ger:
$
S = m v^2/r "där" r "är krökningsradien i den punkten"
$
Specifikt i läge $A$:
$
S = m v_A^2/r_A
$
Och i läge $B$:
$
S = m v_B^2/(a^2/b)
$
Eftersom kraften verkar rätvinkligt mot cirkelrörelsen, och är den enda kraften som verkar, är kraftmomentet kring den $0$. Därav vet vi att rörelsemängdsmomentet bevaras genom hela rörelsen:
$
m v_A a = m v_B b \
(m v_A a)/(m b) = v_B \
(v_A a)/b = v_B \
therefore S = m v_B^2/b <=> S = m ((v_A a)/b)^2 1/(a^2/b) \
S = m (v_A^2 a^2)/b^2 b/a^2 = m (v_A^2)/b
$
