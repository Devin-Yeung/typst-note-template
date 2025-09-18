// package dependancies and show rules
#import "@preview/physica:0.9.5": *
#import "@preview/fletcher:0.5.8": diagram, edge, node

// style and colors are credited to https://github.com/Carlos-Mero/may
// fonts are opinionated, font size is optimized for A4 paper
#let _template(doc) = [
  #show: super-T-as-transpose

  // Page Configuration
  #let sea = rgb("#3b60a0")
  #let sky = rgb("#bdd0f1")
  #let skyl = rgb("#eff3ff")
  #let skyll = rgb("#f4f9ff")
  #let paper = rgb("#f5f6f8")

  #set page(
    paper: "a4",
    columns: 1,
    margin: (x: 1.5cm, y: 1.5cm),
    numbering: "- 1/1 -",
  )

  #show raw: it => {
    set text(font: "Iosevka", size: 1em)
    block(
      width: 100%,
      height: auto,
      fill: skyll,
      inset: 2.1mm,
      radius: 1.7mm,
      it,
    )
  }

  #set par(
    justify: true,
  )

  // Links
  #show link: underline
  #show link: it => {
    set text(fill: sea)
    it
  }

  // Quote / Terms
  #show ">|": it => [
    #box(baseline: 0.2em, rect(width: 1mm, height: 1.2em, fill: sea))
  ]

  // Headings
  #let subline() = {
    v(-4.53mm)
    line(length: 100%, stroke: sea)
    v(-0.7mm)
  }

  #show heading.where(
    level: 1,
  ): it => [
    #set align(center)
    #set text(
      fill: sea,
      size: 1.5em,
      weight: "bold",
      style: "normal",
    )
    #it.body
    #subline()
  ]

  #show heading.where(
    level: 2,
  ): it => [
    #set text(
      fill: sea,
      size: 1.25em,
      weight: "bold",
      style: "normal",
    )
    #it.body
    #subline()
  ]

  #show heading.where(
    level: 3,
  ): it => [
    #set text(
      fill: sea,
      size: 1.1em,
      weight: "bold",
      style: "normal",
    )
    #it.body
    #subline()
  ]

  // heading level deeper than 3 is almost impossible

  // Detail Decoration
  #show "->": it => [
    #math.limits(it)
  ]
  #show "-->": it => [
    #math.limits(it)
  ]
  #show "<--": it => [
    #math.limits(it)
  ]
  #show "<-": it => [
    #math.limits(it)
  ]
  #show "=>": it => [
    #math.limits(it)
  ]
  #show "==>": it => [
    #math.limits(it)
  ]
  #show "<=": it => [
    #math.limits(it)
  ]
  #show "<==": it => [
    #math.limits(it)
  ]
  #show "<=>": it => [
    #math.limits(it)
  ]
  #show "<==>": it => [
    #math.limits(it)
  ]

  #set table(
    stroke: none,
    gutter: 0.2em,
    align: center,
    fill: (x, y) => if y == 0 { sea },
    // inset: (right: 1.5em)
  )
  #show table.cell: it => {
    if it.y == 0 {
      set text(white)
      strong(it)
    } else { it }
  }

  #doc
]

#let template(doc) = [
  #set text(
    font: ("Libertinus Sans", "LXGW Wenkai"),
    lang: "en",
    size: 12pt,
    weight: "regular",
    style: "normal",
  )
  #_template(doc)
]
