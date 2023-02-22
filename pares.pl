#!/usr/bin/perl

use strict;
use warnings;

my ($line,$out1,$out2)=("","out1.txt","out2.txt");
my (@lista,@multiplicador);

open my $file, '<', "lista.txt";
open (OUT1,">$out1");
open (OUT2,">$out2");

while ($line = <$file>){
	push(@lista,$line);	
}

my $numero = scalar @lista;

for (my $i = $numero; $i >= 1; $i--){
	push(@multiplicador,$i);
}

for (my $j = 0; $j <= $numero-1; $j++){
	print OUT1 $lista[$j] x $multiplicador[$j];	
}

for (my $k = 0; $k <= $numero-1; $k++){
		for (my $h = $k; $h <= $numero-1; $h++){
			print OUT2 "$lista[$h]";
			} 	
}

close OUT1;
close OUT2;
exit;