// Coptic word division — a one-page summary of Till's forty rules.
//
// The rules are restated, not translated; the examples are his. Source:
// W. C. Till, "La séparation des mots en copte", BIFAO 60 (1960), 151-170.
//
// Built by the flake: `nix build .#cheatsheet`. New Athena Unicode is
// converted from the WOFF the site already ships, so the sheet and the page
// are set in the same file. Everything is in that one font, Latin included.
//
// If this ever spills onto a second page, drop examples before dropping the
// type size: below about 7pt the supralinear strokes stop resolving.

// Solarized light, the same tokens as static/style.css. The sheet is meant to
// look like a page of the site that happens to be A4.
#let base3 = rgb("#fdf6e3") // page
#let base2 = rgb("#eee8d5") // rules, as the site's hr
#let base1 = rgb("#93a1a1") // borders
#let base01 = rgb("#586e75") // headings, emphasised text
#let base00 = rgb("#657b83") // body
#let blue = rgb("#268bd2") // links

#set page(
  paper: "a4",
  margin: (x: 11mm, y: 10mm),
  columns: 2,
  fill: base3,
)
#set text(font: "New Athena Unicode", size: 8pt, lang: "en", fill: base00)
#set par(justify: false, leading: 0.5em)
#show link: set text(fill: blue)

#let cop(s) = text(size: 1.15em)[#s]
#let gl(s) = text(style: "italic")[#s]

// One rule: bold number, the rule, then examples indented under it. The space
// above is what separates one rule from the last one's examples; without it
// the column reads as continuous prose.
#let rule(n, body) = block(above: 0.62em, below: 0.2em, {
  text(weight: "bold")[#n.]
  h(0.35em)
  body
})

#let ex(..items) = block(
  inset: (left: 1em),
  above: 0.18em,
  below: 0.18em,
  items.pos().join(linebreak()),
)

#let group(title) = block(above: 1em, below: 0.45em, {
  text(weight: "bold", size: 1.05em, fill: base01)[#title]
  v(-0.35em)
  line(length: 100%, stroke: 0.5pt + base1)
})

// Masthead, spanning both columns: the site's wordmark and tagline over a
// rule, then the page heading, exactly as /word-division/ is stacked.
#place(top, scope: "parent", float: true, clearance: 5.5mm, {
  align(center, {
    text(size: 21pt, fill: base01)[ⲁⲧⲣⲓⲡⲉ]
    linebreak()
    text(size: 7.5pt, fill: base00)[Coptic in the cloud]
  })
  v(0.15em)
  line(length: 100%, stroke: 0.6pt + base2)
  v(0.1em)
  text(size: 13pt, weight: "bold", fill: base01)[Word division]
  h(0.5em)
  text(size: 9pt, fill: base00)[the forty rules of Till 1960]
  v(0.25em)
  text(size: 7.5pt)[
    W. C. Till, «#emph[La séparation des mots en copte]», #emph[BIFAO] 60
    (1960), 151–170. Rules restated in summary; examples are Till's, cited by
    his section numbers. Joined forms are printed joined, separated forms with
    spaces — the spelling is the rule. His criterion throughout: division
    exists only to make the text understood quickly and surely, and no other
    consideration may enter.
  ]
})

#group[Determiners §§1–5]

#rule(1)[Definite article, all forms: joined.]
#ex[#cop[ⲡϣⲏⲣⲉ] #gl[the son] · #cop[ⲧⲉⲣⲟⲙⲡⲉ] #gl[the year]]

#rule(2)[Indefinite #cop[ⲟⲩ], #cop[ϩⲉⲛ]: joined. Also separates the article
from interrogative #cop[ⲟⲩ] #gl[what?]]
#ex[#cop[ⲟⲩⲱⲃ] #gl[a thing] · #cop[ⲟⲩ ⲡⲉ ⲡⲁⲓ] #gl[what is this?]]

