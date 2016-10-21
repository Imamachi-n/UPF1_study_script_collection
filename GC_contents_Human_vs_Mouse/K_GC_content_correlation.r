#Title: Correlation plot
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-03-12

#library_preparation
require(data.table)
require(ggplot2)

filelist <- c("5UTR","CDS","3UTR")

#FUNCTION###############
comp_cor <- function(i){
  #1: ALL | 2: UPF1_targets | 3:UPF1_motif1_3UTR | 4:UPF1_motif1-4_3UTR | 5:UPF1_motif1_CDS | 6:PUM_motif1_3UTR
  input_dir1 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_All.txt",sep="")
  input_dir2 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_UPF1_targets.txt",sep="")
  input_dir3 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_UPF1_motif_in_3UTR_top1.txt",sep="")
  input_dir4 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_UPF1_motifs_in_3UTR_top1-4.txt",sep="")
  input_dir5 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_UPF1_motif_in_CDS_top1.txt",sep="")
  input_dir6 <- paste("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/GC_content_",i,"_mm_PUM_motif_in_3UTR.txt",sep="")
  
  input_file1 <- fread(input_dir1,header=F)[[1]]
  input_file2 <- fread(input_dir2,header=F)[[1]]
  input_file3 <- fread(input_dir3,header=F)[[1]]
  input_file4 <- fread(input_dir4,header=F)[[1]]
  input_file5 <- fread(input_dir5,header=F)[[1]]
  input_file6 <- fread(input_dir6,header=F)[[1]]
  
  setwd("C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result")
  fig_name <- paste("Boxplot_GC_content_",i,"_mm.png",sep="")
  png(fig_name,width = 600,height = 1300)
  boxplot(input_file1,input_file2,input_file3,input_file4,input_file5,input_file6,main="",ylab="GC-content",ylim=c(0,100))
  dev.off()
  
  print(wilcox.test(input_file1,input_file2))
  print(wilcox.test(input_file1,input_file3))
  print(wilcox.test(input_file1,input_file4))
  print(wilcox.test(input_file1,input_file5))
  print(wilcox.test(input_file1,input_file6))
  
  print(summary(input_file1))
  print(summary(input_file2))
  print(summary(input_file3))
  print(summary(input_file4))
  print(summary(input_file5))
  print(summary(input_file6))
  
 #write.table(file="C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Boxplot_GC_content_",i,"_mm.png",wilcox_test_1_2,sep="\t",quote=F)
  
}

#MAIN###################
for(i in 1:3){
  file_input <- filelist[i]
  comp_cor(file_input)
}
