#!/usr/local/bin/perl
#Title: Data preparation
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-03-10

=pod
=cut

use warnings;
use strict;

#my $usage = "Usage: $0 <motif[AAAA,AAAT,AAAC,AAAG...]> <input file> <output file>\n";
#my ($motif,$input,$output) = @ARGV or die $usage;
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI2.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI3.list";

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

my %REF;
my @list;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){
		print OUT "set_num\tpepid_hs\trefid_hs\tpepid_mm\trefid_mm\n";
		next;
	}
	my $set_num = $data[0];
	my $cons = $data[7];
	unless($cons == 1){next;}
	my $taxid = $data[1];
	if($data[9] eq "NA"){next;}
	my @ref_list = split/,/,$data[9];
	push(@{$REF{$set_num}{"$taxid"}},@ref_list);
	push(@list,$set_num);
}

my %count;
@list = grep(!$count{$_}++,@list);

foreach my $set_num (@list){
	print OUT "$set_num\t";
	if(defined($REF{$set_num}{"9606"}[0])){
		my %count2;
		my @datalist = @{$REF{$set_num}{"9606"}};
		@datalist = grep(!$count2{$_}++,@datalist);
		print OUT "9606\t",join(",",@datalist),"\t";
	}else{
		print OUT "9606\tNA\t";
	}
	if(defined($REF{$set_num}{"10090"}[0])){
		my %count2;
		my @datalist = @{$REF{$set_num}{"10090"}};
		@datalist = grep(!$count2{$_}++,@datalist);
		print OUT "10090\t",join(",",@datalist),"\n";
	}else{
		print OUT "10090\tNA\n";
	}
}

close(IN);
close(OUT);
