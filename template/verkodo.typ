// SPDX-License-Identifier: AGPL-3.0-or-later
// verkodo document template: A4, Crimson Pro (fonts/, OFL), code in IBM Plex Mono. Used by pandoc.typ for whitepaper.md;
// usable on its own:
//
//   #import "template/verkodo.typ": verkodo
//   #show: verkodo.with(title: "…", status: "Draft")
//
// The look of verkodo/brand: its lockup (assets/, copied from brand/svg/verkodo-lockup-on-light.svg), ink text, grey
// rules and titanium grey as the one colour beside the ink.

#let ink = rgb("#14202B")
#let accent = rgb("#646A70")   // titanium on light
#let steel = rgb("#4A5058")
#let reed = rgb("#6E737A")
#let rule = rgb("#C9D1D9")
#let note = rgb("#F1F0EC")

#let org = "verkodo – a falkOSS project"
#let mono = "IBM Plex Mono"
#let serif = "Crimson Pro"

#let wordmark(size) = box(image("assets/verkodo-lockup-on-light.svg", height: size * 1.5), baseline: 20%)

/// title, subtitle, version, date: the title block on page 1 and the running header
/// status: "Draft" draws a light DRAFT behind every page; anything else prints only in the footer
/// stand, rev: shown in the footer (build.sh passes the last commit's date and revision)
#let verkodo(title: none, subtitle: none, version: none, date: none, status: "Draft", stand: none, rev: none, body) = {
  let draft = status == "Draft"
  set document(title: title, author: org)
  set text(font: serif, size: 11pt, lang: "en", fill: ink, hyphenate: true)
  set par(justify: true, leading: 0.68em, spacing: 1.15em)

  set page(
    paper: "a4",
    margin: (top: 30mm, bottom: 26mm, left: 24mm, right: 22mm),
    header: context {
      let first = counter(page).get().first() == 1
      grid(
        columns: (auto, 1fr),
        align: (left + horizon, right + horizon),
        wordmark(if first { 14pt } else { 9pt }),
        if not first { text(size: 9pt, style: "italic", fill: reed, if title != none { title }) },
      )
      v(-2mm)
      line(length: 100%, stroke: 0.5pt + rule)
    },
    footer: context {
      line(length: 100%, stroke: 0.5pt + rule)
      v(-1mm)
      set text(size: 8.5pt, fill: reed)
      grid(
        columns: (1fr, auto),
        column-gutter: 10pt,
        [#org · CC BY 4.0],
        [#status#if stand != none [ · #stand]#if rev != none [ · #rev] · #counter(page).display() / #counter(page).final().first()],
      )
    },
    background: if draft {
      rotate(-38deg, text(size: 96pt, weight: "semibold", fill: accent.transparentize(92%))[DRAFT])
    },
  )

  show heading: set text(weight: "semibold", fill: ink, hyphenate: false)
  show heading: set par(justify: false)
  show heading.where(level: 1): it => {
    v(4mm)
    block(below: 6mm, sticky: true, {
      text(size: 18pt, it.body)
      v(-2mm)
      line(length: 22mm, stroke: 1.6pt + accent)
    })
  }
  show heading.where(level: 2): it => block(above: 1.8em, below: 0.9em, sticky: true, text(size: 13.5pt, it.body))
  show heading.where(level: 3): it => block(above: 1.4em, below: 0.7em, sticky: true, text(size: 12pt, style: "italic", it.body))

  show quote.where(block: true): it => block(
    width: 100%, fill: note, inset: (x: 10pt, y: 8pt), radius: 1pt,
    stroke: (left: 2pt + accent), text(size: 10pt, it.body),
  )

  set table(stroke: 0.5pt + rule, inset: (x: 6pt, y: 5pt))
  show table: set text(size: 9.8pt)
  show table: set par(justify: false)
  show table: set align(left)
  show figure.where(kind: table): set block(breakable: true)
  show table.cell.where(y: 0): set text(weight: "semibold")

  show raw: set text(font: mono, size: 8pt)
  show raw.where(block: true): set par(justify: false)
  show link: underline.with(stroke: 0.5pt + accent, offset: 2pt)
  set list(marker: text(fill: accent, [–]))
  set enum(numbering: "1.")
  set footnote.entry(separator: line(length: 22mm, stroke: 0.5pt + rule))
  show footnote.entry: set text(size: 9pt)

  // title block
  if title != none {
    v(18mm)
    block(text(weight: "semibold", size: 30pt, hyphenate: false, title))
    if subtitle != none { block(above: 4mm, text(size: 15pt, style: "italic", fill: steel, subtitle)) }
    v(2mm)
    line(length: 30mm, stroke: 2pt + accent)
    block(above: 5mm, text(size: 10.5pt, fill: reed,
      [Whitepaper#if version != none [ #version]#if date != none [ · #date]]))
    v(14mm)
  }

  body
}
