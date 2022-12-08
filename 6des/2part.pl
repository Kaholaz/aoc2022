#!/usr/bin/perl

use warnings;
use strict;

sub has_duplicates {
    my $string = shift;

    my %seen;
    foreach ( split //, $string ) {
        $seen{$_} = 1;
    }

    return length $string != keys %seen;
}

sub first_index_with_duplicates {
    my ( $string, $length ) = @_;
    for ( my $i = 0 ; $i < ( length $string ) - 4 ; ++$i ) {
        my $s = substr( $string, $i, $length );
        return $i unless has_duplicates $s;
    }
}

my $length = 14;
my $s      = <>;
my $i      = first_index_with_duplicates( $s, $length );

print $i + $length, "\n";
