#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -l s_vmem=32G
#$ -l mem_req=32G

file=`basename $@ .sra`

fastq-dump ./"$file".sra

echo "-- checking read quality..."
mkdir fastqc_"$file"
fastqc -o ./fastqc_"$file" ./"$file".fastq -f fastq

echo "-- discarding adapter contamination and low quality read..."
cutadapt -m 10 --match-read-wildcards --times 2 -e 0 -O 5 \
-b TCGTATGCCGTCTTCTGCTTG \
-b ATCTCGTATGCCGTCTTCTGCTTG \
-b CGACAGGTTCAGAGTTCTACAGTCCGACGATC \
-b TGGAATTCTCGGGTGCCAAGG \
-b AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA \
-b TTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT \
./"$file".fastq > ./"$file"_1_trimmed_adapter.fastq 2>> ./log_"$file".txt
fastq_quality_trimmer -Q33 -t 20 -l 10 -i ./"$file"_1_trimmed_adapter.fastq | fastq_quality_filter -Q33 -q 20 -p 80 -o "$file"_2_filtered.fastq 2>> ./log_"$file".txt

echo "-- checking read quality..."
mkdir fastqc_"$file"_filtered
fastqc -o ./fastqc_"$file"_filtered ./"$file"_2_filtered.fastq -f fastq

echo "-- mapping to reference genome..."
bowtie -p 8 -v 2 -m 10 --best --strata -S --un "$file"_3_unmapped.fastq /home/akimitsu/database/bowtie1_index/hg19 "$file"_2_filtered.fastq > "$file"_4_result.sam 2>> ./log_"$file".txt
samtools view -Sb "$file"_4_result.sam | samtools sort - "$file"_4_result
bowtie -p 8 -v 2 -m 10 --best --strata /home/akimitsu/database/bowtie1_index/hg19 "$file"_2_filtered.fastq > "$file"_4_result.bowtie 2>> ./log_"$file".txt
sort -k 5,5 -k 6,6g "$file"_4_result.bowtie > "$file"_4_result_sorted.bowtie

echo "-- visualizing the mapped reads..."
mkdir UCSC_visual_"$file"
bedtools genomecov -ibam "$file"_4_result.bam -bg -split > ./UCSC_visual_${file}/"$file"_4_result.bg
echo "track type=bedGraph name=${file} description=${file} visibility=2 maxHeightPixels=40:40:20" > ./UCSC_visual_${file}/tmp.txt
cat ./UCSC_visual_${file}/tmp.txt ./UCSC_visual_${file}/"$file"_4_result.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg
bzip2 -c ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg > ./UCSC_visual_${file}/"$file"_4_result_for_UCSC.bg.bz2
