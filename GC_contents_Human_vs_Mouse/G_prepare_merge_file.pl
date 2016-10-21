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
my $ref = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison_NI4.list";
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2013-11-14_define_symbol-refID_dictionary_for_Cufflinks/result/Refseq_symbol-refID_dictionary_NM_ONLY.txt";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid.list";

#REF##########################################################
open(REF, "<$ref") || die "Could not open $ref: $!\n";

my %REF;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "set_num"){next;}
	my @refid = split/,/,$data[2];
	foreach(@refid){
		$REF{$_} = $data[4];
	}
}
close(REF);

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

my $gr_id=1;

OUTER: while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my @refid = split/,/,$data[1];
	my $refid_mm;
	foreach(@refid){
		if(defined($REF{$_})){
			$refid_mm = $REF{$_};
			print OUT "$gr_id\t$line\t$refid_mm\n";
			$gr_id++;
			next OUTER;
		}
	}
	print OUT "$gr_id\t$line\tNA\n";
	$gr_id++;
}

close(IN);
close(OUT);
