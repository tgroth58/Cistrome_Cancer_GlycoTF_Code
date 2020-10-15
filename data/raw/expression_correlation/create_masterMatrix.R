library(dplyr);library(reshape2)

#Regular Potentials File List:
f_list=grep('.csv',list.files('./'),value=T)

EP_MasterMatrix=do.call(rbind,lapply(f_list,function(x){
	return(read.table(file=x,sep=',',header=T) %>%
		rename(gene=colnames(.)[1]) %>%
		mutate(TF=unlist(strsplit(split='\\.',x=x))[1]) %>%
		melt(id.vars=c('TF','gene')) %>%
		rename(ctype=variable,cor=value)
		)
	})
)
save(file='../EP_MasterMatrix.rda',EP_MasterMatrix)
