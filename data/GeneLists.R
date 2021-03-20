#New Glycogene Pathway Lists:

GSL_Core<-c('UGCG','B4GALT3','B4GALT4','B4GALT5','B4GALT6','UGT8','ST3GAL5','GAL3ST1')
P1PK_BloodGroup<-c('A4GALT','B3GALNT1','B3GNT5','B4GALT1','B4GALT2','B4GALT3','B4GALT4','B4GALT5','B4GALT6')
Gangliosides<-c('B4GALNT1','ST3GAL2','ST3GAL3','ST3GAL4','ST3GAL5','ST6GALNAC3','ST6GALNAC4','ST6GALNAC5','ST6GALNAC6','ST8SIA1','ST8SIA3','ST8SIA5')
Dolichol<-c('ALG1','ALG10','ALG10B','ALG11','ALG12','ALG13','ALG14','ALG2','ALG3','ALG5','ALG6','ALG8','ALG9','DPAGT1','DPM1','DPM2','DPM3','STT3A','STT3B','RTF1','DAD1','DDOST','RPN1','RPN2','MAGT1','TUSC3')
Complex_Nlinked<-c('MOGS','GANAB','MAN1A1','MAN1A2','MAN1B1','MAN1C1','MAN2A1','MAN2A2','MGAT1','UGGT1','UGGT2')
N_linked_branching<-c('MGAT1','MGAT2','MGAT3','MGAT4','MGAT4A','MGAT5','MGAT5B','FUT8')
GalNAc_Olinked<-c('C1GALT1','C1GALT1C1','GCNT1','GCNT4','GALNT1','GALNT2','GALNT3','GALNT4','GALNT5','GALNT6','GALNT7','GALNT8','GALNT9','GALNT10','GALNT11','GALNT12','GALNT13','GALNT14','GALNT15','GALNT16','GALNT17','GALNT18','ST3GAL1','ST6GALNAC1','ST6GALNAC2','B3GNT3','G3GNT6','CHST4')
CS_HS_Init<-c('XYLT1','XYLT2','B4GALT7','B3GAT3','FAM20B','CSGALNACT1','CSGALNACT2','EXTL3')
CS_DS_Extend<-c('CSGALNACT1','CSGALNACT2','CHSY1','CHSY3','CHPF','CHPF2','CHST3','CHST7','CHST11','CHST12','CHST13','CHST14','CHST15','UST','DSE','DSEL')
HS_Extend<-c('EXT1','EXT1','EXTL1','EXTL2','EXTL3','HS2ST1','HS3ST1','HS3ST2','HS3ST3A1','HS3ST3B1','HS3ST4','HS3ST5','HS3ST6','HS6ST1','HS6ST2','HS6ST3','GLCE','NDST1','NDST2','NDST3','NDST4')
HA_Synthesis<-c('HAS1','HAS2','HAS3')
O_mannose<-c('POMT1','POMT2','POMGNT1','POMGNT2','MGAT5B','B4GALT1','B4GALT2','B4GALT3','B4GALT4','B4GALT5','B3GALNT2')
O_fucose<-c('POFUT1','POFUT2','RFNG','LFNG','MFNG','B4GALT1','B4GALT2','B4GALT3','B4GALT4','B4GALT5','ST3GAL1','ST3GAL2','ST3GAL3','ST3GAL4','ST3GAL5','ST3GAL6','ST6GAL1','ST6GAL2')
Type_1_2_LacNAc<-c('B3GALT1','B3GALT2','B3GALT4','B3GALT5','B4GALT1','B4GALT2','B4GALT3','B4GALT4','B4GALT5','B4GALT6','B3GNT2','B3GNT3','B3GNT4','B3GNT5','B3GNT6','B3GNT7','B3GNT8','GCNT1','GCNT2','GCNT3','GCNT4')
SA_paths<-c('ST3GAL1','ST3GAL2','ST3GAL3','ST3GAL4','ST3GAL5','ST3GAL6','ST6GAL1','ST6GAL2','ST6GALNAC1','ST6GALNAC2','ST6GALNAC3','ST6GALNAC4','ST6GALNAC5','ST6GALNAC6','ST8SIA1','ST8SIA2','ST8SIA3','ST8SIA4','ST8SIA5','ST8SIA6')
Blood_Groups<-c('ABO','B3GALT1','B3GALT2','B3GALT4','B3GALT5','FUT1','FUT2')
LacdiNAc<-c('B3GALT1','B3GALT2','B3GALT4','B3GALT5','B3GALT6','B4GALNT3','B4GALNT4','C1GALT1','CHST8','CHST9','GCNT1','GCNT4')
Terminal_Fucose<-c('FUT1','FUT2','FUT3','FUT4','FUT5','FUT6','FUT7','FUT9')
sulfated_glycans<-c('B3GAT1','B3GAT2','B4GALT1','B4GALT2','B4GALT3','B4GALT4','B4GALT5','B4GALT6','FUT3','FUT4','FUT7','FUT6','FUT9','ST3GAL1','ST3GAL2','ST3GAL3','ST3GAL4','ST3GAL5','ST3GAL6','CHST2','CHST10','CHST4','GAL3ST2','GAL3ST3','GAL3ST4')
GPI_Anchor<-c('PIGA','PIGC','PIGH','PIGP','PIGQ','PIGY','DPM2','PIGL','PIGW','PIGM','PIGX','PIGV','PIGN','PIGB','PIGF','PIGO','PIGF','PIGG','PIGK','GPAA1','PIGS','PIGT','PIGU')

