use strict;
use Data::Dumper;

my %hash;
my @array;
my $key;
my $line;
my $ii = 1;
my $actions = {
               'none' => sub { my $key = "1"; $hash{ $array[1] }{$key} = [ @array ]; },
               $hash{ $array[0] } => sub { my $key = create_entry_time(); $key = $key+$ii; $hash{ $array[0] }{$key} = [ @array ]; }, 
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }

};

my $string =
"none, P38, P38, The P38 Lightning was one of the most successfull airplanes of WWII., Entry;
none, P51, P51, The P51 Mustang was one of the most successful and fastest planes of WWII., Entry;
P51, Speed, Aircraft Speed, The P51 Mustang had a top speed of 437 mph., Note;
P38, Design, Aircraft Design, The P38 had a unique twin boom design., Note;
P38, Top Speed, Aircrfat Speed, The P38 had a top speed of 443 mph., Note;";

my @arr1 = split(/\;/,$string);


while(<DATA>){
 my $line = $_;
 evaluateLine($line,$actions);
 $ii++;
 print $ii,"\n";
}

print "\n\nThe Dumper!\n";
print Dumper \%hash;
 
print "\n\n";

#print "style_HoHoA_1\n";
#style_HoHoA_1(%hash);
print "style_ref_HoHoA_1\n";
style_ref_HoHoA_1(\%hash);
style_ref_HoHoA_1_print(\%hash);

#my $hash_ref = \%hash;
#list_all_keys($hash_ref);

print "\n\n";
#evaluateLine($string,$actions);
#for_while_loop($actions,@arr1);


##########
# SUBS
##########
sub for_while_loop{
my($actions,@array) = @_;
my $ii;
foreach my $line (@array){
   chomp($line);
   $ii++;
   print $ii," ";
    evaluateLine($line,$actions);
 }
};
###
sub style_ref_HoHoA_1_print {
print "\n\n";
print "<html>\n";
my($hash_ref) = @_;
foreach my $key ( sort keys %$hash_ref ){
         print "<h1>$key</h2>\n";
          foreach my $entry ( sort keys %{ $hash_ref->{$key} } ){
            ###print "<h2>\t$entry, ";
             print "<h2>";
              my @array =  $hash_ref->{$key}->{$entry} ;
                my $array;
                  for my $i ( 0 .. $#array ) {
                    for my $j ( 2 .. $#{ $array[$i] } ) {   
                     print "$array[$i][$j], ";
                   }
                      print "</h2>";
                };
     print "\n";
   };
  };
 print "</html>";
 print "\n\n";
};
###

sub style_ref_HoHoA_1 {
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
P38, Top Speed, Aircraft Speed, The P38 had a top speed of 443 mph., Note
none, F6F, F6F, The F6F Hellcat was a carrier based plane on WWII., Entry
F6F, Top Speed, Aircraft Speed, The Top Speed of the Hellcat was 417 mph., Note 
none, F4U, F4U Corsair, The F4U Corsair was a very successfull carrier base fighter aircraft in WWII., Entry
F4U, Speed, Top Air Speed, The top air speed frot he Corsair was 446 mph., Note
F4U, Engine, Corsair Engines, The Corsair had a Pratt & Whitney R-2800 Double Wasp engine., Note
