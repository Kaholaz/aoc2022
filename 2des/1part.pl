#!/usr/bin/perl

use warnings; 
use strict;

my %opponent = (
	"A" => 1,
	"B" => 2,
	"C" => 3,
);

my %you = (
	"X" => 1,
	"Y" => 2,
	"Z" => 3,
);

my ($opponent_score, $your_score) = (0, 0);

while (<>) {
	my ($opponent_choise, $your_choise) = (split /\s+/, $_);
	($opponent_choise, $your_choise) = ($opponent{$opponent_choise}, $you{$your_choise});

	my $outcome = ($opponent_choise - $your_choise) % 3;
	
	if ($outcome == 0) {
		$opponent_score += 3;
		$your_score += 3;
	}
	elsif ($outcome == 1) {
		$opponent_score += 6;
	}
	else {
		$your_score += 6;
	}

	$opponent_score += $opponent_choise;
	$your_score += $your_choise;
}

print(join(" ", ($your_score, $opponent_score)), "\n");

	

	
	
