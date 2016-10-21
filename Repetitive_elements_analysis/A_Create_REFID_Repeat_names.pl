#!/usr/local/bin/perl
####################################
#A_Create_REFID_Repeat_names.pl#####
#var1.0_Perl
#update: 2013.6.27
####################################

use strict;
use warnings;

#main####################################################
open (IN,"<E:/imamachi/R/20130627_repeat_master_analysis/raw_data/Refseq_NM_3UTR_2013-06-20.fasta.out") || die;
open (OUT,">E:/imamachi/R/20130627_repeat_master_analysis/result/Refseq_NM_3UTR_2013-06-20_NI1.out") || die;

my $count = 1;
my %FAMILY_LIST;

while(my $line = <IN>){
	if($count <= 3){
		$count++;
		next;
	}
	if($line =~ /^\s+/){
		$line =~ s/\s+//;
	}
	chomp $line;
	my @data = split/\s+/,$line;
	my($id,$repeat,$family) = @data[4,9,10];
	print OUT "$id\t$repeat\t$family\n";
	#push(@{$FAMILY_LIST{$family}},$id);
}
#foreach(sort keys %FAMILY_LIST){
#	my %count;
#	my @COUNT_ID = grep(!$count{$_}++,@{$FAMILY_LIST{$_}});
#	my $NUMBER_ID = @COUNT_ID;
#	print OUT "$_\t$NUMBER_ID\t",join(",",@COUNT_ID),"\n";
#}
close(IN);
close(OUT);
print "Process were successfully finished\n";