#rule(3)[Plural #cop[ϩⲉⲛ] joined, so the preposition #cop[ϩⲛ] stays visible.]
#ex[#cop[ϩⲉⲛϣⲁϫⲉ ⲁⲛ] #gl[not words] · #cop[ϩⲛ ϣⲁϫⲉ ⲁⲛ] #gl[not in words]]

#rule(4)[Demonstrative article joined, demonstrative pronoun separate.
Indispensable in A, A#sub[2], F and B, where the two are spelt alike.]
#ex[#cop[ⲡⲉⲓⲣⲱⲙⲉ] #gl[this man] · #cop[ⲡⲉⲓ ⲟⲩⲣⲱⲙⲉ ⲡⲉ] #gl[this is a man]]

#rule(5)[Possessive article joined, possessive prefix separate. Without this
the article + #cop[ⲁⲧ-] #gl[without] reads as its own opposite.]
#ex[#cop[ⲛⲁⲉⲓⲟⲧⲉ] #gl[my parents] · #cop[ⲛⲁ ⲛⲁⲉⲓⲟⲧⲉ] #gl[those of my parents]]
#ex[#cop[ⲡⲁⲧⲙⲟⲣⲧ] #gl[the beardless one] · #cop[ⲡⲁ ⲧⲙⲟⲣⲧ] #gl[the bearded one]]

#group[Conjugation and subject §§6–12]

#rule(6)[Conjugation prefix with pronominal subject: joined to the predicate,
as a personal ending is elsewhere — #gl[amavit], not #gl[ama v it].]
#ex[#cop[ⲁϥⲛⲁⲩ] #gl[he saw] · #cop[ⲛⲉϥϩⲟⲟⲩ] #gl[it was bad]]

#rule(7)[The same before a non-verbal predicate.]
#ex[#cop[ϥⲙⲙⲁⲩ] #gl[he is there] · #cop[ⲛⲉϥϩⲙ ⲡⲉϥⲏⲓ] #gl[he was in his house]]

#rule(8)[A nominal subject is separated from its predicate.]
#ex[#cop[ⲡⲁⲥⲟⲛ ϩⲙ ⲡⲉϥⲏⲓ] #gl[my brother is in his house]]

#rule(9)[But the conjugation prefix is joined to a nominal subject. This is
the distinction that carries the most weight in the whole system.]
#ex[#cop[ⲙⲉⲣⲉⲡϫⲟⲉⲓⲥ ⲥⲙⲟⲩ] #gl[the Lord does not bless]]
#ex[#cop[ⲙⲉⲣⲉ ⲡϫⲟⲉⲓⲥ ⲥⲙⲟⲩ] #gl[love the Lord! bless\u{2026}]]

#rule(10)[Conjunctive #cop[ⲛⲧⲉ] with nominal subject joined; the preposition
#cop[ⲛⲧⲉ] separate.]
#ex[#cop[ⲛⲧⲉⲡϫⲟⲉⲓⲥ] #gl[and the Lord will] · #cop[ⲛⲧⲉ ⲡϫⲟⲉⲓⲥ] #gl[from the Lord]]

#rule(11)[Suffix conjugation: #emph[not] joined to a following nominal
subject. Separation is plainer here, not less plain.]
#ex[#cop[ⲡⲉϫⲉ ⲡϫⲟⲉⲓⲥ] #gl[the Lord said] · #cop[ⲛⲁⲛⲟⲩ ⲡⲉⲕⲛⲁ] #gl[your mercy is good]]

#rule(12)[#cop[ⲟⲩⲛ] and #cop[ⲙⲛ] with #cop[ⲛⲧⲉ] behave the same way.]
#ex[#cop[ⲟⲩⲛⲧⲉ ⲡⲉⲓⲱⲧ] #gl[the father has]]

#group[Infinitive and object §§13–18]

#rule(13)[Separate the reduced infinitive from its nominal object. Joining
the two is the single largest source of obscurity in Coptic printing.]
#ex[#cop[ⲛ ⲟⲩϫⲱⲱⲙⲉ] #gl[to bring a book]]
#ex[#cop[ⲛⲟⲩϫⲱⲱⲙⲉ] #gl[of a book, to a book, a book (acc.)]]

