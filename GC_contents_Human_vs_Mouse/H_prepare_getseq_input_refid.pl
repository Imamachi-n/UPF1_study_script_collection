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
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart.list";

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $gr_id = $data[0];
	my @refid = split/,/,$data[3];
	foreach(@refid){
		if($_ eq "NA"){next;}
		print OUT "$gr_id\t$_\n";
	}
}

close(IN);
close(OUT);
