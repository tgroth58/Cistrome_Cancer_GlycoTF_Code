library(dplyr)
library(tidyr)
library(igraph)
load('../data/processed/merge_data_glycogenes_V2.rda')
load('../data/Glycogene_list.rda')
load('../data/pathLists_V2.rda')
source('./get_reactome_table.R')
source('./hyper_geo_test_tfList.R')

# Input:
args=commandArgs(trailingOnly=T)
ctype_input=args[1]

get_bipartite_graph<-function(df){
	#Get rid of OGT occurrence as a TF, because it is a glycogene:
	df<-df %>% filter(TF!='OGT')
	gph<-graph.data.frame(df,directed=F)
	V(gph)$type=V(gph)$name %in% df$TF
	#Create bipartite projection:
	gph_proj=bipartite_projection(gph)
	#Cluster the TFs based on the bipartite projection:
	TF_clust=fastgreedy.community(gph_proj$proj2)
	#Return things as a list:
	return(list('bp_graph'=gph,'TF_projection'=gph_proj$proj2,'clusters'=TF_clust))
}

input_net_data=merge_data_glycogenes %>% filter(RP>=0.5,cor>=0.4,ctype==ctype_input)

graphClust=get_bipartite_graph(input_net_data)
#Membership vector:
mem_vec=membership(graphClust$clusters)
#Merge the membership data with the input data matrix:
mem_df=data.frame(TF=names(mem_vec),clst=as.numeric(mem_vec))
clust_net_data<-input_net_data %>% inner_join(mem_df,by='TF') %>% mutate(BP=RP*cor)

tf_table <- clust_net_data %>% select(TF) %>% rename(key=TF) %>% mutate(nodeType='TF') %>% distinct()
ggene_table <- clust_net_data %>% select(gene) %>% mutate(nodeType='Glycogene') %>% rename(key=gene) 
node_data <- rbind(tf_table,ggene_table)

#For each membership, find enrichment to glycogene pathways and signaling pathways from reactome.
enrichments<-lapply(unique(mem_vec),function(cl){
	tfs=names(mem_vec[which(mem_vec==cl)])
	if (length(tfs)<5){
		return(NULL)
	} else {
		#Glycogene pathway enrichments:
		gg_enrich<-sapply(names(pathLists),function(x) path_hgt_list(input_net_data,pathLists[[x]],tfs))
		gg_enrich <- p.adjust(gg_enrich,'BH')
		#names(gg_enrich)=names(pathLists)
		#Reactome TF enrichment:
		tf_enrich<-get_reactome_enrich_table(tfs)
		return(list('ggenes'=gg_enrich,'tfs'=tf_enrich))
	}
})
names(enrichments) <- paste('cl',unique(mem_vec),sep='_')

graphClust[['enrichments']]=enrichments

save(file=file.path('TF_glycogene_graphs',paste(ctype_input,'communities.rda',sep='_')),graphClust)
write.table(file=file.path('TF_glycogene_graphTables',paste(ctype_input,'clustTable.tsv',sep='_')),sep='\t',row.names=F,quote=F,clust_net_data)
write.table(file=file.path('TF_glycogene_graphTables',paste(ctype_input,'nodeTable.tsv',sep='_')),sep='\t',row.names=F,quote=F,node_data)
