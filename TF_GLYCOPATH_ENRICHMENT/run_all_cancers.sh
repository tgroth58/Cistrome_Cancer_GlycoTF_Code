#!/bin/bash

for ct in $(cat ../data/cancer_types.tsv)
do
	Rscript TF_glycoPathway_enrichment.R $ct
done
