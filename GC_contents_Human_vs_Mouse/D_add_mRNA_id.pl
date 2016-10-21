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
my $ref1 = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Homo_sapiens_NP.txt";
my $ref2 = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_Homo_sapiens_XP.txt";
my $ref3 = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_mmusculus_NP.txt";
my $ref4 = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_mRNA_id_protein_id_mmusculus_XP.txt";
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI2.list";

#REF##########################################################
open(REF, "<$ref1") || die "Could not open $ref1: $!\n";

my %REF;
while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] =~ /^results/){next;}
	my $pep_id = $data[1];
	my $ref_id = $data[3];
	unless($ref_id){next;}
	push(@{$REF{$pep_id}},$ref_id);
}
close(REF);

open(REF, "<$ref2") || die "Could not open $ref1: $!\n";

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] =~ /^results/){next;}
	my $pep_id = $data[1];
	my $ref_id = $data[3];
	unless($ref_id){next;}
	push(@{$REF{$pep_id}},$ref_id);
}
close(REF);

open(REF, "<$ref3") || die "Could not open $ref1: $!\n";

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] =~ /^results/){next;}
	my $pep_id = $data[1];
	my $ref_id = $data[3];
	unless($ref_id){next;}
	push(@{$REF{$pep_id}},$ref_id);
}
close(REF);

open(REF, "<$ref4") || die "Could not open $ref1: $!\n";

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] =~ /^results/){next;}
	my $pep_id = $data[1];
	my $ref_id = $data[3];
	unless($ref_id){next;}
	push(@{$REF{$pep_id}},$ref_id);
}
close(REF);

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){
		print OUT "$line\tref_id\n";
		next;
	}
	unless($data[1] eq "10090" || $data[1] eq "9606"){next;}
	my @pep_id_list = split/\./,$data[5];
	my $pep_id = $pep_id_list[0];
	unless(defined($REF{$pep_id}[0])){
		print OUT "$line\tNA\n";
		next;
	}
	my @ref_list = @{$REF{$pep_id}};
	my %count;
	@ref_list = grep(!$count{$_}++,@ref_list);
	print OUT "$line\t",join(",",@ref_list),"\n";
}

close(IN);
close(OUT);
