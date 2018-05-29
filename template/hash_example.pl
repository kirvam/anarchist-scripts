use Data::Dumper;

my $hash = {
         'Army' => {
                      'P51' => {
                                  '1507914206' => [
                                                      'none',
                                                      'P51',
                                                      'The P51 Mustang was one of the most successful and fastest planes of WWII.',
                                                      'Entry'
                                                   ],
                                  '1507914207' => [
                                                    'P51',
                                                    'Speed',
                                                    'The P51 Mustang had a top speed of 437 mph.',
                                                    'Note'
                                                   ]
                                  },
                     },
         'Army-Aircorp' => {
                              'P38' => {
                                          '1507914205' => [
                                          'none',
                                          'P38',
                                          'The P38 Lightning was one of the most successfull airplanes of WWII.',
                                          'Entry'
                                              ],
                                          '1507914208' => [
                                          'P38',
                                          'Design',
                                          'The P38 had a unique twin boom design.',
                                          'Note'
                                               ],
                                         '1507914209' => [
                                                           'P38',
                                                           'Top Speed',
                                                           'The P38 had a top speed of 443 mph.',
                                                           'Note'
                                                         ]
                             }
            }
};


print Dumper \$hash;

