#use strict;
use warnings;
use Data::Dumper;

my %category_hash;
my %categories;

# Build a hash containing all of our data records...
while (<DATA>) {
  chomp;
  my %cat;
  @cat{'id','name','parent'} = split /,/;
  $categories{$cat{id}} = \%cat;
}

# ... and turn it into a tree
foreach $_ (keys %categories) {
  if ($categories{$_}{parent}) {
    $categories{$categories{$_}{parent}}{children}{$_} =
      $categories{$_};
  } else {
    $category_hash{$_} = $categories{$_};
  }
}

print "--<Dumper>---\n";
print Dumper \%category_hash;

analyse_contig_tree_recursively(\%category_hash);

print "--<end>--\n";

sub print_hash {
my(%hash) = @_;

};

sub analyse_contig_tree_recursively {
    my $TAXA_TREE           =   shift @_;
    foreach ( sort keys %{$TAXA_TREE} ){
        print "$_ \n";
        if (ref $TAXA_TREE->{$_} eq 'HASH') {
            analyse_contig_tree_recursively($TAXA_TREE->{$_});
        }
             print "-->";
    }
  #print "\n";
}




# And now %category_hash is exactly the same as it was
# # in my previous post. Carry on with "show" as before.

__DATA__
1,whatever,0
2,something,1
3,another subcategory,2
4,something else,0
5,one more,4
6,two more,5
