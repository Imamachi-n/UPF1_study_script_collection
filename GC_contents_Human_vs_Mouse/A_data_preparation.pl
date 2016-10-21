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

my $input = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/raw_data/SM1.txt";
my $output = "C:/Users/Naoto/Desktop/data_analysis/UPF1_study/2015-03-10_RefSeq_convervation_comparison/result/RefSeq_protein_conservation_comparison.list";

#MAIN#########################################################
open(IN, "<$input") || die "Could not open $input: $!\n";
open(OUT, ">$output") || die "Could not open $output: $!\n";

while(my $line = <IN>){
	chomp $line;
	my @data = split/\s+/,$line;
	if($data[0] =~ /^#/){
		$line =~ s/\#//;
		my @list = split/\s+/,$line;
		print OUT join("\t",@list),"\n";
		next;
	}
	my $set_num = shift(@data);
	my $taxid = shift(@data);
	my $coreprot = pop(@data);
	my $most_cons = pop(@data);
	my $prot_len = pop(@data);
	my $accession = pop(@data);
	if($data[-1] eq "ALPHA" && $data[-1] eq "PPAR"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "CYCLOPHILIN" && $data[-1] eq "B"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "ERBA" && $data[-1] eq "B"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "siat" && $data[-1] eq "8B"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "siat" && $data[-1] eq "8E"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "siat" && $data[-1] eq "8C"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "TRAIN" && $data[-1] eq "A"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "PPAR" && $data[-1] eq "ALPHA"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}elsif($data[-2] eq "ERBA" && $data[-1] eq "BETA1"){
		my $symbol = join("_",@data[2..3]);
		my $GeneID = $data[1];
		my $taxname = $data[0];
		print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
		next;
	}
	my $symbol = pop(@data);
	my $GeneID = pop(@data);
	my $taxname = join("_",@data);
	print OUT join("\t",$set_num,$taxid,$taxname,$GeneID,$symbol,$accession,$prot_len,$most_cons,$coreprot),"\n";
}

close(IN);
close(OUT);
