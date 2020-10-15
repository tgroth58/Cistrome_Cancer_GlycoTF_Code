#!/bin/bash

for ct in $(cat ../data/cancer_types.txt)
do
	Rscript TF_glycoPathway_enrichment.R $ct
done
