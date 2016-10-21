#!/usr/local/bin/perl
####################################
#A_extract_NMD_target_symbol.pl#####
#var1.0_Perl
#update: 2013.11.5
####################################

use strict;
use warnings;

#main####################################################
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/raw_data/Refseq_genes_May_14_2013.gtf") || die;
open (OUT_NM,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NM.gtf") || die;  
my @SYMBOL_LIST;
while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[2] eq "exon" && $line =~ /NM_/){
		print OUT_NM "$line\n";
	}
	unless($data[2] eq "exon" && $line =~ /NM_/){next;}
	my @data_detail = split/; /,$data[8];
	$data_detail[0] =~ s/gene_id "//;
	$data_detail[0] =~ s/"//;
	push(@SYMBOL_LIST,$data_detail[0]);
}

close(IN);
close(OUT_NM);

my %COUNT;
@SYMBOL_LIST = grep(!$COUNT{$_}++,@SYMBOL_LIST);

open (LIST,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NM_SYMBOL.txt") || die;  
foreach(@SYMBOL_LIST){
	print LIST "$_\n";
}
close(LIST);
