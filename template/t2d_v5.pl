use strict;
use Data::Dumper;

my %hash;
my @array;
my $key;
my $line;
my $ii = 1;
my $actions = {
               'none' => sub { my $key = create_entry_time(); $key = $key+$ii; $hash{ $array[1] }{$key} = [ @array ]; },
               $hash{ $array[0] } => sub { my $key = create_entry_time(); $key = $key+$ii; $hash{ $array[0] }{$key} = [ @array ]; }, 
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }

};


while(<DATA>){
 my $line = $_;
 evaluateLine($line,$actions);
 $ii++;
 print $ii,"\n";
}

print "\n\nThe Dumper!\n";
print Dumper \%hash;
 
print "\n\n";

print "style_HoHoA_1\n";
style_HoHoA_1(%hash);
print "style_ref_HoHoA_1\n";
style_ref_HoHoA_1(\%hash);

my $hash_ref = \%hash;
list_all_keys($hash_ref);

print "\n\n";


##########
# SUBS
##########

###
sub style_ref_HoHoA_1 {
# 
print "\n\n";
my($hash_ref) = @_;
foreach my $key ( sort keys %$hash_ref ){
         print "$key\n";
          foreach my $entry ( sort keys %{ $hash_ref->{$key} } ){
            print "\t$entry, ";
              my @array =  $hash_ref->{$key}->{$entry} ;
                my $array;
                  for my $i ( 0 .. $#array ) {
                    for my $j ( 2 .. $#{ $array[$i] } ) {   
                     print "$array[$i][$j], ";
                   }
                };
    print "\n";
  };
};
  print "\n\n";
};

sub style_HoHoA_1 {
# 
print "\n\n";
my(%hash) = @_;
foreach my $key ( sort keys %hash ){
         print "$key\n";
          foreach my $entry ( sort keys %{ $hash{$key} } ){
            print "\t$entry, ";
              my @array =  $hash{$key}{$entry} ;
                my $array;
                  for my $i ( 0 .. $#array ) {
                    for my $j ( 2 .. $#{ $array[$i] } ) {   
                     print "$array[$i][$j], ";
                   }
                };
    print "\n";
  };
};
  print "\n\n";
}

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

sub list_all_keys {
print "Printing keys.\n";
my($hash_ref) = @_;
for my $key ( sort keys %$hash_ref ){
     print "key: $key\n";
      for my $item ( sort keys %{ $hash_ref->{ $key } } ){
          print "item: $item\n";
       }
  };
}




### Parent, ShortName, LongName, Description, Type
__DATA__
none, P38, P38, The P38 Lightning was one of the most successfull airplanes of WWII., Entry
none, P51, P51, The P51 Mustang was one of the most successful and fastest planes of WWII., Entry
P51, Speed, Aircraft Speed, The P51 Mustang had a top speed of 437 mph., Note
P38, Design, Aircraft Design, The P38 had a unique twin boom design., Note
P38, Top Speed, Aircrfat Speed, The P38 had a top speed of 443 mph., Note
