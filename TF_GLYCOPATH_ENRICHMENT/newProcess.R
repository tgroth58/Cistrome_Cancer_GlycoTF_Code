library(dplyr)
uncorrected_enrich<-do.call(rbind,lapply(list.files('./TF_glycopath_enrichment_results',pattern='cor.rda'),function(x){
	load(file.path('./TF_glycopath_enrichment_results',x))
	ct=unlist(strsplit(split='_pathway_enrich_RP_cor\\.rda',x=x))
	ctype_res_dta=ctype_res_dta %>% mutate(ctype=ct)
	return(ctype_res_dta)
})) %>% dplyr::filter(pEnrich<=0.05)
save(file='total_glycoPath_RP_cor_uncorrected_enrich.rda',uncorrected_enrich)

uncorrected_enrich<-do.call(rbind,lapply(list.files('./TF_glycopath_enrichment_results',pattern='cor.rda'),function(x){
	load(file.path('./TF_glycopath_enrichment_results',x))
	ct=unlist(strsplit(split='_pathway_enrich_RP_cor\\.rda',x=x))
	ctype_res_dta=ctype_res_dta %>% mutate(ctype=ct)
	return(ctype_res_dta)
})) %>% dplyr::filter(pEnrich<=0.05)
save(file='total_glycoPath_RP_cor_uncorrected_enrich.rda',uncorrected_enrich)

corrected_enrich<-do.call(rbind,lapply(list.files('./TF_glycopath_enrichment_results',pattern='cor_adj.rda'),function(x){
	load(file.path('./TF_glycopath_enrichment_results',x))
	ct=unlist(strsplit(split='_pathway_enrich_RP_cor_adj\\.rda',x=x))
	ctype_res_dta=ctype_res_dta %>% mutate(ctype=ct)
	return(ctype_res_dta)
})) %>% dplyr::filter(pEnrich<=0.05)
save(file='total_glycoPath_RP_cor_corrected_enrich.rda',corrected_enrich)
