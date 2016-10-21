#!/usr/local/bin/perl
####################################
#B_extract_NMD_target_Ensembl.pl####
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
open (IN,"<E:/imamachi/R/2013-11-05_NMD_target_gtf_file/raw_data/Homo_sapiens.GRCh37.73.gtf") || die;
open (OUT_NMD,">E:/imamachi/R/2013-11-05_NMD_target_gtf_file/result/Homo_sapiens.GRCh37.73_Ensembl_NMD_ver2.gtf") || die;  

OUTER: while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] =~ /HG/ || $data[0] =~ /HS/){next;}
	unless($data[1] eq "nonsense_mediated_decay" && $data[2] eq "exon"){next;}
	my @data_detail = split/; /,$data[8];
	$data_detail[3] =~ s/gene_name "//;
	$data_detail[3] =~ s/"//;
	$data_detail[1] =~ s/transcript_id "//;
	$data_detail[1] =~ s/"//;
	foreach(@SYMBOL_LIST){
		if($data_detail[3] eq "$_"){
			print OUT_NMD 'chr',"$data[0]\t$data[1]\t$data[2]\t$data[3]\t$data[4]\t$data[5]\t$data[6]\t$data[7]\t";
			print OUT_NMD 'gene_name "',"$data_detail[3]",'"; ';
			print OUT_NMD 'gene_id "',"$data_detail[3]",'"; ';
			print OUT_NMD 'transcript_id "',"$data_detail[1]",'";';
			print OUT_NMD "\n";
			next OUTER;
		}
	}
}
close(IN);
close(OUT_NMD);
