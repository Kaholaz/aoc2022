#!/usr/bin/perl

use warnings;
use strict;

sub print_top_creates {
    my @stacks = @_;

    for ( my $i = 0 ; $i < ( scalar @stacks ) ; ++$i ) {
        print( scalar @{ $stacks[$i] } ? $stacks[$i][0] : " " );
    }
    print "\n";
}

sub read_initial_stack_line {
    my $line = shift;

    my @stacks = ();
    my $i      = 0;
    while ( $line =~ /.(.).\s/g ) {
        return () if $1 eq "1";

        my @create = ();
        push( @create, $1 ) unless $1 eq " ";
        push( @stacks, \@create );
    }

    return @stacks;
}

sub read_initial_stacks_from_stdin {
    my @stacks = ();
    while (<>) {
        my @line = read_initial_stack_line($_);
        last unless scalar @line;    # Stack desc is over.

        # If @stacks has not been initialized.
        unless ( scalar @stacks ) {
            @stacks = @line;
            next;
        }

        # Push nothing if there was no create in the stack
        for ( my $i = 0 ; $i < scalar(@line) ; ++$i ) {
            push( @{ $stacks[$i] }, @{ $line[$i] } );
        }
    }

    return @stacks;
}

my @stacks = read_initial_stacks_from_stdin();

# Read moves
while (<>) {
    next unless ( $_ =~ /move (\d*) from (\d*) to (\d*)/ );

    for ( my $i = 0 ; $i < $1 ; ++$i ) {
        my $create = shift @{ $stacks[ $2 - 1 ] };
        unshift( @{ $stacks[ $3 - 1 ] }, $create );
    }
}

print_top_creates(@stacks);
