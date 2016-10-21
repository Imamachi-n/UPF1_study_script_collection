#!/usr/bin/env python

import argparse
import re

parser = argparse.ArgumentParser(prog='select_gtf_files',description='')
parser.add_argument('input_file',action='store',help='')
parser.add_argument('output_file',action='store',help='')
parser.add_argument('-r','--reference-file',action='store',dest='ref_file',help='')

args = parser.parse_args()
input_file_path = args.input_file #htseq_count_result_RIP-seq_pUPF1_3UTR.txt
output_file_path = args.output_file #htseq_count_result_RIP-seq_pUPF1_3UTR_normalized.txt
ref_file_path = args.ref_file #Refseq_genes_May_14_2013_3UTR_2015-07-31.bed

ref_file = open(ref_file_path, 'r')
ref_dict = {}

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    name = data[3]
    exon_length = data[10].split(',')
    exon_length.pop()
    total_length = 0
    for x in range(len(exon_length)):
        total_length += int(exon_length[x])
    ref_dict[name] = total_length

input_file = open(input_file_path, 'r')
output_file = open(output_file_path, 'w')

escape_list = [
'__no_feature',
'__ambiguous',
'__too_low_aQual',
'__not_aligned',
'__alignment_not_unique'
]

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    name = data[0]
    if data[0] in escape_list:
        continue
    normalized_reads = int(data[1])/ref_dict[name]*1000.0
    print(line,normalized_reads, sep="\t",end="\n",file=output_file)

input_file.close()
output_file.close()

