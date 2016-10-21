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
my ($ref,$input,$output) = @ARGV or die $usage;

#REF##########################################################
open(REF, "<$ref") || die "Could not open $ref: $!\n";

my %REF;

while(my $line = <REF>){
	chomp $line;
	my @data = split/\t/,$line;
	if($data[0] eq "gr_id"){next;}
	my @trx_id = split/,/,$data[2];
	foreach(@trx_id){
		$REF{$_}++;
	}
}

close(REF);

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

my %count;

while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my @name_infor = split/\|/,$data[3];
	my $peak = $name_infor[0];
	my $trx_id = $name_infor[1];
	unless(defined($REF{$trx_id})){next;}
	$count{$peak}++;
	unless($count{$peak} == 1){next;}
	my $st = $data[1];
	my $ed = $data[2];
	my $length = $ed - $st;
	if($length < 8){next;}
	print OUT join("\t",@data[0..5]),"\n";
}

close(IN);
close(OUT);
