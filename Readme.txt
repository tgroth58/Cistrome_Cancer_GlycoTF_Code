Code for the manuscript:
"A systems based framework to deduce transcription factors and signaling pathways regulating glycan biosynthesis"

Directory Descriptions:

TF_GLYCOPATHWAY_ENRICHMENT:
	TF_glycoPathway_enrichment.R: Computed Fisher's exact test p-values for TF-glycosylation pathway relationships present in a cancer type.  The script takes the name of a TCGA cancer analyzed in this work as an argument.  All TCGA cancer types are available in the "cancer_types.tsv" file in the "data" folder of this repository
	hyper_geo_test_single.R: Given a set of TF-glycogene relationships a cancer type, it constructs a contingency matrix to determine if a TF disproportionately regulates a glycosylation pathway.

	Example Usage from command line:
	Rscript TF_glycoPathway_enrichment.R BRCA_1
	
	Output from this script will be written into "TF_glycopath_enrichment_results"

TF_REACTOME_ENRICHMENT
	TF_reactome_enrich.R: For all glycosylation pathways that had enriched TFs for a cancer type, a Reactome overrepresentation analysis is conducte using Reactome's API.  The input argument to this script is a file name found within "./TF_GLYCOPATHWAY_ENRICHMENT/TF_glycopath_enrichment_results".  The output is a table of Reactome pathway results matched with corresponding glycosylation pathways.
	get_reactome_table.R: Constructs the Reactome API call using the list of TFs enriched to a particular glycosylation pathway.

	Example usage from command line:
	Rscript TF_glycoPathway_enrichment.R BRCA_1_pathway_enrich_RP_cor.rda

	Output from this script will be written into "TF_signaling_enrichment_results"

TF_GLYCOGENE_NETWORKS
	
TF_RRA_TESTING:
	RRA_testing.R: Reads the agglomerated TF-glycosylation pathway results computed across all cancer types and performs robust rank aggregation to find TFs that pervasively regulate 	
