use strict;
use warnings;

my %hash = (
    "192.168.0.1" => { 
        "randy"  => "thomas",
        "ken"    => "samual"
    },
    "192.168.0.2" => {
        "jessie" => "jessica",
        "terry"  => "ryan",
        "bill" => { "murray" => "SNL",
                    "eddy" => "murphy"
           },
    }
);

traverse( \%hash );

sub traverse {
    if( ref( $_[0] ) =~ /HASH/ ) {
        traverse( $_[0]{$_} ) foreach keys %{$_[0]};
    } else {
        print "$_[0]\n";
    }
}
