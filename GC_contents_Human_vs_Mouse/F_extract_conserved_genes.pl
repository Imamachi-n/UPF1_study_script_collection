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
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI3.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI4.list";

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

my %REF;
my @list;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){
		print OUT "$line\n";
		next;
	}
	if($data[2] eq "NA"){next;}
	if($data[4] eq "NA"){next;}
	print OUT "$line\n";
}

close(IN);
close(OUT);