pathLists<-list(GPI_Anchor,sulfated_glycans,Terminal_Fucose,LacdiNAc,Blood_Groups,SA_paths,Type_1_2_LacNAc,O_fucose,O_mannose,HA_Synthesis,HS_Extend,CS_DS_Extend,CS_HS_Init,GalNAc_Olinked,N_linked_branching,Complex_Nlinked,Dolichol,Gangliosides,P1PK_BloodGroup,GSL_Core)
names(pathLists)<-c('GPI_Anchor','sulfated_glycans','Terminal_Fucose','LacdiNAc','Blood_Groups','SA_paths','Type_1_2_LacNAc','O_fucose','O_mannose','HA_Synthesis','HS_Extend','CS_DS_Extend','CS_HS_Init','GalNAc_Olinked','N_linked_branching','Complex_Nlinked','Dolichol','Gangliosides','P1PK_BloodGroup','GSL_Core')
nameMap=list('GPI_Anchor'='GPI Anchor Extension',
	'sulfated_glycans'='Sulfated Glycans',
	'Terminal_Fucose'='Terminal Fucose',
	'LacdiNAc'='LacdiNAc',
	'Blood_Groups'='Blood Groups',
	'SA_paths'='Sialyltransferases',
	'Type_1_2_LacNAc'='Type-1 & Type-2 LacNAc',
	'O_fucose'='O-linked Fucose',
	'O_mannose'='O-linked Mannose',
	'HA_Synthesis'='Hyaluronan Synthesis',
	'HS_Extend'='Heparan Sulfate Synthesis',
	'CS_DS_Extend'='Chondroitin and Dermatan Sulfate Extension',
	'CS_HS_Init'='Chondroitin and Heparan Sulfate Initiation',
	'GalNAc_Olinked'='O-linked Glycans',
	'N_linked_branching'='Branched N-linked Glycans',
	'Complex_Nlinked'='Complex N-linked Glycans',
	'Dolichol'='Dolichol Pathway',
	'Gangliosides'='Gangliosides',
	'P1PK_BloodGroup'='P1/PK Blood Groups',
	'GSL_Core'='Glycosphingolipid Core Synthesis'
)
save(file='new_pathLists.rda',pathLists)
save(file='pathLists_V2.rda',pathLists)
save(file='nameMap.rda',nameMap)
