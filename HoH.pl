use strict;
use Data::Dumper;

my %HoH = ( P51 => {
                    2 => [ "Note", "Top Speeed", "Top speed is 437." ],
                    5 => [ "Note", "Range", "Long Range Fighter." ] 
                  },

            P38 => {
                    3 => [ "Note", "Top Speed", "Top speed is 447." ], 
                    4 => [ "Note", "Design", "The P38 had a unique twin boom design." ]
                  }, 
);


my @array = ("Note", "Success", "The P38 was one of the most successful combat aircrafts in history.");

$HoH{P38}{7} = [ @array ];

print Dumper \%HoH;



