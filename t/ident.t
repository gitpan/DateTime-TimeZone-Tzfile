use Test::More tests => 8;

require_ok "DateTime::TimeZone::Tzfile";

$tz = DateTime::TimeZone::Tzfile->new("t/london.tz");
ok $tz;
ok !$tz->is_floating;
ok !$tz->is_utc;
ok !$tz->is_olson;
is $tz->category, undef;
is $tz->name, "t/london.tz";
ok $tz->has_dst_changes;
