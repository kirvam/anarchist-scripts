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
         print "<h1>$key</h1>\n";
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
    print "<p>";
    print "\n";
  };
   #print "<p>";
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
     print "\n";
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
  @array = split(/\;\s+/,$line);
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
none; MS Dynamics; Microsoft will present a POC to primarily business on Thursday (based on business stories provided by participants and data from primary sources).; Green
none; O365 Working Group; Nothing so far this week, going to follow up with Karen Canas.  Still unsure what the priorities are for this project are?; Green
none; Federated Services; Static, focus has been on Dynamics POC this week.; Green
none; Amazon; Nothing much happening; Green
none; Business Continuity and Disaster Recovery (BC/DR);  Still need to meet with Secretary.; Green 
none; Auto Site Recovery (ASR);  Waiting for either Ray or VPN solution Jon is working on with David K.; Green
none; Tax BC/DR Plan; Met with Tom B and got some great input into the BIA for a few critical systems. Tom is going to get the rest of the documents updated electronically (info is gathered not entered) then we will transpose to the BIA worksheet.; Green  
none; Rubrik; Rubrik is still cool. Currently protecting 350 VMs and about 45TB of provisioned space. We have about 200TB of provisioned VM space still to go and will not be able to include all of that pre-VxRack (slow, old firewalls do not enough throughput to keep everything backed up on a daily cycle). Will be submitting ACLs today or tomorrow to be put on the cores at TV and NL to protect the data pipes to Rubrik. Will be adding some datamover filesystems soon. They will not traverse our slow old firewalls so we should start getting a bit closer to utilizing the potential of the solution.  That being said the existing network design will still be constricting it somewhat.; Green
none; Virtual Firewalling; Nothing to report.; Green
none; Resource Refresh and VxRack; Waiting for contract to be signed. Working with Jim on prep stuff so that Dell-EMC can start moving as soon as signed. Have pretty logical network diagram for the future VxRack environment. Networking needs to figure out how much they want to be part of the physical network gear included in the VxRack solution. Ray likes the idea of owning it.  Peter does not.  ACLs on the core really makes the most sense for the big, fat pipes. I do like the idea of removing our physical mgmt firewalls from the mix and it is something that should be a lot easier and less disruptive after migration to VxRack is complete.; Green
none; Refresh Network Security Design;  Still being put together.  Hoping for next Monday.; Green
none; Cloud Design; On hold, waiting on VPN and test plan for edge protection. Minor experimentation as ideas come up from training.; Green
none; VPN; Coordinating with David on his required info for a ticket to be created.; Green
none; LM and SolarWinds; Ray said no testing until new server was running. Pinged Rick on its status.  Waiting.; Gr
Business Continuity and Disaster Recovery (BC/DR); 11-07-2017; Note; Business Continuity and Disaster Recovery (BC/DR);  Assembling the spreadsheet Tom B gave me of their systems and putting into BIA format.; Green 
Auto Site Recovery (ASR); 11-07-2017; Note; Auto Site Recovery (ASR); Meeting with Jon today to knowledge transfer what he has been working on to move forward while he is on vacation.; Green
Tax BC/DR Plan; 11-07-2017; Note; Tax BC/DR Plan; Assembling the spreadsheet Tom B gave me of their systems and putting into BIA format.; Green
