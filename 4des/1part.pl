#!/usr/bin/perl

use warnings;
use strict;

sub say {
    my @args = @_;
    print @args, "\n";
}

sub get_ranges {
    my $line  = shift;
    my @elves = ();

    foreach ( split( /,/, $line ) ) {
        my @elf = split( /-/, $_ );
        push( @elves, [@elf] );
    }

    return @elves;
}

sub is_eclipsing {
    my @elves = @_;

    if (
        ( $elves[0][0] <= $elves[1][0] and $elves[0][1] >= $elves[1][1] )
        or (    $elves[1][0] <= $elves[0][0]
            and $elves[1][1] >= $elves[0][1] )
      )
    {
        return 1;
    }
    return 0;
}

my $eclipsing = 0;
while (<>) {
    chop;
    my @elves = get_ranges $_;
    ++$eclipsing if is_eclipsing(@elves);
}
say $eclipsing
