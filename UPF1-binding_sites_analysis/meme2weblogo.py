#!/usr/bin/env python3

import sys

input_file = open(sys.argv[1], 'r')
output_file = open(sys.argv[2], 'w')

trans_table = str.maketrans("ATGCatgcUu","AUGCAUGCUU")

for line in input_file:
    line = line.rstrip()
    data = line.split()
    motif_seq = data[4]
    mod_motif_seq = line.translate(trans_table)
    print(mod_motif_seq, end="\n", file=output_file)
