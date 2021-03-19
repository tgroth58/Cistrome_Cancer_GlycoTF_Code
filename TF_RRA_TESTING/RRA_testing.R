load('total_RP_cor_enrich.rda');load('../data/nameMap.rda')
library(RobustRankAggreg)
library(dplyr);library(reshape2);library(ggplot2);library(stringr)

total_res_RP_cor<-total_RP_cor_enrich %>% rename(path=glycoPath,p_enrich=pEnrich) %>% select(-pEnrich_fdr) %>% ungroup(path)

glycoPath_rank_stats<-lapply(unique(total_res_RP_cor$path),function(pth){
	total_TF=total_res_RP_cor %>% filter(path==pth) %>% nrow()
	#Get a list of significantly enriched TFs for the 
	# glycopathway "pth".  Significant enrichments 
	# only (p_enrich<=0.05)
	cancer_lists<-lapply(unique(total_res_RP_cor$ctype),function(ct){
		total_res_RP_cor %>% filter(path==pth,ctype==ct,p_enrich<=0.05) %>%
		arrange(p_enrich) %>% select(TF) %>%
		as.matrix() %>% as.character()
	})
	names(cancer_lists)<-unique(total_res_RP_cor$ctype)
	#Robust rank aggregation is performed assuming the total number 
	# of genes in the rank aggregation, "N" is equal to the number
	# of unique TFs with enrichment p-value <= 0.05:
	N_sigTFs=length(unique(unlist(cancer_lists)))
	aggregateRanks(glist=cancer_lists,N=N_sigTFs)
})

names(glycoPath_rank_stats)<-unique(total_res_RP_cor$path)

glycoPath_rank_stats <- do.call(rbind,lapply(names(glycoPath_rank_stats), function(x) {
		dta <- as.data.frame(glycoPath_rank_stats[[x]]) %>% mutate(glycoPath=x)
		return(dta)
	}))

#Save robust rank aggreg results:
save(file='glycoPath_rank_stats_modList.rda',glycoPath_rank_stats)
