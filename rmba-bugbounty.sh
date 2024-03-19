#!/bin/bash

## == Lista subdominios == ##
cat escope.txt | subfinder -o ./tmp/subfinder.txt

## == Crawler de URLs para cada dominio == #
cat ./tmp/subfinder.txt | /home/rmba/go/bin/cariddi -plain > ./tmp/cariddi.txt

## == Crawler (Não Interativo) URLs para cada dominio == #
#cat subfinder.txt | gau --blacklist md,jpg,jpeg,gif,css,tif,tiff,png,ttf,woff,woff2,ico --from 202401 --providers wayback --o ./tmp/gau.txt

cat ./tmp/cariddi.txt | uro --filter hasparams hasexts -o ./tmp/uro.txt

cat ./tmp/uro.txt | dalfox pipe --silence --format json -o ./tmp/dalfox.json

cat uro-output.txt | ~/go/bin/nuclei -silent --severity low,medium,high,critical |& tee nuclei-output.txt
