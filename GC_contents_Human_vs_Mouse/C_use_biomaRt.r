#Download&Install required libraries
source("http://bioconductor.org/biocLite.R")
biocLite("biomaRt")
biocLite("GSEABase")
biocLite("GOstats")

#Define biomart object
library(biomaRt)
mart_ens_mm <- useMart(biomart = "ensembl", dataset = "mmusculus_gene_ensembl")
###"hsapiens_gene_ensembl" <= Homo sapiens genes (GRCh37.p12)
###" btaurus_gene_ensembl" <=  Bos taurus genes (UMD3.1)

###"mmusculus_gene_ensembl" <= Mus musculus genes (GRCm38.p1)

#Read in file with gene names (bed format)
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1_Mus_musculus_XP.list")


#Extract information from biomart
results <- getBM(attributes = c("refseq_peptide_predicted","refseq_mrna_predicted","refseq_mrna"),filters="refseq_peptide_predicted",values=refseq_bed[,1],mart=mart_ens_mm)
#results <- getBM(attributes = c("refseq_mrna","refseq_peptide"),filters="refseq_mrna",values=refseq_bed[,1],mart=mart_ens_mm)
#results <- getBM(attributes = c("refseq_mrna","refseq_mrna_predicted","refseq_peptide","refseq_peptide_predicted"),mart=mart_ens_mm)
#results <- getBM(attributes = c("refseq_mrna","uniprot_genename","go_id","go_linkage_type","name_1006"),filters="refseq_mrna",values=refseq_bed[,4],mart=mart_ens_hs)
### name_1006: GO Term Name
### go_linkage_type: GO Term Evidence Code

#make annotation data (go_id, Evidence_code, refseq_id)
#goframeData <- data.frame(results$go_id, results$go_linkage_type, results$refseq_mrna)
frameData <- data.frame(results$refseq_peptide_predicted, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_mmusculus_XP.txt",frameData,sep="\t",quote=F)

#get sequence
#seq <- getSequence(id = c("NM_001103162","NM_001001182"), type="refseq_mrna",seqType="3utr",mart=mart_ens_hs)
seq <- getSequence(id = c("XM_006509459"), type="refseq_mrna_predicted",seqType="3utr",mart=mart_ens_hs)
seq <- getSequence(id = c("XM_006509459"), type="refseq_mrna_predicted",seqType="3utr",mart=mart_ens_hs)

########################
#Homo sapiens_NP
mart_ens_hs <- useMart(biomart = "ensembl", dataset = "hsapiens_gene_ensembl")
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1_Homo_sapiens_NP.list")
results <- getBM(attributes = c("refseq_peptide","refseq_mrna_predicted","refseq_mrna"),filters="refseq_peptide",values=refseq_bed[,1],mart=mart_ens_hs)
frameData <- data.frame(results$refseq_peptide, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Homo_sapiens_NP.txt",frameData,sep="\t",quote=F)
#Homo sapiens_XP
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1_Homo_sapiens_XP.list")
results <- getBM(attributes = c("refseq_peptide_predicted","refseq_mrna_predicted","refseq_mrna"),filters="refseq_peptide_predicted",values=refseq_bed[,1],mart=mart_ens_hs)
frameData <- data.frame(results$refseq_peptide, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Homo_sapiens_XP.txt",frameData,sep="\t",quote=F)

#Mus musculus_NP
mart_ens_hs <- useMart(biomart = "ensembl", dataset = "mmusculus_gene_ensembl")
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1_Mus_musculus_NP.list")
results <- getBM(attributes = c("refseq_peptide","refseq_mrna_predicted","refseq_mrna"),filters="refseq_peptide",values=refseq_bed[,1],mart=mart_ens_hs)
frameData <- data.frame(results$refseq_peptide, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Mus_musculus_NP.txt",frameData,sep="\t",quote=F)
#Mus musculus_XP
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1_Mus_musculus_XP.list")
results <- getBM(attributes = c("refseq_peptide_predicted","refseq_mrna_predicted","refseq_mrna"),filters="refseq_peptide_predicted",values=refseq_bed[,1],mart=mart_ens_hs)
frameData <- data.frame(results$refseq_peptide, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Mus_musculus_XP.txt",frameData,sep="\t",quote=F)
