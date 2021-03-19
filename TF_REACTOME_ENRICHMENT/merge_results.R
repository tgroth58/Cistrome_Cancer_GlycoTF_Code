library(dplyr);library(tidyr)

flist=list.files('./TF_signaling_enrichment_results',pattern='*reactome_enrich.rda')

ctype_enrichments <- sapply(flist,function(x){
				    load(file.path('./TF_signaling_enrichment_results',x))
				    return(resMat)
				})
names(ctype_enrichments) <- sapply(flist,function(x){
				unlist(strsplit(split="\\_reactome\\_enrich\\.rda",x=x))[1]
				})

#Remove elements that are NULL
ctype_enrichments <- ctype_enrichments[sapply(names(ctype_enrichments),function(x) !(is.null(ctype_enrichments[[x]])))]

total_cancer_enrich=do.call(rbind,lapply(names(ctype_enrichments),function(x) {
		dta <- ctype_enrichments[[x]] %>% mutate(ctype=x)
		return(dta)
		}))

#Filter for statistically significant enrichments:
total_cancer_enrich=total_cancer_enrich %>% 
	filter(entitiesFDR<=0.1)
save(file=file.path("./TF_signaling_enrichment_results","all_cancer_enrich.rda"),total_cancer_enrich)
