use strict;
use warnings;
use Template;
    
  my $file = 'src/greeting.html';
  my $vars = {
     message  => "Hello World\n"
  };
    
  my $template = Template->new();
    
  $template->process($file, $vars)
   || die "Template process failed: ", $template->error(), "\n";
