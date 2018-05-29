use strict;
use Data::Dumper;
use Sort::Naturally;

my %hash;
my @array;
my $key;
#my $line;
my $ii = 1;
my @AoA  = (); 
# there are assumptions around number of fields.. be careful of this...
# parent:name:type:note  4 fields
#
my $actions = {
               'none' => sub { my $key = "1"; $hash{ $array[1] }{$key} = [ @array ]; },
               $hash{ $array[0] } => sub { $ii++; my $key = create_entry_time(); $key = $key+$ii; $hash{ $array[0] }{$key} = [ @array ]; }, 
               '_DEFAULT_' => sub { die "Unrecognized token '$_[0]'; aborting\n" }

};


my $html = "report_table.html";
my $file = shift;

print "---<Start>---\n";
while_loop($file);
print Dumper \@AoA;

#exit;
print "\n==================\n";
print "for_while_loop_2\n";
for_while_loop_2($actions,@AoA);
#print Dumper \@AoA;
#print "Dumper \@AoA finished\n";
style_ref_HoHoA_1_print_FH(\%hash,$html);
#print "\nDumper\n";
print Dumper \%hash;

##########
# SUBS
##########
###
sub where_parent{
my($href,$parent) = @_;
 foreach ( nsort keys %{ $href }){
           print "key: $_\n";
           print "\$parent: $parent\n";
           if (ref $href->$_ eq "HASH"){
               where_parent($parent,$href->$_);
               } else {
                print "$href->$_";
             }
         print "\n";
     };
};
###
sub while_loop {
# while loop
my($file)=@_;
open( my $fh, "< $file") || die "Flamming death on open of $file: $!\n";
 while(<$fh>){
 my $line = $_;
 chomp($line);
  $line = check_add_line($line);
 my $alt = $line;
  my @alt = split(/,/,$alt);
     push @AoA, [ @alt ];
    print "Item number in list: $ii,\n";
#    evaluateLine($line,$actions);
#     check_add_line($line);
      $ii++;
 };
 close $fh;
}
###

sub check_add_line {
print "------------\n";
my($line) = @_;
my $count =();
print "\$line: $line\n";
chomp($line);
while ($line =~ /[:,;]\s{0,2}/g) { $count++ };
my $string = $line;
$string =~ s/([:,;]\s{0,2})/^$1^/g;
print "\$string: $string\n";
print "The last \$1: ^$1^\n";
print "Number of matched regex hits: $count\n";
 my(@array) = split /[:;,]\s{0,2}/, $line;
  print "Number items in \@array: ",$#array+1,"\n";
   print "[";
   foreach my $cc ( 0 .. $#array ){
     print "\"$array[$cc]\",";
       }
 print "]\n";
$line =~ s/([:,;]\s{0,2})/,/g;
return($line);
print "-------------\n";
};

###
sub for_while_loop_2{
my($actions,@AoA) = @_;
my $ii = 1;
for my $i ( 0 .. $#AoA ){
    my $line;
    for my $j ( 0 .. $#{$AoA[$i]} ){
          if ( $j eq 0 ){
          $line = $AoA[$i][$j];
         } else {
           $line = $line."; ".$AoA[$i][$j];
        };
       chomp($line);  
     };
       print "FOR WHILE: $ii: $line\n";
       $ii++;
       evaluateLine($line,$actions);
   };
};
 
sub style_ref_HoHoA_1_print_FH {
my($hash_ref,$html) = @_;
open ( my $fh, ">", "$html") || die "Flaming death on open of $html: $! \n"; 
print $fh "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"\n";
print $fh "        \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n";
print $fh "<html xmlns=\"http://www.w3.org/1999/xhtml\">\n";
print $fh "<head>\n";
print $fh "<meta http-equiv=\"Content-type\" content=\"text/html; charset=<% settings.charset %>\" />\n";
print $fh "<title>CS Project Dashboard</title>\n";
print $fh "<link rel=\"stylesheet\" href=\"http://10.80.8.12:443/css/style.css\" />\n";
print $fh "<!-- Grab jQuery from a CDN, fall back to local if necessary -->\n";
print $fh "<script src=\"//code.jquery.com/jquery-1.11.1.min.js\"></script>\n";
#print $fh "<script type=\"text/javascript\">/* <![CDATA[ */\n";
#print $fh "     !window.jQuery && document.write('<script type=\"text/javascript\" src=\"http://10.80.8.12:443/css/style.css/javascripts/jquery.js\"></script>')\n";
#print $fh "/* ]]> */</script>\n";
print $fh "<!-- End Comments -->\n";
print $fh "<style>\n";
print $fh "body {
    background-color: #ddd;
}
\n";

