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

print(max(@elves) . "\n");

sub max {
	my $max = shift @_;
	foreach (@_) {
		$max = $_ if $_ > $max;
	}
	return $max;
}
