# Project conventions

The documentation of KLayout-PEX, a Quarto website and a PDF. The rules of the code repository
hold here as well, in particular for PR texts:
<https://github.com/iic-jku/klayout-pex/blob/main/AGENTS.md>.

Before adding a kind of figure or table, look up how the docs do it and use the same mechanism,
not something that only looks the same.

## Text

- Docs describe contracts, not file layout.
- Section titles use the plain word for what the reader does (`Excluding Parts of the Layout`),
  without `a` or `an` (`Inductor of the PDK, with EM Model`).
- An example, a variant or a special case gets its own heading (`###`, `####`, `#####`, with a
  `{#sec-…}` anchor if it is referenced), rather than more space around it.
- Keep bullets short. A point that gets long becomes a lead-in with nested bullets.
- Pairs of nodes are written `` `A` ↔ `B` ``, with spaces, and `↔` as U+2194 alone.
- Mark identifiers as code with backticks: files, code, command line tools and their arguments,
  and the names of layers, device classes and models, PDKs and their variants. Tick every
  mention, not only the first.
- Netlists and values are copied from real runs, with the `kpex` command line above them. The
  netlist of a variant gets a schematic beside it.
- The figure of a test pattern has the link to its GDS above it (`GDS: <…>`).
- A `Limits` section names what users run into, not how the code is shared or what wasn't run.
- No notes that only point to a tracking issue (`see #401`), neither in comment blocks nor in
  callouts: the text describes the result.
- A claim that a PDK lacks something needs a search of the PDK, its rules and real layouts, not
  memory.
- Don't name proprietary solvers or protected company and product names: write "commercial tool
  A", "commercial tool B".

## Tables

- Give each column its alignment in the delimiter row: `:---` for text, `---:` for numbers. A
  column without a colon renders centred in a table with a `{#tbl-…}` id.
- Set the column widths in the caption: `: Caption {#tbl-x tbl-colwidths="[27,53,20]"}`.
  - Numbers get the width they need, text gets the rest
  - Tables of the same kind get the same widths
  - Check them again when the contents change
- Fill every cell, also where it repeats the row above. A row that holds for a PDK family may
  name it with a glob: `ihp-sg13*`.

## Figures

- Layout screenshots come from `notebooks/test_pattern_screenshots.ipynb`, not from the GUI.
  - They are `figures/test_patterns/<pattern>_-_<aspect>.png`, 2112 px wide, as the figures show
    them at the same width
  - The notebook needs the `klayout` Python module, and `KPEX_DIR`, the checkout of `klayout-pex`
    with the GDS
- Text, lines and frames over a screenshot are a `{python}` cell with `drawsvg`, in
  `figures/test_patterns/<pattern>_-_<aspect>.qmd`, e.g.
  `figures/test_patterns/overlap_shield_same_net_100um_x_100um_li1_m1_m2_-_overlap.qmd`.
  - `#| label: fig-…` makes it a numbered figure that can be referenced
  - `w` and `h` have the aspect of the PNG, positions are computed from the µm of the view box
  - Label what the screenshot shows in the figure, not in the caption: marker frames by their
    layer (`NoRCX.drawing`), cut cells (`cell block`), values, the parameters of a pcell
  - Frames and their labels have a color that no layer of the PDK has
- No text may overlap other text, a frame or a label of the layout. Look at the full resolution,
  a scaled page hides it. Labels of the layout are fixed in the screenshot: hide the layers that
  pcells write on, draw a label to the other side.
- Schematics are `figures/*-schematic.qmd` with `schemdraw`, as in
  `figures/ticer-example-schematic-reduced.qmd`: what goes away is struck through in red
  (`strike_through`), what is new is green (`.color('green')`).
- Before and after, or variants, are a figure group: `::: {#fig-x layout-nrow=N}` with the caption
  paragraph last, as `fig-ticer-pole-zero` in `doc/_ticer_study.qmd`. The licence block of an
  include takes a layout cell within a group and halves the figures: the whole group goes into
  one include, with the licence block before the group.
- `.qmd` files start with the hidden licence block of their neighbors (`::: {.content-hidden}`),
  with the range of years up to the current one.
- Every `.qmd` in `figures/` is also rendered as a page of its own, so it has to work alone:
  imports and helpers go into each file.
- Includes name their path from the project root (`{{< include /figures/x.qmd >}}`), images in
  `doc/` go through the symlink `doc/figures` (`figures/x.png`).

## PDF

- The PDF (the `pdf` format of `doc/doc.qmd`, with `xelatex`) is supported too, as far as
  possible. Not everything Quarto does for HTML works in TeX. What can't work there, such as the
  tabs that switch between the tech file previews, doesn't have to be in the PDF: keep it out
  with `::: {.content-visible when-format="html"}`, as in `doc/_sec_pdks.qmd`.
- Check it with `quarto render doc/doc.qmd --to pdf -M latex-clean:false`, which needs `xelatex`
  and `rsvg-convert`. Quarto exits with 0 whatever `doc/doc.log` says, so read it:
  - `Missing character`: the glyph is gone from the PDF, as Latin Modern has few symbols. Map it
    with `\newunicodechar` in `doc/doc.qmd`, like `✔`
  - `Overfull \vbox`: a page is too long, its text may run off the bottom and be lost
  - `Float too large for page`: a figure or a group is cut off
- Code blocks don't wrap in the PDF, long lines are cut off: break command lines with `\`.
- Look at the changed pages: the PDF isn't the HTML, e.g. wide table headers run together.

## Build and review

- `{python}` cells need a venv with `requirements.txt`, named by `QUARTO_PYTHON`.
- `quarto render doc/doc.qmd --to html` builds the documentation, `quarto render --to html` the
  whole website.
- Quarto also exits with 0 on `Unable to resolve crossref`: compare the log with `main`.
- For a review, Martin gets the URL of a served build:
  `python3 -m http.server --directory _site 4321`.
- Before handing over, look at each changed table and figure in the browser, at desktop width. A
  change of the anchor in the URL doesn't reload the page.

## Git

- A push to `main`, `reports` or `quarto` publishes the website and the PDF. A push to another
  branch publishes nothing.
- Martin reviews in detail and makes the commits: leave changes uncommitted in the working copy.
  For a change that should become several commits, stage it and propose the split. Don't commit
  or push unless asked.
- Martin keeps WIP stashes: never chain `git stash push`/`pop`.
- Commit subject: `Area: verb phrase`, no articles, with a part of the docs as the area, e.g.
  `Appendix`, `PEX25D`, `Notebooks`, `README`.
- No AI attribution: no `Co-Authored-By` trailer, no "Generated with …" line.
