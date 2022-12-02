#!/usr/bin/perl

use strict;
use warnings;

my @elves = (0);

while (<>) {
	if ($_ eq "\n") {
		push(@elves, 0);
	} else {
		chop $_;
		$elves[$#elves] += $_;
	}
}

@elves = sort {$a <=> $b} @elves;

print(sum(@elves[$#elves - 2 .. $#elves]) . "\n");

sub sum {
	my $sum = 0;
	foreach (@_) {
		$sum += $_;
	}
	return $sum;
}
