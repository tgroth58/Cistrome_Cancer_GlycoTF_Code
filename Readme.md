# Repository for: "A systems based framework to deduce transcription factors and signaling pathways regulating glycan biosynthesis"

Please follow the [link]() to the manuscript.

## File Descriptions:

### TF_GLYCOPATHWAY_ENRICHMENT:

* *TF_glycoPathway_enrichment.R*: Computed Fisher's exact test p-values (with Benjamini Hochberg correction) for TF-glycosylation pathway relationships for a cancer type.  The script takes the name of a TCGA cancer analyzed in this work as an argument.  All TCGA cancer types are available in the "cancer_types.tsv" file in the "data" folder of this repository
* *hyper_geo_test_single.R*: Given a set of TF-glycogene relationships a cancer type, it constructs a contingency matrix to determine if a TF disproportionately regulates a glycosylation pathway.

#### Example Usage from command line:
```
Rscript TF_glycoPathway_enrichment.R BRCA_1
```
	
Output from this script will be written into "TF_glycopath_enrichment_results"

### TF_REACTOME_ENRICHMENT

* *TF_reactome_enrich.R*: For all glycosylation pathways that had enriched TFs for a cancer type, a Reactome overrepresentation analysis is conducte using Reactome's API.  The input argument to this script is a file name found within "./TF_GLYCOPATHWAY_ENRICHMENT/TF_glycopath_enrichment_results".  The output is a table of Reactome pathway results matched with corresponding glycosylation pathways.

* *get_reactome_table.R*: Constructs the Reactome API call using the list of TFs enriched to a particular glycosylation pathway.

#### Example usage from command line:
```
Rscript TF_glycoPathway_enrichment.R BRCA_1_pathway_enrich_RP_cor.rda
```

Output from this script will be written into "TF_signaling_enrichment_results"

### TF_GLYCOGENE_NETWORKS

* *generate_bipartite_networks.R*: parses cancer-specific TF-glycogene relationships, and generates bipartite networks using the igraph package.  Fast greedy community detection is then employed on the TF bipartite graph projection to discover communities.  If communities have more than 5 nodes, glycosylation pathway enrichment and TF signal pathway enrichment using the Reactome API are conducted and saved as results in an R list.
* *get_reactome_table.R*: Constructs the Reactome API call using the list of TFs enriched to a particular glycosylation pathway.
	hyper_geo_test_tfList.R: Given a set of TF-glycogene relationships for a cancer type, it constructs a contingency matrix to determine if a SET of TF disproportionately regulates a glycosylation pathway.
	
Example usage form command line:
```
Rscript generate_bipartite_graph.R BRCA_1
```
Output from this script will be written to "TF_glycogene_grpahTables" which stores graph information in tabular outpu, as well as "TF_glycogene_graphs", which stores the graph structures as igraph objects, and stores glycosylation patwhay and TF signaling pathway enrichments.
