# texlive-ja-image
TeXLive image for Japanese

[日本語README](./README_ja.md)

## Why?

To write the paper on the latest writing environment or specific version environment, we have to install TeXLive and setup environment.
It's very hassle and time consuming thing.

Use this image and we can easy to setup writing environment and write the paper with few times!

## TeX Processing System

We recommend to use upTeX or e-upTeX for all Japanese users as a first step.
The reasons are below:

1. Supported English and Japanese.
2. Numerous informations on the Internet.
3. Support Unicode characters.

If you are the TeX expert and want to use XeTeX or LuaTex, use [full tag image](#available-tags) or `tlmgr` to install them.

## Available Tags

We provide the image with below rule:

`jptexlive:[YEAR]-[OPTION]`

### YEAR

TeXLive version.

If empty, it'll be select the latest tag automatically.

### OPTION

Additional collection option and 2 options are available.

* default
* full

For details, see [Containered Collections](#contained-collections).

If empty, it'll be select [the default collections](#default).

## Contained Collections

This image contains below collections for Japanese users.

### Default

* Essential programs and files (`collection-basic`)
* BibTeX additional styles (`collection-bibtexextra`)
* TeX auxiliary programs (`collection-binextra`)
* Recommended fonts (`collection-fontsrecommended`)
* Additional formats (`collection-formatsextra`)
* Chinese/Japanese/Korean (base) (`collection-langcjk`)
* US and UK English (`collection-langenglish`)
* Japanese (`collection-langjapanese`)
* LaTeX fundamental packages (`collection-latex`)
* LaTeX additional packages (`collection-latexextra`)
* LaTeX recommended packages (`collection-latexrecommended`)
* Mathematics, natural sciences, computer science packages (`collection-mathscience`)
* MetaPost and Metafont packages (`collection-metapost`)
* Graphics, pictures, diagrams (`collection-pictures`)
* Publisher styles, theses, etc. (`collection-publishers`)

### Full

In addition to the default collection, it contains:

* Additional fonts (`collection-fontsextra`)
* Graphics and font utilities (`collection-fontutils`)
* LuaTeX packages (`collection-luatex`)
* Plain (La)TeX packages (`collection-plaingeneric`)
* XeTeX and packages (`collection-xetex`)

It contains LuaTeX and XeTeX processing system.

If you want to use other collections or remove collections, use `tlmgr` command.

## Supported TeXLive Version

The supported versions of TeXLive range from the latest to five years older.
We don't support over 5 years older versions.

## License

This image and repository are released under MIT license.
For details, see [LICENSE](./LICENSE).