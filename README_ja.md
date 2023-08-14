# texlive-ja-image
日本語用のTeXLiveイメージ

[English README](./README.md)

## 目的

最新の執筆環境や特定のバージョン環境で論文を執筆するには、TeXLiveとセットアップ環境をインストールする必要があります。
それはとても面倒で時間のかかることです。

このイメージを使用すると、簡単に執筆環境を構築でき、わずかな手間で論文を執筆できます。

## TeX処理系

最初のステップとして、すべての日本人ユーザーにupTeXまたはe-upTeXを使用することをお勧めします。
理由は以下のとおりです。

1. 英語と日本語に対応。
2. インターネット上に多数の情報がある。
3. Unicode文字に対応。

TeXに精通していて、XeTeXまたはLuaTexを利用したい場合は、[`full`タグイメージ](#利用できるタグ)を使用するか、または`tlmgr`を使用してインストールしてください。

## 利用できるタグ

以下のルールでイメージを提供しています。

`jptexlive:[YEAR]-[OPTION]`

### YEAR

TeXLiveのバージョン。

空の場合は、最新のタグ(`latest`)が自動的に選択されます。

### OPTION

追加のコレクションオプションで2つのオプションがあります。

* default
* full

詳細は[含まれるコレクション](#含まれるコレクション)を参照してください。

空の場合は[デフォルトのコレクション](#Default)が選択されます。

## 含まれるコレクション

このイメージには、日本人ユーザー向けの以下のコレクションが含まれています。

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

### フル

デフォルトのコレクションに加えて、次のものが含まれています。

* Additional fonts (`collection-fontsextra`)
* Graphics and font utilities (`collection-fontutils`)
* LuaTeX packages (`collection-luatex`)
* Plain (La)TeX packages (`collection-plaingeneric`)
* XeTeX and packages (`collection-xetex`)

これにはLuaTeXとXeTeX処理システムが含まれます。

他のコレクションを使用したり、コレクションを削除したりする場合は、`tlmgr`コマンドを使用してください。

## 対応しているTeXLiveのバージョン

サポートされているTeXLiveのバージョンは、最新のものから5年前のものです。
5年以上前のバージョンはサポートしていません。

## ライセンス

このイメージとリポジトリはMITライセンスの下で配布されています。
詳細は[LICENSE](./LICENSE)をご覧ください。