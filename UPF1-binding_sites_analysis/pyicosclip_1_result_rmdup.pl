#!/usr/local/bin/perl
#Title: Pyicosclip_result_rmdup
#Auther: Naoto Imamachi
#ver: 1.0.0
#Date: 2015-03-03

=pod
=cut

use warnings;
use strict;

my $usage = "Usage: $0 <input_file> <output file>\n";
my ($input,$output) = @ARGV or die $usage;

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

my %REF;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $chr = $data[0];
	my $st = $data[1];
	my $ed = $data[2];
	$REF{$chr}{$st}{$ed}++;
	unless($REF{$chr}{$st}{$ed} == 1){next;}
	print OUT "$line\n";
}

close(IN);
close(OUT);
