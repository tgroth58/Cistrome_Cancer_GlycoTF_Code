library(dplyr)
library(tidyr)

graphFiles=list.files('./TF_glycogene_graphs',pattern='_communities.rda')

graph_enrich_lists <- lapply(graphFiles,function(f) {
		load(file.path('./TF_glycogene_graphs',f)) #Loads something called "graphClust"
		ctype_name=unlist(strsplit(split='\\_communities\\.rda',x=f))[1]
		#Get Clusters that actually have enrichment data associated with them


		clustNames=names(graphClust$enrichments)
		clustNames=clustNames[sapply(clustNames, function(x) !is.null(graphClust$enrichments[[x]]))]
		enrich_clusts <- graphClust$enrichments[clustNames]
		names(enrich_clusts) <- clustNames
		#Generate Significant Glycogene Path table:
		ggene_perturb_table <- do.call(rbind,lapply(enrich_clusts, function(x) x$ggenes)) %>% as.data.frame() %>% 
			mutate(clustName=names(enrich_clusts)) %>%
			pivot_longer(cols=colnames(.)[colnames(.)!='clustName']) %>%
			mutate(value=unlist(value)) %>% 
			mutate(ctype=ctype_name) %>%
			dplyr::filter(value<=0.05) %>%
			rename(pEnrich=value,glycoPath=name)

		#Generate Significant TF pathway Enrichment Table:
		tf_path_perturb_table <- do.call(rbind,lapply(names(enrich_clusts), function(x) enrich_clusts[[x]]$tf %>% select(path,entities,entitiesFDR) %>% rename(value=entitiesFDR) %>% mutate(clustName=x) )) %>% 
		mutate(ctype=ctype_name) %>%
		dplyr::filter(value<=0.1)
		
		return(list('ggene'=ggene_perturb_table,'tf'=tf_path_perturb_table))
})

ggene_enrich_table <- do.call(rbind,lapply(graph_enrich_lists,function(l){
		l$ggene
}))
tf_enrich_table <- do.call(rbind,lapply(graph_enrich_lists,function(l){
		l$tf
}))
		
write.table(file='glycogene_network_glycoPath_enrichment.tsv',sep='\t',quote=F,row.names=F,ggene_enrich_table)
write.table(file='glycogene_network_TFpath_enrichment.tsv',sep='\t',quote=F,row.names=F,tf_enrich_table) 

