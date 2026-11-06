# verkodo Whitepaper

The whitepaper of **verkodo** – truth code – mathematics and law written formally, checked by machine. A [falkOSS](https://falkoss.org) project.

| File | Content | Status |
|---|---|---|
| [whitepaper.md](whitepaper.md) | the whitepaper – the only source | v0.1, outline |
| [whitepaper.pdf](whitepaper.pdf) | set with Typst from the Markdown | generated |

## Building

`whitepaper.md` is the only source. `whitepaper.typ` (Typst) and `whitepaper.pdf` are generated from it – rebuild
after every change and commit all three:

```sh
./build.sh               # all documents (needs the pandoc and typst versions in build.sh, otherwise uses nix)
./build.sh whitepaper.md # only this one
```

Title, version and status come from the YAML front matter; with `status: Draft` a light DRAFT is drawn behind every
page. The footer shows status, the date of the document's last commit and the short hash of its content
(`git log --find-object=<hash>` finds the commit a PDF was made from). Author notes (`> [!NOTE]`, the section "Open
points") stay in the Markdown only. CI (`.github/workflows/pdf.yml`) rebuilds on every push, checks that the
committed `.typ` is current and, for a tag `v*`, attaches the PDF to a GitHub release.

The template (`template/verkodo.typ`) follows `verkodo/brand`: its lockup (`template/assets/`, a copy), titanium grey
beside the ink, Crimson Pro for the text and IBM Plex Mono for code.

## Licence

The text: [CC BY 4.0](LICENSES/CC-BY-4.0.txt). The build tooling (`build.sh`, `template/`):
[AGPL-3.0-or-later](LICENSES/AGPL-3.0-or-later.txt). Fonts: Crimson Pro and IBM Plex Mono, [SIL Open Font License 1.1](LICENSES/OFL-1.1.txt). The lockup in
`template/assets/`: [CC BY-ND 4.0](LICENSES/CC-BY-ND-4.0.txt), copied from `verkodo/brand`.

## Contributing

Issues and pull requests are welcome, with a [DCO](https://developercertificate.org) sign-off (`git commit -s`).
Every claim needs a source; unverified statements are marked **OPEN**.

© 2026 falkOSS – Falcon Lake Open Source Software gUG (haftungsbeschränkt) i. G. and the verkodo contributors
