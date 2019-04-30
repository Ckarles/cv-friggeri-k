# cv-friggeri-k

## about Friggeri CV
Friggeri CV is an elegant *Curriculum Vitae* template for LaTeX/XeTeX originally written and released by [Adrian Friggeri](https://github.com/afriggeri).

This work is a fork of [cv-friggeri-x](https://github.com/Nadorrano/cv-friggeri-x) from [Nadorrano](https://github.com/Nadorrano)

## what's new
  - inclusion of a photo in the aside box
  - "skills" section with simple progressbars
  - uses of fontawesome instead of marvosym
  - various tweaks and optimizations

## changes brought by Nadorrano
  - the default font (Helvetica) is replaced by the open source font Roboto from Google, available free of charge [here](https://www.google.com/fonts/specimen/Roboto)
  - A4 paper size is now available for the CV class. This option can
be set in the document class declaration as usual, e.g.:

```tex
\documentclass[a4paper]{friggeri-cv}
```

  - two new options for the document class are available, `lightheader` and `nocolors`. The former will remove the dark background on the header, the latter will remove all colors from the document. The old `print` option is deprecated but the same effect can be obtained by turning on the previous two options

  - the "contact box" in the side section now shows informations on social networks with glyphs from the most common platforms including facebook, twitter, vk, linkedin

- names of articles, book, publications, etc. are now active links to actual contents (web pages, files...). You have to make sure an `url` field is specified in your bibliography entries to make this work.

## examples

You can check the content of the `example` folder of this repo for the actual PDFs.

## building notes

This LaTeX template uses TikZ for the header, XeTeX and fontspec for custom fonts, biblatex/biber to print publications and textpos for the aside.

A basic compilation workflow would be:

```sh
git clone https://gitlab.com/Ckarles/cv-friggeri-k.git
cd cv-friggeri-k
xelatex cv
biber cv
xelatex cv
```

## license

This work is released under the MIT license. See LICENSE.

