#!/usr/local/bin/perl
####################################
#B_Create_REFID_vs_Repeat_family.pl#
#var1.0_Perl
#update: 2013.8.20
####################################

use strict;
use warnings;

open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_NM_3UTR_2013-06-20_NI1.out") || die;
my @REPEAT_DNA;
my @REPEAT_LINE;
my @REPEAT_SINE;
my @REPEAT_LTR;
my @REPEAT_Simple_repeat;
my @REPEAT_Low_complexity;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($id,$repeat) = @data[0,2];
	if($repeat =~ /^DNA/){
		push(@REPEAT_DNA,$id);
		next;
	}elsif($repeat =~ /^LINE/){
		push(@REPEAT_LINE,$id);
		next;
	}elsif($repeat =~ /^SINE/){
		push(@REPEAT_SINE,$id);
		next;
	}elsif($repeat =~ /^LTR/){
		push(@REPEAT_LTR,$id);
		next;
	}elsif($repeat =~ /^Simple_repeat/){
		push(@REPEAT_Simple_repeat,$id);
		next;
	}elsif($repeat =~ /^Low_complexity/){
		push(@REPEAT_Low_complexity,$id);
		next;
	}
}
close(IN);

#main####################################################
open (IN,"<E:/imamachi/R/2013-08-19_repeat_master_analysis/raw_data/Refseq_3UTR_2013-08-12_NI3_Rep_isoform.sort") || die;
open (OUT_REPEAT_DNA,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_DNA.txt") || die;
open (OUT_REPEAT_LINE,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_LINE.txt") || die;
open (OUT_REPEAT_SINE,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_SINE.txt") || die;
open (OUT_REPEAT_LTR,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_REPEAT_LTR.txt") || die;
open (OUT_Simple_repeat,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_Simple_repeat.txt") || die;
open (OUT_Low_complexity,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_Low_complexity.txt") || die;
open (LOG,">E:/imamachi/R/2013-08-19_repeat_master_analysis/result/Refseq_3UTR_2013-08-12_NI6_LOG.txt") || die;

my $COUNT_REPEAT_DNA = 0;
my $COUNT_REPEAT_LINE = 0;
my $COUNT_REPEAT_SINE = 0;
my $COUNT_REPEAT_LTR = 0;
my $COUNT_Simple_repeat = 0;
my $COUNT_Low_complexity = 0;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my ($id,$symbol) = @data[0,1];
	#REPEAT_DNA
	foreach(@REPEAT_DNA){
		if($id eq "$_"){
			print OUT_REPEAT_DNA "$id\t$symbol\n";
			$COUNT_REPEAT_DNA++;
			last;
		}
	}
	#REPEAT_LINE
	foreach(@REPEAT_LINE){
		if($id eq "$_"){
			print OUT_REPEAT_LINE "$id\t$symbol\n";
			$COUNT_REPEAT_LINE++;
			last;
		}
	}
	#PEPEAT_SINE
	foreach(@REPEAT_SINE){
		if($id eq "$_"){
			print OUT_REPEAT_SINE "$id\t$symbol\n";
			$COUNT_REPEAT_SINE++;
			last;
		}
	}
	#REPEAT_LTR
	foreach(@REPEAT_LTR){
		if($id eq "$_"){
			print OUT_REPEAT_LTR "$id\t$symbol\n";
			$COUNT_REPEAT_LTR++;
			last;
		}
	}
	#REPEAT_Simple_repeat
	foreach(@REPEAT_Simple_repeat){
		if($id eq "$_"){
			print OUT_Simple_repeat "$id\t$symbol\n";
			$COUNT_Simple_repeat++;
			last;
		}
	}
	#REPEAT_Low_complexity
	foreach(@REPEAT_Low_complexity){
		if($id eq "$_"){
			print OUT_Low_complexity "$id\t$symbol\n";
			$COUNT_Low_complexity++;
			last;
		}
	}
}
print LOG "REPEAT_DNA: $COUNT_REPEAT_DNA\n";
print LOG "REPEAT_LINE: $COUNT_REPEAT_LINE\n";
print LOG "REPEAT_SINE: $COUNT_REPEAT_SINE\n";
print LOG "REPEAT_LTR: $COUNT_REPEAT_LTR\n";
print LOG "REPEAT_Simple_repeat: $COUNT_Simple_repeat\n";
print LOG "REPEAT_Low_complexity: $COUNT_Low_complexity\n";

close(IN);
close(OUT_REPEAT_DNA);
close(OUT_REPEAT_LINE);
close(OUT_REPEAT_SINE);
close(OUT_REPEAT_LTR);
close(OUT_Simple_repeat);
close(OUT_Low_complexity);
print "Process were successfully finished\n";
