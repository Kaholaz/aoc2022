#!/usr/bin/perl

use warnings; 
use strict;

my %opponent = (
	"A" => 1,
	"B" => 2,
	"C" => 3,
);

my %needed_diff = (
	"X" => 1,
	"Y" => 0,
	"Z" => 2,
);

my %outcome_score = (
	"X" => 0,
	"Y" => 3,
	"Z" => 6,
);

my $your_score = 0;

while (<>) {
	my ($opponent_choise, $outcome) = (split /\s+/, $_);
	$opponent_choise = $opponent{$opponent_choise};

	my $your_choise = ($opponent_choise - $needed_diff{$outcome} - 1) % 3 + 1;
	$your_score += $your_choise;
	$your_score += $outcome_score{$outcome};
}

print($your_score, "\n");

	

	
	
