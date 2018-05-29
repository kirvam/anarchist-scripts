use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my %category_hash;
my %categories;

###
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
###

# Build a hash containing all of our data records...
while (<DATA>) {
  chomp;
  my %cat;
   print "$_\n";
   @cat{'id','name','note','parent'} = split /,/;
     $categories{$cat{id}} = \%cat;
};
print Dumper \%categories;

# ... and turn it into a tree
foreach $_ (keys %categories) {
  print "$_\n";
  if ($categories{$_}{parent}) {
     print "printing parent: $categories{$_}{parent}\n";
       $categories{$categories{$_}{parent}}{children}{$_} =
         $categories{$_};
         print "printing categories: $categories{$_}\n";
         } else {
               print "failed IF\n";
               $category_hash{$_} = $categories{$_};
 }
};

#print "--<Dumper>---\n";
print Dumper \%category_hash;

print "--<end>--\n";


###
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
###

dump_data( 0, '$hash',   \%category_hash );

#dump_data( 0, '$hash',   \%hash );
#dump_data( 0, '$array',  \@array );
#dump_data( 0, '$scalar', \$scalar );


###
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


__DATA__
top,Aircraft,Flying Machine,0
Navy,Navy,Service Branch,top
Army,Army,Service Branch,top
P38,P38 Lightning,P38 Lightning,Army
P51,P51 Mustang,P51 Mustang,Army
Note1,Note1,Twin boom,P38
Note2,Note2,Fastest Plane,P38
Note3,Note3,Versatile,P38
F4U,F4U Corsair,F4U Corsair,Navy
Note1,Note1,Interceptor,P51
Note2,Note2,Fighter Escort,P51
