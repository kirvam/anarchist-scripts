use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my %category_hash;
my %categories;

# Build a hash containing all of our data records...
while (<DATA>) {
  chomp;
  my %cat;
  print "$_\n";
  # name must be unique
  @cat{'parent','name','type','note'} = split /:/;
  $categories{$cat{name}} = \%cat;
}
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
}

print "--<Dumper \%category_hash>---\n";
print Dumper \%category_hash;
 
print "--<end>--\n";
print "---<print hash rec>-----\n";	  
print_hash_recursive(\%category_hash);
print "---<print hash rec>-----\n";	  


print_tree(\%category_hash);

#print "$category_hash->{'children'}->{'parent'}\n";

sub print_hash_recursive {
my($href) = @_;
foreach (nsort keys %{ $href } ){
        if (ref $href->{$_} eq 'HASH'){   
             #print "key: $_: HASH\n";
            print_hash_recursive($href->{$_});
             } else {
               print "$href->{$_} | ";
               #print "\tkey: $_: value: $href->{$_} |";
             #  print "\n$href->{parent} | $href->{id} | $href->{name} | $href->{note}\n"; 
   };
          #print "\n";
  };
          print "\n";
};  


sub print_hash {
my($href) = @_;
foreach my $k (nsort keys %{ $href } ){
           print "\$k: $k\n";
    #       print "$href->{$k}\n";
    #       print Dumper \$href->{$k};
    for my $l ( keys ${$href}{$k} ){
           print "\$l: $l\n";
           print "${$href}{$k}->{$l}\n";
       #for my $m ( keys $href->{$k}->{$l} ){
       #    print "$m:\n"; # ${$href}{$k}{$l}{$m}\n";
     #};
    };
   };
};

sub print_tree {
    my ($tree, $depth) = (@_, 0);
    ref $tree eq "HASH" or return;
    my $indent = "..." x $depth;
    for (sort keys %$tree) {
        #print $indent, /^\s*\z/ ? "<blank>" : $_;
        print $indent, /^\s*\z/ ? "<blank>" : $_;
         if(ref $tree->{$_} ne "HASH" ){print " | $tree->{$_}"};
        print_tree ($tree->{$_}, $depth + 1);
         print "\n";
        }      
};

sub print_tree_org {
   my ($tree, $depth) = @_;
   $depth ||= 0;
   my $indent = '...' x $depth;
   for (sort keys %$tree) {
      print($indent, /^\s*\z/ ? "<blank>" : $_, "\n");
      print_tree($tree->{$_}, $depth+1);
   }
}




# And now %category_hash is exactly the same as it was
# # in my previous post. Carry on with "show" as before.
#__DATA__
#top,Aircraft,Flying Machine,0
#Navy,Navy,Service Branch,top
#Army,Army,Service Branch,top
#P38,P38 Lightning,P38 Lightning,Army
#P51,P51 Mustang,P51 Mustang,Army
#Note1,Note1,Twin boom,P38
#Note2,Note2,Fastest Plane,P38
#Note3,Note3,Versatile,P38
#F4U,F4U Corsair,F4U Corsair,Navy
#Note1,Note1,Interceptor,P51
#Note2,Note2,Fighter Escort,P51

# 4 fields
#parent:name:type:note
__DATA__
none:Aircraft:Strategy:Flying machines
Aircraft:P38:Initiative:P38 Lightning
P38:P38-Note1:Note:Fighter Bomber
P38:P38-Note2:Note:Twin boom.
P38:P38-Metric1:Metric:133 recorded kills.
Aircraft:P51:Initiative:P51 Mustang
P51:P51-Note1:Note:Fastest plane.
P51:P51-Note2:Note:Versatile