#rule(14)[#cop[ⲙⲉϩ-] forming ordinals joined; #cop[ⲙⲉϩ] #gl[fill] separate.]
#ex[#cop[ⲙⲉϩϣⲟⲙⲛⲧ ⲛϫⲡⲟϥ] #gl[third basket]]
#ex[#cop[ⲙⲉϩ ϣⲟⲙⲛⲧ ⲛϫⲡⲟϥ] #gl[fill three baskets]]

#rule(15)[#cop[ⲟⲩⲛ] / #cop[ⲙⲛ] expanded with subject and object: where both
are nominal, all three stand apart.]
#ex[#cop[ⲙⲛⲧⲉ ⲡⲛⲁ ⲕⲁⲥ] #gl[a spirit has no bone]]

#rule(16)[Separate the object even from a very short infinitive, and even
where the pair translates as one word.]
#ex[#cop[ⲣ ⲛⲟⲃⲉ] #gl[to sin] · #cop[ϯ ⲉⲟⲟⲩ] #gl[to praise] · #cop[ϭⲙ ⲡϣⲓⲛⲉ] #gl[to visit]]

#rule(17)[An infinitive governing an infinitive: also separate. Decisive
after #cop[ϣ] #gl[be able].]
#ex[#cop[ⲁϥϣ ⲱⲡ] #gl[he could count] · #cop[ⲁϥϣⲱⲡ] #gl[he bought]]

#rule(18)[But #cop[ⲣ] / #cop[ⲉⲣ] / #cop[ⲉⲁ] before a Greek verb: joined. The
combination has become one verb, and splitting it clarifies nothing.]
#ex[#cop[ⲣⲁⲓⲧⲉⲓ], #cop[ⲉⲣⲁⲓⲧⲓⲛ] #gl[to ask] (αἰτεῖν)]

#group[Prepositions §§19–22]

#rule(19)[Prepositions separate, as in every other language. A second large
source of doubt closes here.]
#ex[#cop[ϫⲓⲛ ϩⲧⲟⲟⲩⲉ ϣⲁ ⲣⲟⲩϩⲉ] #gl[from morning to evening]]
#ex[#cop[ⲙⲛ ⲧⲉϥⲙⲁⲁⲩ] #gl[with his mother] · #cop[ⲙⲛⲧⲉϥ ⲙⲁⲁⲩ] #gl[he has no mother]]

#rule(20)[Exception by convention: the one-letter prepositions #cop[ⲉ] and
#cop[ⲛ] are joined, a habit taken over from Hebrew and Arabic setting. For
#cop[ⲉ] there is no alternative — it cannot always be detached.]
#ex[#cop[ⲁⲓⲛⲁⲩ ⲉⲩⲣⲱⲙⲉ] #gl[I saw a man]]

#rule(21)[The cost of §20: the preposition #cop[ⲉ] and the #cop[ⲉ] of the
circumstantial can no longer be told apart. #cop[ⲉⲩⲙⲧⲟⲛ] has three readings
and no spacing will separate them.]

#rule(22)[#cop[ⲛ] likewise carries plural article, negation, genitive, dative
and accusative, all joined. Separate it only where it is the reduced
infinitive of #cop[ⲉⲓⲛⲉ] #gl[bring] (§13).]

#group[Circumstantial, preterite, relative §§23–28]

#rule(23)[Circumstantial #cop[ⲉ] joined, including where it contracts with a
following #cop[ⲟⲩ] to #cop[ⲉⲩ].]
#ex[#cop[ⲟⲩⲁ ⲉⲡⲉϥⲣⲁⲛ ⲡⲉ ⲡⲁⲩⲗⲟⲥ] #gl[one whose name is Paul]]

