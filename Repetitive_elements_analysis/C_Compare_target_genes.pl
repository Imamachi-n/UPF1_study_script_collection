#!/usr/local/bin/perl
####################################
#C_Compare_target_genes.pl#####
#var1.0_Perl
#update: 2013.8.20
####################################

use strict;
use warnings;

open (REF_ALL,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/raw_data/UPF1_study_All_genes_list.txt") || die;
open (REF_TARGET,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/raw_data/UPF1_study_UPF1_targets_list.txt") || die;

my @REF_ALL_LIST;
my @REF_TARGET_LIST;
my $COUNT_ALL;
my $COUNT_TARGET;

while(my $line = <REF_ALL>){
	chomp $line;
	push(@REF_ALL_LIST,$line);
}
close(REF_ALL);
$COUNT_ALL = @REF_ALL_LIST; #counting

while(my $line = <REF_TARGET>){
	chomp $line;
	push(@REF_TARGET_LIST,$line);
}
close(REF_TARGET);
$COUNT_TARGET = @REF_TARGET_LIST; #counting

#main####################################################

my $COUNT_ALL_Low_complexity = 0;
my $COUNT_ALL_REPEAT_DNA = 0;
my $COUNT_ALL_REPEAT_LINE = 0;
my $COUNT_ALL_REPEAT_LTR = 0;
my $COUNT_ALL_REPEAT_SINE = 0;
my $COUNT_ALL_Simple_repeat = 0;

my $COUNT_TARGET_Low_complexity = 0;
my $COUNT_TARGET_REPEAT_DNA = 0;
my $COUNT_TARGET_REPEAT_LINE = 0;
my $COUNT_TARGET_REPEAT_LTR = 0;
my $COUNT_TARGET_REPEAT_SINE = 0;
my $COUNT_TARGET_Simple_repeat = 0;

open (OUT,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI7_RESULT.txt") || die;

#REPEAT_DNA
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_DNA.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_REPEAT_DNA++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_REPEAT_DNA++;
		}
	}
}
close(IN);

#REPEAT_LINE
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_LINE.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_REPEAT_LINE++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_REPEAT_LINE++;
		}
	}
}
close(IN);

#REPEAT_SINE
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_SINE.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_REPEAT_SINE++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_REPEAT_SINE++;
		}
	}
}
close(IN);

#REPEAT_LTR
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_LTR.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_REPEAT_LTR++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_REPEAT_LTR++;
		}
	}
}
close(IN);

#Simple_repeat
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_Simple_repeat.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_Simple_repeat++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_Simple_repeat++;
		}
	}
}
close(IN);

#Low_complexity
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_Low_complexity.txt") || die;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($symbol) = $data[1];
	#ALL
	foreach(@REF_ALL_LIST){
		if($symbol eq "$_"){
			$COUNT_ALL_Low_complexity++;
		}
	}
	#TARGET
	foreach(@REF_TARGET_LIST){
		if($symbol eq "$_"){
			$COUNT_TARGET_Low_complexity++;
		}
	}
}
close(IN);

print OUT "#ALL_GENES\n";
print OUT "SINE\t$COUNT_ALL_REPEAT_SINE\t$COUNT_ALL\n";
print OUT "LINE\t$COUNT_ALL_REPEAT_LINE\t$COUNT_ALL\n";
print OUT "LTR\t$COUNT_ALL_REPEAT_LTR\t$COUNT_ALL\n";
print OUT "DNA elements\t$COUNT_ALL_REPEAT_DNA\t$COUNT_ALL\n";
print OUT "Simple_repeats\t$COUNT_ALL_Simple_repeat\t$COUNT_ALL\n";
print OUT "Low_complexity\t$COUNT_ALL_Low_complexity\t$COUNT_ALL\n";
print OUT "\n";
print OUT "#TARGET_GENES\n";
print OUT "SINE\t$COUNT_TARGET_REPEAT_SINE\t$COUNT_TARGET\n";
print OUT "LINE\t$COUNT_TARGET_REPEAT_LINE\t$COUNT_TARGET\n";
print OUT "LTR\t$COUNT_TARGET_REPEAT_LTR\t$COUNT_TARGET\n";
print OUT "DNA elements\t$COUNT_TARGET_REPEAT_DNA\t$COUNT_TARGET\n";
print OUT "Simple_repeats\t$COUNT_TARGET_Simple_repeat\t$COUNT_TARGET\n";
print OUT "Low_complexity\t$COUNT_TARGET_Low_complexity\t$COUNT_TARGET\n";
close(OUT);
print "Process were successfully finished\n";
