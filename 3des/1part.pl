#!/usr/bin/perl

use warnings;
use strict;

sub finddouble {
    my $length = scalar(@_);
    my @first  = @_[ 0 .. $length / 2 - 1 ];
    my @second = @_[ $length / 2 .. $#_ ];

    my %contains = ();
    foreach (@first) {
        $contains{$_} = 1;
    }
    foreach (@second) {
        return $_ if exists $contains{$_};
    }
    die("Something wrong happened");
}

sub get_priority {
    my $letter = shift;

    return ( ord($letter) - 38 ) if $letter =~ /[A-Z]/;
    return ( ord($letter) - 96 ) if $letter =~ /[a-z]/;
    die("Oh no...");
}

sub sum {
    my $sum = 0;
    foreach (@_) {
        $sum += $_;
    }
    return $sum;
}

my @doubles = ();
while (<>) {
    my @chars = $_ =~ /./g;
    push( @doubles, finddouble(@chars) );
}

my @priorities = map { get_priority($_) } @doubles;
print( ( sum(@priorities) ) . "\n" );

