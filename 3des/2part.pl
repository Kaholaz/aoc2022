#!/usr/bin/perl

use warnings;
use strict;

sub find_common_char {
    my @strings = @_;

    my $string = shift @strings;
    my @chars  = $string =~ /./sg;

    my %contains = ();
    foreach (@chars) {
        $contains{$_} = 1;
    }

    my %prev = %contains;
    %contains = ();
    foreach $string (@strings) {
        @chars = $string =~ /./sg;
        foreach (@chars) {
            if ( exists( $prev{$_} ) ) {
                $contains{$_} = 1;
            }
        }
        %prev     = %contains;
        %contains = ();
    }

    die("oups...") unless ( scalar %prev );
    return ( keys %prev )[0];
}

sub get_priority {
    my $letter = shift;

    return ( ord($letter) - 38 ) if $letter =~ /[A-Z]/;
    return ( ord($letter) - 96 ) if $letter =~ /[a-z]/;
    print $letter , "\n";
    die("Oh no...");
}

sub sum {
    my $sum = 0;
    foreach (@_) {
        $sum += $_;
    }
    return $sum;
}

my @common = ();
my @group  = ();

while (<>) {
    chop $_;
    push( @group, $_ );
    if ( scalar(@group) == 3 ) {
        push( @common, find_common_char(@group) );
        @group = ();
    }

}

my @priorities = map { get_priority($_) } @common;
print( ( sum(@priorities) ) . "\n" );

