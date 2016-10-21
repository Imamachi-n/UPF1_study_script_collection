#!/usr/local/bin/perl
####################################
#D_extract_NMD_target_NR_for_Cufflinks.pl#########
#var1.0_Perl
#update: 2013.11.6
####################################

use strict;
use warnings;

#INPUT::TXN_ID###########################################
open (REF,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/transcript_ID_NR_for_Cufflinks.txt") || die;
my @REF_LIST;
while(my $line = <REF>){
	chomp $line;
	push(@REF_LIST,$line);
}
close(REF);

#main####################################################
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NMD.gtf") || die;
open (OUT,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Refseq_genes_May_14_2013_NMD_for_Cufflinks.txt") || die;  

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my @data_detail = split/; /,$data[8];
	$data_detail[2] =~ s/transcript_id "//;
	$data_detail[2] =~ s/"//;
	foreach(@REF_LIST){
		if($data_detail[2] eq "$_"){
			print OUT "$line\n";
		}
	}
}
close(IN);
close(OUT);
