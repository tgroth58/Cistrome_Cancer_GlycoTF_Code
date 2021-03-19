library(dplyr);library(tidyr);library(ggplot2);library(parallel)
source('./hyper_geo_test_single.R')
load('../data/processed/merge_data_glycogenes_V2.rda')
load('../data/pathLists_V2.rda')

#Get top data for cancer type:
args=commandArgs(trailingOnly=T)
ctype_input=args[1]
#Get top data, and filter for cancer type:
top_cor<-merge_data_glycogenes %>% filter(RP>=0.5 & cor>=0.4 & ctype==ctype_input)

#For all the transcription factors, do Fisher's exact test.
ctype_res<-mclapply(unique(top_cor$TF),function(tf){
	res <- sapply(names(pathLists),function(p){
		return(path_hgt(top_cor,pathLists[[p]],tf))
	},USE.NAMES=T)
	#p-value adjustment done per cancer type:
	res_corrected <- p.adjust(res,method='BH',n=length(res))
	return(list("enrichments"=res,"enrichments_corrected"=res_corrected))
},mc.cores=12)

names(ctype_res)<-unique(top_cor$TF)
#Convert all the data into a nice dataframe
#ctype_res<-as.data.frame(ctype_res) %>% mutate(glycoPath=row.names(.)) %>% pivot_longer(cols=colnames(.)[colnames(.)!='glycoPath']) %>% rename(TF=name,pEnrich=value) %>% group_by(glycoPath) %>% mutate(pEnrich_fdr=p.adjust(pEnrich,method='fdr',n=n())) 

#Parse and save uncorrected data:
ctype_res_dta<- as.data.frame(lapply(ctype_res,function(x) x[['enrichments']])) %>% mutate(glycoPath=row.names(.)) %>% pivot_longer(cols=colnames(.)[colnames(.)!='glycoPath']) %>% rename(TF=name,pEnrich=value) %>% group_by(glycoPath)
save(file=file.path('./TF_glycopath_newLists_results_V2',paste(ctype_input,'pathway_enrich_RP_cor.rda',sep='_')),ctype_res_dta)

#Parse and save corrected data:
ctype_res_dta_corrected<- as.data.frame(lapply(ctype_res,function(x) x[['enrichments_corrected']])) %>% mutate(glycoPath=row.names(.)) %>% pivot_longer(cols=colnames(.)[colnames(.)!='glycoPath']) %>% rename(TF=name,pEnrich=value) %>% group_by(glycoPath)
save(file=file.path('./TF_glycopath_newLists_results_V2',paste(ctype_input,'pathway_enrich_RP_cor_adj.rda',sep='_')),ctype_res_dta)
