#Download&Install required libraries
source("http://bioconductor.org/biocLite.R")
biocLite("biomaRt")

#Define biomart object
library(biomaRt)
mart_ens_mm <- useMart(biomart = "ensembl", dataset = "mmusculus_gene_ensembl")

#Read in file with gene names (bed format)
refseq_bed <- read.table("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart.list")

#get sequence
seq <- getSequence(id = refseq_bed[,2], type="refseq_mrna",seqType="3utr",mart=mart_ens_mm)

#frameData <- data.frame(results$refseq_peptide_predicted, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart_3UTR.seq",seq,sep="\t",quote=F)

#get sequence
seq <- getSequence(id = refseq_bed[,2], type="refseq_mrna",seqType="5utr",mart=mart_ens_mm)

#frameData <- data.frame(results$refseq_peptide_predicted, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart_5UTR.seq",seq,sep="\t",quote=F)

#get sequence
seq <- getSequence(id = refseq_bed[,2], type="refseq_mrna",seqType="coding",mart=mart_ens_mm)

#frameData <- data.frame(results$refseq_peptide_predicted, results$refseq_mrna_predicted, results$refseq_mrna)
write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart_cds.seq",seq,sep="\t",quote=F)
