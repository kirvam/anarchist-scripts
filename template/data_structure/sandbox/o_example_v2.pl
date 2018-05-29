use strict;
use Data::Dumper;
use Sort::Naturally;

my $file = shift;

print "----<start>---\n";
open (FH, $file ) || die "Could not open database: $:";
my %category_index = (); 
my %year_index = ();
my %name_index = (); 
my %parent_index = ();
while (my $line = <FH>) {
    chomp $line;

  #my($year, $category, $name) = split (/:/, $line);
   # create_entry($year, $category, $name) if $name;
  my($name, $note, $parent, $detail) = split (/:/, $line);
    create_entry_n($name, $note, $parent, $detail) if $name;

}


print "---<Dumper>---\n";
print "--<Name Index>---\n";
print Dumper \%name_index;
print "--<Parent_Index>---\n";
print Dumper \%parent_index;

print_entries_for_parent("P38");

print "--next---\n";
print_all_entries_for_name();

#print "---<tester>---\n";
#my $name = "Note1";
#print_entries_for_parent_tester($name);

print "---<find_key>---\n";
my $key = 'Note';
find_keys(\%parent_index,$key);
my $key = 'P38';
find_keys(\%name_index,$key);

print "-----<end>---\n";



###
sub find_keys {
my($href,$key) =@_;
 print "\$key: $key\n";
 #print "Dumper\n";
 # print Dumper \$href;
 # print "${$href}{$key}[0][0]\n";
 my @array =  @{ ${$href}{$key} } ;
 #foreach my $ii ( ${$href}{$key} ){
    for my $ii ( 0 .. $#array ){
      for my $jj ( 0 .. $#{ $array[$ii] }){
      print "$array[$ii][$jj],";
   };
      print "\n";
  };
  print "\n";
};

sub create_entry_n {             # create_entry (name,note,parent)
    my($name, $note, $parent, $detail) = @_;
    # Create an anonymous array for each entry
    my $rlEntry = [$name, $note, $parent, $detail];
    # Add this to the two indices
    push (@{$name_index{$name}}, $rlEntry);         # By Year
    push (@{$parent_index{$parent}}, $rlEntry);  # By Category
} 

###
sub print_entries_for_parent_tester {
    my($parent) = @_;
       print "parent: $parent\n";
      #if ( exists @{$parent_index{$parent}} ){ print "found parent: $parent\n";};
       #   print "$parent is not a parent\n"; 
       #   }
      # print "---<dumper \%parent_index>---\n";
      # print Dumper \%parent_index;
       my @array = @{$parent_index{$parent}};
      # print "---<dumper \@array>---\n";
      # print Dumper \@array;
        if (! @array){print "\@array is empty.\n";};
       if( @{$parent_index{$parent}} ) {print "Enter exist\n";};
         print ("Parent : $parent \n");
               foreach my $rlEntry (@{$parent_index{$parent}}) {
                if ( $rlEntry ) {
               print "yes entry\n";
               print ("\t",$rlEntry->[0]," : ",$rlEntry->[1], "  : ",$rlEntry->[2], "\n");
        } else { print "NO Entry!!!!\n";
      }
    }
};

###
sub print_entries_for_parent {
    my($parent) = @_;
        #if (! ref @{$parent_index{$parent}}){ print "\@array is empty.\n";};
        print "parent: $parent\n";
       
    foreach my $rlEntry (@{$parent_index{$parent}}) {
        print ("\t",$rlEntry->[0]," : ",$rlEntry->[1], "  : ",$rlEntry->[2], "\n");
       }
    }

sub print_all_entries_for_name {
    foreach my $name ( nsort keys %name_index) {
        print_entries_for_parent($name);
    #    print_entries_for_parent_tester($name);
    }
}

###
sub create_entry {             # create_entry (year, category, name)
    my($year, $category, $name) = @_;
    # Create an anonymous array for each entry
    my $rlEntry = [$year, $category, $name];
    # Add this to the two indices
    push (@{$year_index {$year}}, $rlEntry);         # By Year
    push (@{$category_index{$category}}, $rlEntry);  # By Category
} 

sub print_entries_for_year {
    my($year) = @_;
    print ("Year : $year \n");
    foreach my $rlEntry (@{$year_index{$year}}) {
        print ("\t",$rlEntry->[1], "  : ",$rlEntry->[2], "\n");
    }
}

sub print_all_entries_for_year {
    foreach my $year (reverse nsort keys %year_index) {
        print_entries_for_year($year);
    }
}
