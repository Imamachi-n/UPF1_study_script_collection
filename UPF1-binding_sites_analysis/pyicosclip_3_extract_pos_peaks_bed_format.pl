#!/usr/local/bin/perl
#Title: Pyicosclip_2_result_split_self
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-03-04

=pod
=cut

use warnings;
use strict;

my $usage = "Usage: $0 <input_file> <output file>\n";
my ($input,$output) = @ARGV or die $usage;

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $score = $data[10];
	unless($score == -1){next;}
	print OUT join("\t",@data[0..5]),"\n";
}

close(IN);
close(OUT);
