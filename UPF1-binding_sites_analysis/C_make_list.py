#!/usr/bin/env python

import argparse
import re

parser = argparse.ArgumentParser(prog='select_gtf_files',description='')
parser.add_argument('input_file',action='store',help='')
parser.add_argument('output_file',action='store',help='')

args = parser.parse_args()
input_file_path = args.input_file
output_file_path = args.output_file

ref_file = open('./Rep_id_list.txt','r')
input_file = open(input_file_path, 'r')
output_file = open(output_file_path, 'w')

name_list = {}

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    name = data[0]
    reads = float(data[1])
    rpkm = float(data[2])
    name_list[name] = [reads,rpkm]

for line in ref_file:
    line = line.rstrip()
    data = line.split("\t")
    symbol = data[0]
    name = data[2]
    if name in name_list:
        reads, rpkm = name_list[name]
    else:
        reads, rpkm = 'NA', 'NA'
    print(symbol,name,reads,rpkm,sep="\t",end="\n",file=output_file)

input_file.close()
output_file.close()
