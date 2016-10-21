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

my %REF;
my $gr_id = 1;
#my $test=1;

OUTER: while(my $line = <IN>){
	chomp $line;
	my @data = split/\t/,$line;
	my $chr = $data[0];
	my $st = $data[1] - 1;
	my $ed = $data[2];
	my $peaks = $data[3];
	my $str = $data[5];
	my @peak_infor = split/\|/,$peaks;
	my $peak_var = @peak_infor;
	if($peak_var == 1){next;} #Remove block peaks.
	my $height = int($data[4]);
	my $height_limit = int($height/10);
	#if($height_limit == 0){
	#	print OUT join("\t",$chr,$st,$ed,$name,0,$str),"\n";
	#	$gr_id++;
	#	next OUTER;
	#}
	my @range_infor;
	my $st_sep;
	my $ed_sep;
	for(my $i=0; $i<@peak_infor; $i++){
		my @peak_regions_infor = split/\:/,$peak_infor[$i];
		my $length_each = $peak_regions_infor[0];
		my $height_each = $peak_regions_infor[1];
		if($i == 0){ #First_try
			$st_sep = $data[1] - 1;
			$ed_sep = $st_sep + $length_each;
			#print "$st_sep\t$ed_sep\n";
		}else{
			$st_sep = $ed_sep;
			$ed_sep = $st_sep + $length_each;
			#print "$st_sep\t$ed_sep\n";
		}
		if($height_each <= $height_limit || $height_each <= 1){ #if height is under the criteria one
			next; #if not lists have
		}
		push(@range_infor,$st_sep,$ed_sep);
	}
	#print "@range_infor\n";
	my %ts_count;
	my @dup_infor = grep(++$ts_count{$_} == 2,@range_infor);
	my %ref_count;
	foreach(@dup_infor){
		$ref_count{$_}++;
	}
	my @range_sets;
	foreach(@range_infor){
		if(defined($ref_count{$_})){next;}
		push(@range_sets,$_);
	}
	#my $score = 0;
	#print "@range_sets\n";
	for(my $i=0; $i<@range_sets; $i+=2){
		my $j = $i + 1;
		my $name = "UPF1PEAK_" . $gr_id;
		print OUT join("\t",$chr,$range_sets[$i],$range_sets[$j],$name,$height,$str),"\n";
		$gr_id++;
	}
	#last;
	#$test++;
	#if($test == 6){last;}
}

close(IN);
close(OUT);
