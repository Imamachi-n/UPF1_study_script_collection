#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

input="SRR2051421_WT_CLIP_rep1_4_result"

htseq-count ${input}.sam Refseq_genes_May_14_2013_CDS_2015-07-31_rep_selected.gtf > htseq_count_result_${input}_CDS.txt
python3 ./B_normalize_htseq-count_data.py -r Refseq_genes_May_14_2013_CDS_2015-07-31.bed htseq_count_result_${input}_CDS.txt htseq_count_result_${input}_CDS_1.txt
python3 ./C_make_list.py htseq_count_result_${input}_CDS_1.txt htseq_count_result_${input}_CDS_2.txt
