#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

cutoff_length_lower = 20
cutoff_length_upper = 150

for line in input_file:
    line = line.rstrip()
    data = line.split("\t")
    chrom = data[0]
    st = int(data[1])
    ed = int(data[2])
    name = data[3]
    score = data[4]
    strand = data[5]
    seq_length = ed - st
    if 350 <= seq_length:
        length = round((ed - st)/4)
        split1 = st + length
        split2 = st + length*2
        split3 = st + length*3
        print(chrom, st, split1, name+'_1', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split1, split2, name+'_2', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split2, split3, name+'_3', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split3, ed, name+'_4', score, strand, sep="\t", end="\n", file=output_file)
    elif 250 <= seq_length <= 350:
        length = round((ed - st)/3)
        split1 = st + length
        split2 = st + length*2
        print(chrom, st, split1, name+'_1', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split1, split2, name+'_2', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split2, ed, name+'_3', score, strand, sep="\t", end="\n", file=output_file)
    elif 150 <= seq_length <= 250:
        length = round((ed - st)/2)
        split1 = st + length
        print(chrom, st, split1, name+'_1', score, strand, sep="\t", end="\n", file=output_file)
        print(chrom, split1, ed, name+'_2', score, strand, sep="\t", end="\n", file=output_file)
    elif cutoff_length_lower <= seq_length:
        print(line, end="\n", file=output_file)
