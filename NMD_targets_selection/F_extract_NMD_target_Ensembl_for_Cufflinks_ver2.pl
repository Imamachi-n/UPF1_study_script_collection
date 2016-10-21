#!/usr/local/bin/perl
####################################
#F_extract_NMD_target_Ensembl_for_Cufflinks_ver2.pl#########
#var1.0_Perl
#update: 2013.11.6
####################################

use strict;
use warnings;

#INPUT::TXN_ID###########################################
open (REF,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/transcript_ID_Ensembl_for_Cufflinks_ver2.txt") || die;
my @REF_LIST;
while(my $line = <REF>){
	chomp $line;
	push(@REF_LIST,$line);
}
close(REF);

#main####################################################
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Homo_sapiens.GRCh37.73_Ensembl_NMD_ver2.gtf") || die;
open (OUT,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Homo_sapiens.GRCh37.73_Ensembl_NMD_ver2_for_Cufflinks_ver2.txt") || die;  

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my @data_detail = split/; /,$data[8];
	$data_detail[2] =~ s/transcript_id "//;
	$data_detail[2] =~ s/"//;
	$data_detail[2] =~ s/;//;
	foreach(@REF_LIST){
		if($data_detail[2] eq "$_"){
			print OUT "$line\n";
		}
	}
}
close(IN);
close(OUT);
