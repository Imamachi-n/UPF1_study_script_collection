#!/bin/sh
#$ -S /bin/bash
#$ -cwd
#$ -soft -l ljob,lmem
#$ -l s_vmem=8G
#$ -l mem_req=8G

input="SRR2051421_WT_CLIP_rep1_4_result"

htseq-count ${input}.sam Refseq_genes_May_14_2013_5UTR_2015-07-31_mod_rep_selected.gtf > htseq_count_result_${input}_5UTR.txt
python3 ./B_normalize_htseq-count_data.py -r Refseq_genes_May_14_2013_5UTR_2015-07-31_mod.bed htseq_count_result_${input}_5UTR.txt htseq_count_result_${input}_5UTR_1.txt
python3 ./C_make_list.py htseq_count_result_${input}_5UTR_1.txt htseq_count_result_${input}_5UTR_2.txt
