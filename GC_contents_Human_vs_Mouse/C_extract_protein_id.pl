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

my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1.list";
my $outputN = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1";
my $outputX = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1";
my @taxlist = (
"10090", #Mus musculus
"9606" #Homo sapiens
);
my %REF_tax;
$REF_tax{"10090"} = "Mus_musculus";
$REF_tax{"9606"} = "Homo_sapiens";

#MAIN#########################################################
foreach(@taxlist){
my $taxname = $REF_tax{$_};
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUTN, ">$outputN\_$taxname\_NP.list") || die "Could not open $outputN: $!\n";
open(OUTX, ">$outputX\_$taxname\_XP.list") || die "Could not open $outputX: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){next;}
	my $taxid = $data[1];
	unless($taxid eq $_){next;}
	my @name = split/\./,$data[5];
	if($data[5] =~ /^NP/){
		print OUTN "$name[0]\n";
	}elsif($data[5] =~ /^XP/){
		print OUTX "$name[0]\n";
	}
}

close(IN);
close(OUTN);
close(OUTX);
}
