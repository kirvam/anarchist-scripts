use strict;
use warnings;
use Data::Dumper;
use Sort::Naturally;

my $file = shift;

my @AoA = while_loop_ret_AoA($file);

print Dumper \@AoA;



########
# SUBS
########
sub while_loop_ret_AoA {
print "----< sub while_loop_ret_AoA start>----\n";
my($file) = @_;
print "\$file: $file\n\n";
my @AoA;
   open( my $fh,"<","$file") || die "Flaming death on open of $file: $!\n";
    while(<$fh>){
      my $line = $_;
      chomp($line);
      my @array = split /[:;,]\s{0,2}/, $line;
        push @AoA, [@array];
        for my $ii ( @array ){
            print "$ii,";
         }
          print "\n";
    };
print "----< sub while_loop_ret_AoA end>----\n\n";
return(@AoA);      
}

sub search_ {


} 
