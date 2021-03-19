#!/bin/bash

#Run all uncorrected TF-glycoPathway dataset through
# Reactome enrichment pipeline:

for ct in $(cat ../data/cancer_types.tsv)
do
	Rscript TF_reactome_enrich.R $ct
done


# Harmonize data together
Rscript merge_results.R

#Create alluvials:
Rscript create_alluvial_plots.R

