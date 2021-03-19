library(dplyr)
library(ggplot2)
library(ggalluvial)
library(stringr)
load('nameMap.rda')
load('reactome_mapping.rda')
#Process dta:
#Count up the number of occurrences that a sigaling pathway matches with a glycosylation pathway:
load('./TF_signaling_enrichment_results/all_cancer_enrich.rda')
total_cancer_enrich=total_cancer_enrich %>% mutate(
		entitiesCount=as.numeric(as.character(entitiesCount)),
		entitiesFDR=as.numeric(as.character(entitiesFDR)),
		ctype=as.character(ctype)
	)

dta_plot<-total_cancer_enrich %>% filter(entitiesCount<=30,entitiesFDR<=0.1) %>%
       	group_by(ctype) %>%  top_n(n=30,wt=-entitiesFDR) %>% select(path,entities,glycoPath,ctype) %>% group_by(ctype,path,glycoPath) %>% summarize(count=n()) %>% ungroup(ctype,path,glycoPath) 

#THIS BLOCK WORKS:
#dta_plot<-total_cancer_enrich %>% filter(entitiesCount<=30,entitiesFDR<=0.1) %>% group_by(ctype) %>%  select(path,entities,glycoPath,ctype) %>% group_by(ctype,path,glycoPath) %>% summarize(count=n()) %>% ungroup(ctype,path,glycoPath) %>% 
#	arrange(-entitiesFDR) %>% group_by(ctype) %>% top_n(n=30,wt=-entitiesFDR) %>% ungroup(ctype)
#dta_plot<-total_cancer_enrich %>% filter(entitiesFDR<=0.1) %>% group_by(ctype) %>%  select(path,entities,glyco_path,ctype) %>% group_by(ctype,path,glyco_path) %>% summarize(count=n()) %>% ungroup(ctype,path,glyco_path)
#Match up the transcription factors that were also found to be merged there :
dta_plot<-dta_plot %>% left_join(total_cancer_enrich %>% select(path,glycoPath,ctype,entities),by=c('ctype','path','glycoPath'))
dta_plot<-apply(dta_plot,1,function(x){
	do.call(rbind,lapply(unlist(strsplit(split=';',x=x['entities'])),function(tf){
		c(x[1:4],'TF'=tf)
	}))
})
dta_plot<-do.call(rbind,dta_plot)
dta_plot<-as.data.frame(dta_plot)
dta_plot$path<-sapply(as.character(dta_plot$path),function(x){
		 ifelse(is.null(reactome_mapping[[x]]),x,reactome_mapping[[x]])
})
dta_plot$glycoPath<-sapply(as.character(dta_plot$glycoPath),function(x){
		 ifelse(is.null(nameMap[[x]]),x,nameMap[[x]])
})

lapply(unique(dta_plot$ctype),function(ct){
	ctype_dta<-dta_plot %>% filter(ctype==ct)
	p<-ggplot(ctype_dta,aes(axis1=path,axis2=TF,axis3=glycoPath)) + geom_alluvium(aes(fill=glycoPath),width=0.65) + geom_stratum(width=0.65,color='gray') + scale_x_discrete(limits=c('Signaling Pathways','Transcription Factors','Glycosylation Pathways')) + geom_text(stat='stratum',infer.label=T,size=2) + labs(title=paste(ct,'Signaling to Glycosylation Pathway Matching'),x='Pathways',y='count') + guides(fill=guide_legend(title='Glycosylation Pathway')) + theme_minimal() + theme(legend.position='bottom',legend.text=element_text(size=8),legend.title=element_text(size=10),axis.title=element_blank(),panel.grid=element_blank(),axis.text.y=element_blank(),axis.text.x=element_text(size=9))
	ggsave(filename=file.path('alluvials_less',paste(ct,'pathwayPlot.png',sep="_")),plot=p,width=8.5,height=10,units='in')
})
