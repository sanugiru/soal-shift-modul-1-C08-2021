#!/bin/bash

cd /home/deka/Documents/SISOP/modul1/soal3/solve
zip -P $(date +%m%d%Y) -r Koleksi.zip  *
find . -type d -name 'Kucing*' -exec rm -r {} +
find . -type d -name 'Kelinci*' -exec rm -r {} +