#rule(24)[#cop[ⲛⲉ] and #cop[ⲉⲛⲉ] of the preterite joined; this is what marks
off the interrogative #cop[ⲉⲛⲉ], which stands apart.]
#ex[#cop[ⲉⲛⲉⲛⲧⲕ ⲟⲩⲱϩⲥ] #gl[if you were a shepherd]]
#ex[#cop[ⲉⲛⲉ ⲛⲧⲕ ⲟⲩⲱϩⲥ] #gl[are you a shepherd?]]

#rule(25)[Relative #cop[ⲉ], #cop[ⲉⲧ], #cop[ⲛ], #cop[(ⲉ)ⲛⲧ]: joined tightly.
In most combinations they could not be detached at all.]
#ex[#cop[ⲡⲏⲓ ⲉⲛⲧⲁⲡⲁⲥⲟⲛ ⲃⲱⲕ ⲉϩⲟⲩⲛ ⲉⲣⲟϥ] #gl[the house my brother entered]]

#rule(26)[#cop[ⲉⲧⲉ] alone stands apart, being followed by a noun, an
independent pronoun or a negation.]
#ex[#cop[ⲧⲡⲏⲅⲏ ⲉⲧⲉ ⲡⲥⲱⲙⲁ ⲡⲉ] #gl[the spring that is the body]]

#rule(27)[Which also distinguishes it from #cop[ⲉⲧ] + #cop[ⲧⲉ], 2 sg. fem.]
#ex[#cop[ⲛⲑⲉ ⲉⲧⲟⲩⲁϣⲥ] #gl[as you (m.) wish]]
#ex[#cop[ⲛⲑⲉ ⲉⲧⲉⲟⲩⲁϣⲥ] #gl[as you (f.) wish]]

#rule(28)[One exception: #cop[ⲉⲧⲉⲩⲛ] is written for #cop[ⲉⲧⲉ ⲟⲩⲛ]. It causes
no doubt.]

#group[The nominal sentence §§29–33]

#rule(29)[A reduced pronominal subject stands apart. #cop[ⲁⲛⲅⲟⲩⲱϩⲥ] gains
nothing over the alternative.]
#ex[#cop[ⲁⲛⲟⲕ ⲟⲩⲱϩⲥ], #cop[ⲁⲛⲅ ⲟⲩⲱϩⲥ] #gl[I am a shepherd]]

#rule(30)[So do the other reduced personal pronouns, which otherwise read as
conjugation prefixes.]
#ex[#cop[ⲛⲧⲕ ⲟⲩⲉⲃⲟⲗ ⲧⲱⲛ] #gl[where are you from?]]
#ex[#cop[ⲛⲧⲕⲟⲩⲉⲣⲏⲧⲉ] #gl[(of) your foot]]

#rule(31)[#cop[ⲡⲉ], #cop[ⲧⲉ], #cop[ⲛⲉ] separate. #cop[ⲟⲩⲙⲉ ⲧⲉ] #gl[it is
true] needs no operation performed on it.]

#rule(32)[Joining them produces real misreadings, and not only among
beginners: the Achmimic translator of Zach. 14:9, working from an undivided
Sahidic text, took #cop[ⲉⲟⲩⲁⲡⲉ] for #gl[a head] instead of #cop[ⲉⲟⲩⲁ ⲡⲉ]
#gl[being one], and rendered the Lord and his name as heads.]
#ex[#cop[ⲟⲩⲁⲡⲉ] #gl[a head] · #cop[ⲟⲩⲁ ⲡⲉ] #gl[he is one]]
#ex[#cop[ⲧⲉⲥⲙⲛⲧⲉ] #gl[its centre] · #cop[ⲧⲉⲥⲙⲏ ⲧⲉ] #gl[it is the voice]]
#ex[#cop[ⲛⲟⲩⲛⲉ] #gl[root] · #cop[ⲛⲟⲩ ⲛⲉ] #gl[they are yours (f.)]]

#rule(33)[Often #cop[ⲡⲉ] has no syntactic tie to the word before it at all.
Joining two words with no relation cannot help the reader.]