print $fh "\@media screen and (min-width: 480px) {
    body {
        background-color: cornflower;
    }
}\n";
print $fh "</style>\n";
my $big_string = "
  </head>
  <body>
    <div class=page>
    <h1>CS Dashboard</h1>
       <div class=metanav>
    </div>
  <ul class=entries>
  <table id=\"rounded-corner\" summary=\"Listing\"> 
\n";
print $fh "$big_string";
print $fh "<tbody bgcolor=\"#ffd\">\n";
print $fh "<tr style=\"background-color:darkblue; color:white;\">\n";
print $fh "<td>Heading OR Date</td>\n";
print $fh "<td>Staff</td>\n";
print $fh "<td>Parent</td>\n";
print $fh "<td>Note</td>\n";
print $fh "<td>Progress</td>\n";
print $fh "</tr>\n";
print $fh "</tbody>\n";

#my($hash_ref) = @_;
foreach my $key ( sort keys %$hash_ref ){
         print $fh "<!-- Start Heading -->\n";
         print $fh "<tbody>\n";
         print $fh "<tr style=\"background-color:#E6E6FA; color:black;\">\n";
         print $fh "<td>$key</td>\n";
         print $fh "</tr>\n";
         print $fh "</tbody>\n";
         #print "<h1>$key</h1>\n";
#         print "<tr>\n";
          #print $fh "<tr>\n";
          my $count = 0;
          foreach my $entry ( reverse sort keys %{ $hash_ref->{$key} } ){
            ###print "<h2>\t$entry, ";
                    if ( $count == 0 ){
                    print $fh "<!-- Start Listing  $#array $count-->\n";
                     print $fh "  <tbody bgcolor=\"#ffd\">\n";
                      print $fh "  <tr class=\"flip\"; style=\"background-color:lightblue; color:black;\">\n";                      
                      $count++;
                         print $fh "<!-- Flip Start $#array $count-->\n";
                           print $fh "  <tbody class=\"section\" style=\"display: none;\">\n";

                       } else {
#                          print $fh "<!-- Flip Start $#array $count-->\n";
#                           print $fh "  <tbody class=\"section\" style=\"display: none;\">\n";
                           print $fh "<!-- Flip Start $#array $count-->\n";
                           print $fh "  <tr>\n";
                           $count++;
                     };
            # print "<h2>";
            #print $fh "<tr>\n";
              my @array =  $hash_ref->{$key}->{$entry} ;
               #print Dumper \@array;
               # my $array;
                  for my $i ( 0 .. $#array ) {
               #     if ( $i == $#array ){
               #     print $fh "<!-- Start Listing  $#array -->\n";
               #      print $fh "<tbody bgcolor=\"#ffd\">\n";
               #       print $fh "<tr class=\"flip\"; style=\"background-color:lightblue; color:black;\">\n";                      
               #        } else {
               #           print $fh "<!-- Flip Start -->\n";
               #            print $fh "<tbody class=\"section\" style=\"display: none;\">\n";
               #         } 
                    for my $j ( 2 .. $#{ $array[$i] } ) {   
                     print $fh "  <td>$array[$i][$j]</td>\n";
                   }
             print $fh " </tr>\n";
             ##print $fh " </tbody>\n";
             ##print $fh "<!-- End -->\n";
                };
             #print $fh " </tbody>\n";
             #print $fh "<!-- End -->\n";
     print $fh "\n";
   };
             
             print $fh " </tbody>\n";
             print $fh "<!-- End -->\n";

   # print "</tr>\n";
  };

my $script = "<script>
\$('.flip').click(function() {
    \$(this)
        .closest('tbody')
        .next('.section')
        .toggle('fast');
});
</script>
";
  print $fh "$script\n";
   print $fh "</table>\n";
   print $fh "</div>\n";
   print $fh "</body>\n";
 print $fh "</html>\n";
 print $fh "\n\n";
};
###

sub evaluateLine {
my ($line,$actions) = @_;
  chomp($line);
  chomp($_[0]);
  print "EVAL LINE: $line\n";
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


#parent, name, note
__DATA__
top, mammal, type of critter
top, reptile, type of critter
mammal, domestic, lives in house
mammal, wild, feral
reptile, domestic, lives in house
reptile, wild, feral
domestic, dog, says ruff
domestic, cat, says meow
domestic, cow, says moo
wild, wolf, howls
wild, bear, eats everything
wild, moose, lives in swamp
wolf, note1, furry
wolf, note2, lives in packs
