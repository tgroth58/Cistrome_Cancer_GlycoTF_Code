library(rjson);library(dplyr)

get_reactome_enrich_table<-function(gene_vector){
	#Store Command to run in command line:
	#All results will be recorded if the overrepresentation 
	# value is <=0.05 (change the number at "pValue=" in the URL 
	# to change the cutoff.
	cmd='curl -X POST "https://reactome.org/AnalysisService/identifiers/?interactors=false&pageSize=20&page=1&sortBy=ENTITIES_PVALUE&order=ASC&resource=TOTAL&pValue=0.05&includeDisease=true" -H  "accept: application/json" -H  "content-type: text/plain" -d'
	#Create search vector:
	svct=paste('\"',paste(gene_vector,collapse=','),'\"',sep='')
	
	#Create the curl command:
	total_curl=paste(cmd,svct,sep=' ')
	#Get the query result and convert to JSON:
	res<-fromJSON(system(total_curl,intern=T))
	#Now, get the token from res and pass it to another api to get a table with more information:
	tkn<-as.character(res$summary$token)
	print(paste('Token:',tkn))
	cmd_tab=paste('curl -X GET "https://reactome.org/AnalysisService/download/',tkn,'/result.json" -H "accept: application/json"',sep='')

	res_tab<-fromJSON(system(cmd_tab,intern=T))
	pth_dta<-res_tab$pathways[which(lapply(res_tab$pathways,function(x) x$species$name)=='Homo sapiens')]
	tbl<-lapply(pth_dta,function(x){
		do.call(rbind,lapply(x$data$statistics,unlist)) %>% cbind(path=x$name,entities=paste(lapply(x$data$entities, function(z) z$id),collapse=';'))
		}) 
	tbl<-do.call(rbind,tbl) %>% as.data.frame() %>%filter(resource=='TOTAL')
	#Return result:
	return(tbl)
}

