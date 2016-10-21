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
my $ref = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/tax_report.txt";
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI1.list";

#REF##########################################################
open(REF, "<$ref") || die "Could not open $ref: $!\n";

my %REF;
while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	unless(defined($data[0])){next;}
	unless($data[0] eq "1"){next;}
	my $taxid = $data[2];
	my $taxname = $data[6];
	$REF{$taxid} = $taxname;
}
close(REF);

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){
		print OUT "$line\n";
		next;
	}
	my $taxid = $data[1];
	my $taxname = $REF{$taxid};
	print OUT join("\t",@data[0..1]),"\t$taxname\t",join("\t",@data[3..8]),"\n";
}

close(IN);
close(OUT);
