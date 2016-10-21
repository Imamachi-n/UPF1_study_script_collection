#!/usr/local/bin/perl
####################################
#B_extract_NMD_target_NR.pl#########
#var1.0_Perl
#update: 2013.11.6
####################################

use strict;
use warnings;

#INPUT::SYMBOL_NAME######################################
open (REF,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NM_SYMBOL.txt") || die;
my @SYMBOL_LIST;
while(my $line = <REF>){
	chomp $line;
	push(@SYMBOL_LIST,$line);
}
close(REF);

#main####################################################
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/raw_data/Refseq_genes_May_14_2013.gtf") || die;
open (OUT_NM_NR,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NM_NR_NMD_minus.gtf") || die;  
open (OUT_NMD,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NMD.gtf") || die;  

OUTER: while(my $line = <IN>){
	chomp $line;
	unless($line =~ /NR_/){
		print OUT_NM_NR "$line\n";
		next;
	}
	my @data = split/\t/,$line;
	my @data_detail = split/; /,$data[8];
	$data_detail[0] =~ s/gene_id "//;
	$data_detail[0] =~ s/"//;
	foreach(@SYMBOL_LIST){
		if($data_detail[0] eq "$_"){
			print OUT_NMD "$line\n";
			next OUTER;
		}
	}
	print OUT_NM_NR "$line\n";
}

close(IN);
close(OUT_NM_NR);
close(OUT_NMD);
