library(dplyr)
uncorrected_enrich<-do.call(rbind,lapply(list.files('./TF_glycopath_newLists_results_V2',pattern='cor.rda'),function(x){
	load(file.path('./TF_glycopath_newLists_results_V2',x))
	ct=unlist(strsplit(split='_pathway_enrich_RP_cor\\.rda',x=x))
	ctype_res=ctype_res %>% mutate(ctype=ct)
	return(ctype_res)
})) %>% dplyr::filter(pEnrich<=0.05)
save(file='total_glycoPath_RP_cor_uncorrected_enrich.rda',uncorrected_enrich)


corrected_enrich<-do.call(rbind,lapply(list.files('./TF_glycopath_newLists_results_V2',pattern='cor_alt.rda'),function(x){
	load(file.path('./TF_glycopath_newLists_results_V2',x))
	ct=unlist(strsplit(split='_pathway_enrich_RP_cor_alt\\.rda',x=x))
	ctype_res=ctype_res %>% mutate(ctype=ct)
	return(ctype_res)
})) %>% dplyr::filter(pEnrich<=0.05)
save(file='total_glycoPath_RP_cor_uncorrected_enrich.rda',corrected_enrich)
