#use strict;
use warnings;
use Data::Dumper;

my %category_hash;
my %categories;

# Build a hash containing all of our data records...
while (<DATA>) {
  chomp;
  my %cat;
  print "$_\n";
  @cat{'id','name','note','parent'} = split /,/;
  $categories{$cat{id}} = \%cat;
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

print "--<Dumper>---\n";
print Dumper \%category_hash;
 
print "--<end>--\n";
	  
print_hash_recursive(\%category_hash);
#print "$category_hash->{'children'}->{'parent'}\n";

sub print_hash_recursive {
my($href) = @_;
foreach (sort keys %{ $href } ){
        if (ref $href->{$_} eq 'HASH'){   
             print "key: $_: HASH\n\t";
            print_hash_recursive($href->{$_});
             } else {
               print "key: $_: value: $href->{$_}\n";
   };
  };
};  


sub print_hash {
my($href) = @_;
foreach my $k (sort keys %{ $href } ){
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





# And now %category_hash is exactly the same as it was
# # in my previous post. Carry on with "show" as before.
__DATA__
1,Aircraft,Flying Machine,0
2,Navy,Service Branch,1
3,Army,Service Branch,1
4,P38_Lightining,P38 Lightining,3
