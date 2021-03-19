library(dplyr);library(tidyr)

flist=list.files(pattern='*.rda')

total_RP_cor_enrich <- do.call(rbind,lapply(flist,function(x){
				    load(x)
				    prefix=unlist(strsplit(split="\\_pathway\\_enrich\\_RP\\_cor\\.rda",x=x))[1]
				    dta=ctype_res %>% mutate(ctype=prefix)
				    return(dta)
				}))

#Remove elements that are NULL

save(file='../total_RP_cor_enrich.rda',total_RP_cor_enrich)
