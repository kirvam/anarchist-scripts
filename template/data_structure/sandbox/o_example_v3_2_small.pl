use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my %category_hash;
my %categories;


my $file = shift;

print "---< start >---\n";
print "\$file: $file\n";

#initial_loop($file);
my @AoA = make_AoA($file);

print "Dumper \@AoA\n";
#print Dumper \@AoA;

initial_loop_AoA(@AoA);

## Build a hash containing all of our data records...
#open(my $fh,"<","$file") || die "Flaming death of open $file: $!\n";
#while (<$fh>) {
#  chomp;
#  my %cat;
#  @cat{'id','parent','name','type','detail','parent_id'} = split /[,;:]\s{0,2}/;
#  $categories{$cat{id}} = \%cat;
#}
#
## ... and turn it into a tree
#foreach $_ (keys %categories) {
#  if ($categories{$_}{parent_id}) {
#    $categories{$categories{$_}{parent_id}}{children}{$_} =
#      $categories{$_};
#  } else {
#    $category_hash{$_} = $categories{$_};
#  }
#};


print "---< show 0 >---\n";
show(\%category_hash, 0);

#print "---< show 1 >---\n";
#show(\%category_hash, 1);

#print "---< show '2' >---\n";
#show1(\%category_hash, 2 );
 
#print "---< Dumper >----\n";
#print Dumper \%category_hash;




print "----< end >----\n";

### SUBS
###
sub make_AoA{
# make AoA from file
my($file)=@_;
my $AoA =();
open(my $fh,"<","$file") || die "Flaming death of open $file: $!\n";
while (<$fh>) {
   chomp;
   my @array = split /[,;:]\s{0,2}/;
   push @AoA, [ @array ];
  }; 
return(@AoA);
};

sub initial_loop{
my($file) = @_;
# Build a hash containing all of our data records...
open(my $fh,"<","$file") || die "Flaming death of open $file: $!\n";
while (<$fh>) {
  chomp;
  my %cat;
  @cat{'id','parent','name','type','detail','parent_id'} = split /[,;:]\s{0,2}/;
  $categories{$cat{id}} = \%cat;
}
# ... and turn it into a tree
foreach $_ (nsort keys %categories) {
  if ($categories{$_}{parent_id}) {
    $categories{$categories{$_}{parent_id}}{children}{$_} =
      $categories{$_};
  } else {
    $category_hash{$_} = $categories{$_};
  }
 };
};

sub initial_loop_AoA{
my(@AoA) = @_;
# Build a hash containing all of our data records...
for my $ii ( 0 .. $#AoA ){
       my $line;
   for my $jj ( 0 .. $#{ $AoA[$ii] } ){
       if ( $jj eq $#{ $AoA[$ii] } ){
            $line = $line.$AoA[$ii][$jj];
           } else {
              $line = $line.$AoA[$ii][$jj].",";      
          }
       }
         my %cat;
          print "\$line: $line\n";     
          @cat{'id','parent','name','type','detail','parent_id'} = split /[,]/,$line;
          $categories{$cat{id}} = \%cat;
 }
# ... and turn it into a tree
foreach $_ (nsort keys %categories) {
  if ($categories{$_}{parent_id}) {
    $categories{$categories{$_}{parent_id}}{children}{$_} =
      $categories{$_};
  } else {
    $category_hash{$_} = $categories{$_};
     }
   };
};

sub show {
  my ($hash, $lvl) = @_;
  my $prefix = '  ' x $lvl;
    foreach (nsort keys %$hash) {
     print "$prefix$_ : $hash->{$_}{name},$hash->{$_}{type},$hash->{$_}{detail}\n";
      show($hash->{$_}{children}, ++$lvl)
       if exists $hash->{$_}{children};
  }
};

sub show1 {
my $limit = 1;
my $count = 0;
  my ($hash, $lvl) = @_;
  my $prefix = '  ' x $lvl;
    foreach (nsort keys %$hash) {
     print "$prefix$_ : $hash->{$_}{name},$hash->{$_}{detail}\n";
        print "\$count: $count\n";
      if ( $count <= 1){ 
            show1($hash->{$_}{children}, ++$lvl) 
             if exists $hash->{$_}{children};
              print "---<entering recurve show1>-----\n";
              print "\$count is >= $limit:  $count\n";
              $count++;
         };
      #  print "\$count: $count\n";
      #  $count++;
  }
};


