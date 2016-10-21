#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=32G
#$ -l mem_req=32G

region="/home/akimitsu/database/Refseq_genes_May_14_2013.bed"
region2="/home/akimitsu/database/Refseq_genes_May_14_2013_3UTR.bed"

input="SRR2051421_WT_CLIP_rep1_4_result.bam"
output="SRR2051421_WT_CLIP_rep1_4_result.pk"

input2="SRR2051421_WT_CLIP_rep1_4_result_copy_ver2.pk"
output2="SRR2051421_WT_CLIP_rep1_4_result_copy_ver2_2.pk"

input3="SRR2051421_WT_CLIP_rep1_4_result_copy_ver2_result.pk"
input4="SRR2051421_WT_CLIP_rep1_4_result_copy_ver2"

# Peak calling
pyicoclip ${input} ${output} -f bam --region ${region}
pyicoclip ${input2} ${output2} --region ~/database/Refseq_genes_hg19_May_14_2013.bed
cat ${input3}_chr1 ${input3}_chr2 ${input3}_chr3 ${input3}_chr4 ${input3}_chr5 ${input3}_chr6 ${input3}_chr7 ${input3}_chr8 ${input3}_chr9 ${input3}_chr10 \
${input3}_chr11 ${input3}_chr12 ${input3}_chr13 ${input3}_chr14 ${input3}_chr15 ${input3}_chr16 ${input3}_chr17 ${input3}_chr18 ${input3}_chr19 ${input3}_chr20 \
${input3}_chr21 ${input3}_chr22 ${input3}_chrX ${input3}_chrY > ${input3}_all

./pyicosclip_1_result_rmdup.pl  ${input4}_result.pk_all ${input4}_1_rmdup.pk_all
./pyicosclip_2_result_split_self.pl ${input4}_1_rmdup.pk_all ${input4}_2_split.pk_all

bedtools intersect -a ${input4}_2_split.pk_all -b ${region2} -loj > ${input4}_3_peaks_with_RefSeq_3UTR.pk_all
./pyicosclip_4_extract_pos_peaks_with_RefSeq.pl ${input4}_3_peaks_with_RefSeq_3UTR.pk_all ${input4}_3_peaks_with_RefSeq_3UTR.bed
./pyicosclip_5_extract_pos_peaks_in_UPF1_targets.pl ./RIP-seq_pUPF1_analysis_UPF1_targets_infor.txt ${input4}_3_peaks_with_RefSeq_3UTR.bed ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets.bed
#python3 ./pyicosclip_X1_extract_more_than_XXbp_peaks.py ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets.bed ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff.bed

#bedtools getfasta -s -name -fi /home/akimitsu/database/genome/hg19/hg19.fa \
#-bed ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff.bed \
#-fo ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff.fa

python3 ./pyicosclip_X1_extract_more_than_XXbp_peaks_ver2.py ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets.bed ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff2.bed

bedtools getfasta -s -name -fi /home/akimitsu/database/genome/hg19/hg19.fa \
-bed ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff2.bed \
-fo ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff2.fa

# Motif finding
input4="SRR2051421_WT_CLIP_rep1_4_result_copy_ver2"
meme ${input4}_3_peaks_with_RefSeq_3UTR_in_UPF1_targets_cutoff2.fa -dna -oc ./UPF1_targets_3UTR_bg3 -maxsize 900000 -mod zoops -nmotifs 10 -minw 3 -maxw 8 -bfile /home/akimitsu/data/UPF1_study/pUPF1-IP-seq/Refseq_genes_May_14_2013_3UTR_rep_in_UPF1_study.markov
python3 meme2weblogo.py ./UPF1_targets_3UTR_bg3/UPF1_peaks_MEME_bg3.txt ./UPF1_targets_3UTR_bg3/UPF1_peaks_MEME_bg3_meme2weblogo.txt
