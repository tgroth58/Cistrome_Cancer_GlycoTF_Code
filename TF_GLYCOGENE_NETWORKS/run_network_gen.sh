#!/bin/bash

for ct in $(cat ../data/cancer_types.tsv)
do
	Rscript generate_bipartite_graph.R $ct
done
