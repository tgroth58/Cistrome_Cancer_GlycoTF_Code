load('TF_glycoPath_allCancer.rda');load('../data/nameMap.rda')
library(RobustRankAggreg)
library(dplyr);library(reshape2);library(ggplot2);library(stringr)

total_res_RP_cor<-total_RP_cor_modList %>% rename(path=glycoPath,p_enrich=pEnrich)

glycoPath_rank_stats<-lapply(unique(total_res_RP_cor$path),function(pth){
	cancer_lists<-lapply(unique(total_res_RP_cor$ctype),function(ct){
		total_res_RP_cor %>% filter(path==pth,ctype==ct,p_enrich<=0.05) %>% arrange(p_enrich) %>% select(TF) %>% as.matrix() %>% as.character()
	})
	names(cancer_lists)<-unique(total_res_RP_cor$ctype)
	aggregateRanks(glist=cancer_lists,N=length(unique(unlist(cancer_lists))))
})
names(glycoPath_rank_stats)<-unique(total_res_RP_cor$path)

#Save robust rank aggreg results:
save(file='glycoPath_rank_stats_modList.rda',glycoPath_rank_stats)