#group[Clitics §§34–37]

#rule(34)[Enclitics separate, or they are read as part of the preceding word.]
#ex[#cop[ⲧⲉⲛⲟⲩ ϭⲉ] #gl[now then]]

#rule(35)[Proclitics likewise. #cop[ⲛϭⲓ] before a plural noun is the standing
example.]
#ex[#cop[ⲛϭⲓⲛϣⲁϫⲉ] #gl[the discourses] · #cop[ⲛϭⲓ ⲛϣⲁϫⲉ] #gl[that is, the words]]

#rule(36)[#cop[ϫⲉ] separate: detached it is recognised at once. Join it only
where the #cop[ⲉ] belongs to both words and neither split is writable.]
#ex[#cop[ϫⲉ ⲉϥⲛⲁⲩ] #gl[that he may see] · but #cop[ϫⲉϥⲛⲁⲩ]]

#rule(37)[Two words #cop[ⲕⲉ] #gl[other]: the common one joined, the rare
independent one apart.]
#ex[#cop[ⲕⲉⲣⲱⲙⲉ] #gl[another man] · #cop[ⲡⲕⲉ ⲉⲧⲛⲧⲁϥ] #gl[also that which he has]]

#group[Compounds, affixes, suffixes §§38–40]

#rule(38)[Compounds with a reduced first element: joined where that element
never occurs alone, which is why joining costs no clarity.]
#ex[#cop[ⲥⲁⲩⲏⲣⲡ] #gl[wine-drinker] · #cop[ⲙⲁⲓⲛⲟⲩⲧⲉ] #gl[God-loving]]
#ex[but #cop[ⲥⲟⲩⲁ ⲡϣ(ⲉ) ⲛϩⲱⲣ] #gl[Soua son of Hor], so the father's name stands out]

#rule(39)[Noun-forming prefixes joined, on the same test. Detach any element
that also occurs on its own.]
#ex[#cop[ⲣⲉϥϫⲓⲟⲩⲉ] #gl[thief] · #cop[ⲙⲛⲧϫⲟⲉⲓⲥ] #gl[lordship] · #cop[ⲁⲧⲙⲁⲁⲩ] #gl[motherless]]
#ex[but #cop[ⲃⲱ ⲛⲉⲗⲟⲟⲗⲉ] #gl[vine] · #cop[ⲙⲁ ⲛϣⲱⲡⲉ] #gl[dwelling] · #cop[ⲥⲁ ⲛⲛⲉϩ] #gl[oil-seller]]

#rule(40)[Suffix pronouns joined — nobody proposes otherwise. But the full
form #cop[ⲧⲏⲩⲧⲛ] (A A#sub[2] #cop[ⲧⲏⲛⲉ], F #cop[ⲧⲏⲛⲟⲩ], B #cop[ⲑⲏⲛⲟⲩ]) is
not a suffix: the #cop[ⲱ] and #cop[ⲏ] show a full accent of its own.]
#ex[#cop[ⲣⲁⲧⲛ] #gl[our foot] · #cop[ⲣⲁⲧ ⲧⲏⲩⲧⲛ] #gl[your foot]]
#ex[#cop[ϩⲱⲱⲕ] #gl[yourself] · #cop[ϩⲱⲧ ⲧⲏⲩⲧⲛ] #gl[yourselves]]

#v(0.8em)
#line(length: 100%, stroke: 0.6pt + base2)
#v(-0.2em)
#text(size: 7pt)[
  Till closes by noting that these proposals agree with what most editors of
  Coptic texts already do, and with word division as other languages practise
  it. Where spacing cannot decide — §§21–22 — he declines to give up a good
  and simple procedure merely because it is not a total one.
]
#v(0.3em)
#align(center, text(size: 7pt)[
  #link("https://atripe.github.io/word-division/")[atripe.github.io/word-division]
  · The system is Till's; this restatement is CC BY-SA 4.0.
])
