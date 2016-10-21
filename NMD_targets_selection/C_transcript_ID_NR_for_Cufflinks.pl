#!/usr/local/bin/perl
####################################
#C_transcript_ID_NR_for_Cufflinks.pl#########
#var1.0_Perl
#update: 2013.11.6
####################################

use strict;
use warnings;

my @NMD_LIST;
my @ALL_LIST;
#Insertion_NR############################################
open (REF,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NMD_insertion.gtf") || die;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	my @data_detail = split/; /,$data[8];
	$data_detail[2] =~ s/transcript_id "//;
	$data_detail[2] =~ s/"//;
	push(@NMD_LIST,$data_detail[2]);
	push(@ALL_LIST,$data_detail[2]);
}
close(REF);

#main####################################################
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NMD_100bp.gtf") || die;
open (OUT,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/transcript_ID_NR_for_Cufflinks.txt") || die;  
open (ALL,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/transcript_ID_NR_ALL.txt") || die;  

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $start = $data[12];
	my $end = $data[13];
	my $sub = $end - $start + 1;
	my $overlap = $data[18];
	my $non_overlap = $sub -$overlap;
	my @data_detail = split/; /,$data[17];
	$data_detail[2] =~ s/transcript_id "//;
	$data_detail[2] =~ s/"//;
	push(@ALL_LIST,$data_detail[2]);
	if($non_overlap >= 100){
		push(@NMD_LIST,$data_detail[2]);
	}
}

my %COUNT;
@NMD_LIST = grep(!$COUNT{$_}++,@NMD_LIST);
foreach(@NMD_LIST){
	print OUT "$_\n";
}
my %COUNT;
@ALL_LIST = grep(!$COUNT{$_}++,@ALL_LIST);
foreach(@ALL_LIST){
	print ALL "$_\n";
}
close(IN);
close(OUT);
close(ALL);
