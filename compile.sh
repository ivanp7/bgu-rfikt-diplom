#!/bin/bash

mkdir -p output
xelatex -file-line-error -halt-on-error -output-directory=output -interaction=nonstopmode diploma.tex
exit $?

