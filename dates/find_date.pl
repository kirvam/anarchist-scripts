

my $date= create_date();
print "Date: $date\n";

sub create_date {
  my($day, $month, $year)=(localtime)[3,4,5];
  # my $date = "$day-".($month+1)."-".($year+1900);
  my $date = ($month+1)."-"."$day-".($year+1900);
  # print "$date\n";
  return($date);
};

