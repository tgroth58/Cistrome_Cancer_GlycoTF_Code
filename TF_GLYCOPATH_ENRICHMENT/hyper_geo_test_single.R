path_hgt<-function(gene_TF_data,pathList,tf){
	#Variable in the "gene_TF_data" variable is cancer type:
	#Make contingency table:
	mtx<-matrix(rep(0,4),nrow=2)
	#Build Contingency Table:	
	mtx[1,1]=nrow( gene_TF_data %>% filter(TF==tf & gene %in% pathList) )
	mtx[1,2]=nrow( gene_TF_data %>% filter(TF==tf & !(gene %in% pathList)) )
	mtx[2,1]=nrow( gene_TF_data %>% filter(TF!=tf & gene %in% pathList) ) 
	mtx[2,2]=nrow( gene_TF_data)-sum(c(mtx[1,1],mtx[1,2],mtx[2,1]) )
	#Format mtx :
	mtx<-as.table(mtx)
	#HyperGeoTest :
	hgt<-fisher.test(mtx,alternative='greater')$p.value
	#Return HyperGeoTest test p-value:
	return(hgt)
}
