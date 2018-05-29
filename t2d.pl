use strict;
use Data::Dumper;

my %hash;
my @array;
my $key;
my $line;
my $actions = {
               'none' => sub { $hash{ $array[1] } = [ @array ] },
               $hash{ $array[0] } => sub {print Dumper \%hash; my $rec = $array[0]; $key = create_entry_time(); print "key: $key | rec: $rec | line: $line\n"; $hash{$rec}{$key} = (); $hash{$rec}{$key} = $line }, 
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }

};

@array = ("none", "F6", "F6 Wildcat", "The Wildcat was a carrier based plan.");
$hash{F6} = [ @array ];


@array = ("Note", "Top Speed", "The top speed of the Wildcat was 367 mph.");

$key = "12345";
$hash{F6}{$key} = "test";
#$hash{F6}{12345} = [ @array ];

while(<DATA>){
 my $line = $_;
 evaluateLine($line,$actions);

}

print Dumper \%hash;

sub evaluateLine {
 ($line, $actions) = @_;
  chomp($line);
  chomp($_[0]);
  @array = split(/\,\s+/,$line);
  my $type;
  if($array[0] =~ m/^(none)$/){  
       $type = $1;
  ###     print "NONE: \$type: $type | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
    };
       print "\$type: $type | \$_[0]: $_[0] | \$array[0]: $array[0]\n";
  
 my $action = $actions->{$type}
               || $actions ->{$array[0]}
               || $actions ->{_DEFAULT_};
    $action->($array[0], $type, $actions);  
 
};



sub create_entry_time {
  my $entryTime = time(); 
  print $entryTime, "\n\n"; 
  return($entryTime);
};






### Parent,Name,Description, Type
__DATA__
none, P38, The P38 Lightning was one of the most successfull airplanes of WWII., Entry
none, P51, The P51 Mustang was one of the most successful and fastest planes of WWII., Entry
P51, Speed, The P51 Mustang had a top speed of 437 mph., Note
P38, Design, The P38 had a unique twin boom design., Note
P38, Top Speed, The P38 had a top speed of 443 mph., Note
