#!/usr/local/bin/perl
#Preprocessing##########################

use strict;
use warnings;

my $DATA_0h;
my $DATA_4h;
my $DATA_8h;
my $DATA_12h;

my @list=(
"BRIC-seq_siCTRL_genes.fpkm_tracking",
"BRIC-seq_siUPF1_genes.fpkm_tracking"
);

foreach(@list){
open (IN,"<C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2013-11-15_BRIC-seq_analysis_for_Cufflinks_3MODEL_ver/raw_data/$_\.result") || die;

my @NORM_LIST_4h;
my @NORM_LIST_8h;
my @NORM_LIST_12h;

my $NORM_4h = 1;
my $NORM_8h = 1;
my $NORM_12h = 1;

my @NORM_GENE_LIST = ("ALDOA","ATP5B","COTL1","CYC1","ENO1","GANAB","GAPDH","GNB2L1","LDHA","P4HB","PGK1","PKM","PPIB","PSAP","PSMD2","RPLP0","SLC25A5","SSR2","YBX1");
#my @NORM_GENE_LIST = ("GAPDH","TMEM14C","RPLP0","DDOST","PPIA","ERP29","RPS24","PRDX1","RPL10","MYL12B");
my $length = @NORM_GENE_LIST;

OUTER: while(my $line =<IN>){
	chomp $line;
	my @data =split/\t/,$line;
	foreach(@NORM_GENE_LIST){
		if($data[1] eq "$_"){
			push(@NORM_LIST_4h,($data[16]/$data[12]));
			push(@NORM_LIST_8h,($data[20]/$data[12]));
			push(@NORM_LIST_12h,($data[24]/$data[12]));
			next OUTER;
		}
	}
}

foreach(@NORM_LIST_4h){
	$NORM_4h *= $_;
}
foreach(@NORM_LIST_8h){
	$NORM_8h *= $_;
}
foreach(@NORM_LIST_12h){
	$NORM_12h *= $_;
}
$NORM_4h = ($NORM_4h)**(1/$length);
$NORM_8h = ($NORM_8h)**(1/$length);
$NORM_12h = ($NORM_12h)**(1/$length);
print "$NORM_4h\n";
print "$NORM_8h\n";
print "$NORM_12h\n";

open (IN,"<C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2013-11-15_BRIC-seq_analysis_for_Cufflinks_3MODEL_ver/raw_data/$_\.result") || die;
open (OUT,">C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2013-11-15_BRIC-seq_analysis_for_Cufflinks_3MODEL_ver/result/$_\.input") || die; 
while(my $line =<IN>){
	chomp $line;
	my @data =split/\t/,$line;
	if($data[0] eq "gr_id"){
		print OUT "$data[0]\t$data[1]\t$data[2]\trpkm\t0h\t4h\t8h\t12h\n";
		next;
	}
	if($data[12] <= 0){
		print OUT "$data[0]\t$data[1]\t$data[2]\t$data[12]\t0\t0\t0\t0\n";
		next;
	}
	$DATA_0h = 1;
	$DATA_4h = ($data[16]/$data[12])/$NORM_4h;
	$DATA_8h = ($data[20]/$data[12])/$NORM_8h;
	$DATA_12h = ($data[24]/$data[12])/$NORM_12h;
	print OUT "$data[0]\t$data[1]\t$data[2]\t$data[12]\t$DATA_0h\t$DATA_4h\t$DATA_8h\t$DATA_12h\n";
}
close(IN);
close(OUT);
}
print "Process were successfully finished\n";  
