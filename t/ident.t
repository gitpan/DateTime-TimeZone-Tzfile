use warnings;
use strict;

use Test::More tests => 15;

require_ok "DateTime::TimeZone::Tzfile";

my $tz;

$tz = DateTime::TimeZone::Tzfile->new("t/london.tz");
ok $tz;
ok !$tz->is_floating;
ok !$tz->is_utc;
ok !$tz->is_olson;
is $tz->category, undef;
is $tz->name, "t/london.tz";
ok $tz->has_dst_changes;

$tz = DateTime::TimeZone::Tzfile->new(
	name => "foo",
	category => "bar",
	is_olson => 1,
	filename => "t/london.tz",
);
ok $tz;
ok !$tz->is_floating;
ok !$tz->is_utc;
ok $tz->is_olson;
is $tz->category, "bar";
is $tz->name, "foo";
ok $tz->has_dst_changes;

1;
