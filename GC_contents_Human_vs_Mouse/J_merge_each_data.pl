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
my $ref = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_for_biomart.seq";
my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid.list";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/Mus_musculus_refid_merged.list";

#REF##########################################################
open(REF, "<$ref") || die "Could not open $ref: $!\n";

my %REF;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "3utr"){next;}
	my @refid = split/\;/,$data[2];
	my $seq = $data[1];
	my $GC_content;
	if($seq eq "Sequence unavailable"){
		$GC_content = "NA";
	}else{
		my $total_length = length($seq);
		$seq =~ s/[AT]//g;
		my $GC_length = length($seq);
		$GC_content = $GC_length/$total_length*100;
	}
	foreach(@refid){
		$REF{$_} = $GC_content;
	}
}
close(REF);

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[3] eq "NA"){
		print OUT "$line\tNA\n";
		next;
	}
	my @refid = split/,/,$data[3];
	my @gc;
	foreach(@refid){
		unless(defined($REF{$_})){next;}
		my $GC_content = $REF{$_};
		push(@gc,$GC_content);
	}
	my $ave;
	my $length = @gc;
	foreach(@gc){
		if($_ eq "NA"){
			$ave = "NA";
			last;
		}
		$ave += $_/$length;
	}
	print OUT "$line\t$ave\n";
}

close(IN);
close(OUT);
