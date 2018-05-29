#$string = "-9 55 48 -2 23 -76 4 14 -44";

$string = ";Aircraft,  Flying machines: top:  ";

print "\n$string\n\n";
while ($string =~ /[:,;]\s{0,2}/g) { $count++ }
$string =~ s/([:,;]\s{0,2})/^$1^/g;
print "$string\n\n";
print "The last \$1: ^$1^\n";

#while ($string =~ /:/g) { $count++ }
#while ($string =~ /-\d+/g) { $count++ }

print "There are $count matched regex hits in the string";
print "\n\n";


