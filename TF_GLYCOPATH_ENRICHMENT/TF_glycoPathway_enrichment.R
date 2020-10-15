library(dplyr);library(tidyr);library(ggplot2);library(parallel)
source('./hyper_geo_test_single.R')
load('../data/processed/merge_data_glycogenes.rda')
load('../data/pathLists.rda')

#Get top data for cancer type:
args=commandArgs(trailingOnly=T)
ctype_input=args[1]
#Get top data, and filter for cancer type:
top_cor<-merge_data_glycogenes %>% filter(RP>=0.5,cor>=0.4,ctype==ctype_input)

#For all the transcription factors, do Fisher's exact test.
ctype_res<-mclapply(unique(top_cor$TF),function(tf){
	sapply(names(pathLists),function(p){
		return(path_hgt(top_cor,pathLists[[p]],tf))
	},USE.NAMES=T)
},mc.cores=12)

names(ctype_res)<-unique(top_cor$TF)
#Convert all the data into a nice dataframe
ctype_res<-as.data.frame(ctype_res) %>% mutate(glycoPath=row.names(.)) %>% pivot_longer(cols=colnames(.)[colnames(.)!='glycoPath']) %>% rename(TF=name,pEnrich=value)
save(file=file.path('./TF_glycopath_enrichment_results',paste(ctype_input,'pathway_enrich_RP_cor.rda',sep='_')),ctype_res)
