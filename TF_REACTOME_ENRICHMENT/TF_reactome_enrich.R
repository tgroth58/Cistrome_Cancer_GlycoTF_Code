library(dplyr)
source('./get_reactome_table.R')

args=commandArgs(trailingOnly=T)

ctype_enrichData=args[1]
#Load the TF-glycosylation pathway data.  Loaded as "ctype_res_dta"
# loaded from the TF_GLYCOPATH_ENRICHMENT/TF_glycopath_enrichment_results directory:
f_path='../TF_GLYCOPATH_ENRICHMENT/TF_glycopath_enrichment_results'
load(file.path(f_path,paste(ctype_enrichData,'_pathway_enrich_RP_cor.rda',sep='')))
prefix=unlist(strsplit(split='_pathway_enrich_RP_cor.rda',x=ctype_enrichData))[1]

#For each glycosylation pathway, find the TFs
# that have glycosylation pathway enrichment values <=0.05, and find which signaling 
# pathways they're associated with.

res<-sapply(unique(ctype_res_dta$glycoPath),function(pth){
	#Filter total_tf_glyco_dta_new for this combination of 
	# path and cancer type and pvalue<=0.05
	dta<-ctype_res_dta %>% filter(glycoPath==pth,pEnrich<=0.05)
	#Get a list of TFs, if there are any.
	# Else, return an empty list.
	if (nrow(dta)<3){
		message(paste(pth,'has less than 3 TFs enriched,skipping...',sep=' '))
	} else {
		message(paste('Found',nrow(dta),'TFs enriched to the',pth,'glycosylation pathway.  Analyzing...',sep=' '))
		geneList<-as.character(dta$TF)
		#Pass genelist onto "get_reactome_data"
		#Returns a list object that was created from rjson
		pth_dta<-get_reactome_enrich_table(geneList)
		return(pth_dta)
	}
},USE.NAMES=T)
message('Done querying reactomeDB')
res[sapply(res,is.null)]=NULL
resMat=do.call(rbind,lapply(names(res),function(x){
	res[[x]] %>% mutate(glycoPath=x)
}))
save_path='TF_signaling_enrichment_results'
save(file=file.path(save_path,paste(prefix,'reactome_enrich.rda',sep='_')),resMat)
