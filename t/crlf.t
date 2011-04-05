use warnings;
use strict;

use Test::More tests => 2;

require_ok "DateTime::TimeZone::Tzfile";

my $tz = DateTime::TimeZone::Tzfile->new("t/cairo.tz");
ok 1;

1;
