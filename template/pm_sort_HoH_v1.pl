#!/usr/bin/perl -w

use strict;

my %hash = (
    key1 => {
        key2 => {
            key3  => 'asdf',
            key3b => ';lkj',
            key3c =>
              { key4 => 'a', key4b => [ 0 .. 3 ], key4c => 'c' }
        },
        key2b => 'wer'
    }
);
my @array = (
    0 .. 5, [ 100 .. 105, [ 1000 .. 1005 ], 107 .. 109 ],
    7 .. 9
);
my $scalar = 'blah';

dump_data( 0, '$hash',   \%hash );
dump_data( 0, '$array',  \@array );
dump_data( 0, '$scalar', \$scalar );

sub dump_data {
    my ( $level, $base, $data ) = @_;
    my $nextlevel = $level + 1;
    if ( ref($data) eq 'ARRAY' ) {
        foreach my $k ( 0 .. $#{$data} ) {
            my $baseval = $base . '[' . $k . ']';
            dump_it( $nextlevel, $baseval, $data->[$k] );
        }
    }
    elsif ( ref($data) eq 'HASH' ) {
        foreach my $k ( sort( keys( %{$data} ) ) ) {
            my $baseval = $base . '{' . $k . '}';
            dump_it( $nextlevel, $baseval, $data->{$k} );
        }
    }
    elsif ( ref($data) eq 'SCALAR' ) {
        my $baseval = $base;
        dump_it( $nextlevel, $baseval, ${$data} );
    }

}

sub dump_it {
    my ( $nextlevel, $baseval, $datum ) = @_;
    my $reftype = ref($datum);
    if ( $reftype eq 'HASH' ) {
        dump_data( $nextlevel, $baseval, \%{$datum} );
    }
    elsif ( $reftype eq 'ARRAY' ) {
        dump_data( $nextlevel, $baseval, \@{$datum} );
    }
    else {
        process_data( $nextlevel, $baseval, $datum );
    }
}

sub process_data {
    my ( $nextlevel, $baseval, $datum ) = @_;
    my $indentation = '  ' x $nextlevel;
    print $indentation, $baseval, ' = ', $datum, "\n";
}
