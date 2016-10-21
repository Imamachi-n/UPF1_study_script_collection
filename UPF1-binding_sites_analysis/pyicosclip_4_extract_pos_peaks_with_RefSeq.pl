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
	my $chr = $data[0];
	my $st = $data[1];
	my $ed = $data[2];
	my $name = $data[3];
	my $score = $data[4];
	#my $str = $data[5];
	my $trx_id = $data[9];
	my $str = $data[11];
	if($data[10] == -1){next;}
	my $name_real = $name . "|" . $trx_id;
	print OUT join("\t",$chr,$st,$ed,$name_real,$score,$str),"\n";
}

close(IN);
close(OUT);
