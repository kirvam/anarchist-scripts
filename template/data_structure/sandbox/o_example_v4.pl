use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my $file = shift;

print "----<start>---\n";
open (FH, $file ) || die "Flaming death on connecting/opening to DB/file: $:";
my %name_index = (); 
my %parent_index = ();
my %type_index = ();
my %type_copy = ();
while (my $line = <FH>) {
    chomp $line;
  my($parent, $name, $type, $detail) = split (/:/, $line);
    create_entry_n($parent, $name, $type, $detail) if $parent;
};

print "--<Name_Index>---\n";
print Dumper \%name_index;
print "--<Parent_Index>---\n";
print Dumper \%parent_index;
print "--<Type_Index>---\n";
print Dumper \%type_index;
%type_copy = %type_index;


print "---<print_entries_for_parent>---\n";
print_entries_for_parent('P38');

print "---<print_all_entries_for_name>---\n";
print_all_entries_for_name();
exit;

print "---<find_key>---\n";
my $key = 'Note';
find_keys(\%type_index,$key);
my $key = 'P38';
find_keys(\%parent_index,$key);
print "---<loop_thru>--\n";
print Dumper \%type_index;
my @array = loop_thru(\%type_copy);
print "---<Dumper %name_index>---\n";
print Dumper \%type_index;
print "---<\@array>---\n";
 foreach my $ii (0.. $#array){
     my $key = $array[$ii];
     print "items: ^$array[$ii]^\n";
      find_keys(\%type_index,$key);
};
#print "My key is Strategy.\n";
#my $key = 'Strategy';
#my $key = 'Note';
#my @AoA = find_keys(\%parent_index,$key);
#print "---<Dumper AoA>---\n";
#print Dumper \@AoA;

print "---<Printing AoA>---\n";
#print_AoA(@AoA);

my $key = 'Strategy';
my @AoA = find_keys(\%type_index,$key);
print_AoA(@AoA);

print "-----<end>---\n";


#
# Subs
#######################
sub find_relation {
#my(\%parent_index,\%name_index,$key) = @_;
 print "child: ";


};

sub print_AoA {
my(@AoA) = @_;
my $count;
 for my $ii ( 0 .. $#AoA ){
   $count++;
   print "$count: ";
  for my $jj ( 0 .. $#{ $AoA[$ii] } ){
     #print "$#{ $AoA[$ii] }\n";
    if ( $jj eq $#{ $AoA[$ii] } ){ 
    print "$AoA[$ii][$jj]";
    } else {
        print "$AoA[$ii][$jj],";
      };
    };
    print "\n";
  };
};

sub loop_thru {
my($href) = @_;
my @array;
foreach my $key (nsort keys %{ $href } ){
   if (${$href}{$key} == "ARRAY"){
   #  print "undefined\n" unless ${$href}{$key}; 
     print "\$key: $key\n"; 
     push @array, $key;
     };
   };
return(@array);
};

sub find_keys {
my($href,$key) =@_;
 # print "\$key: $key\n";
 # print "Dumper\n";
 # print Dumper \$href;
 my @AoA;
 my @array =  @{ ${$href}{$key} } ;
    for my $ii ( 0 .. $#array ){
      my @arr;
      for my $jj ( 0 .. $#{ $array[$ii] }){
      print "$array[$ii][$jj],";
      push @arr, $array[$ii][$jj];
   };
      print "\n";
      push @AoA, [ @arr ];
  };
  #print "\n";
 return (@AoA);
};

sub create_entry_n {             # create_entry (name,note,parent)
    my($parent, $name, $type, $detail) = @_;
    # Create an anonymous array for each entry
    my $rlEntry = [$parent, $name, $type, $detail];
    # Add this to the two indices
    push (@{$parent_index{$parent}}, $rlEntry);         # By Parent
    push (@{$type_index{$type}}, $rlEntry);  # By Type
    push (@{$name_index{$name}}, $rlEntry);  # By Name
} 

###
sub print_entries_for_parent_tester {
    my($parent) = @_;
       print "parent: $parent\n";
       my @array = @{$parent_index{$parent}};
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
        #print "parent: $parent\n";
       #my(@array) = @{$parent_index{$parent}};
        if( defined @{$parent_index{$parent}} ){
        #    print "TEST WORKS!\n";
            print  "parent: $parent\n"
           };
       #if( @{$parent_index{$parent}} == "ARRAY" ){
       #       print "Enter exist\n";};
       #       print "parent: $parent\n";
       #  };
         foreach my $rlEntry (@{$parent_index{$parent}}) {
                 print ("\t",$rlEntry->[0],":",$rlEntry->[1],":",$rlEntry->[2],":",$rlEntry->[3],"\n");
       }
};

sub print_all_entries_for_name {
    foreach my $name ( nsort keys %name_index) {
        print_entries_for_parent($name);
    #    print_entries_for_parent_tester($name);
  };
};

