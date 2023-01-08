#!/bin/sh
nix-shell \
    -p \
    texlive.combined.scheme-small \
    pandoc \
    wkhtmltopdf \
    --run "pandoc class.md -o RENDERED-lonesome_stranger_5e_class.pdf --css lonesome_stranger_5e_class.css --pdf-engine=wkhtmltopdf"
