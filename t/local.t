use warnings;
use strict;

use Test::More;

eval { require DateTime; };
plan skip_all => "DateTime not available" unless $@ eq "";
plan tests => 22;

require_ok "DateTime::TimeZone::Tzfile";

my $tz;

sub try($$) {
	my($timespec, $offset) = @_;
	$timespec =~ /\A([0-9]{4})-([0-9]{2})-([0-9]{2})T
			([0-9]{2}):([0-9]{2}):([0-9]{2})\z/x or die;
	my $dt = DateTime->new(year => $1, month => $2, day => $3,
			       hour => $4, minute => $5, second => $6,
			       time_zone => "floating");
	is eval { $tz->offset_for_local_datetime($dt) }, $offset,
		"offset for $timespec";
}

$tz = DateTime::TimeZone::Tzfile->new("t/london.tz");
try "1800-01-01T00:00:00", -75;
try "1920-03-28T01:59:59", +0;
try "1920-03-28T02:00:00", undef;
try "1920-03-28T02:59:59", undef;
try "1920-03-28T03:00:00", +3600;
try "1920-10-25T01:59:59", +3600;
try "1920-10-25T02:00:00", +0;
try "1920-10-25T02:59:59", +0;
try "1920-10-25T03:00:00", +0;
try "1942-04-05T01:59:59", +3600;
try "1942-04-05T02:00:00", undef;
try "1942-04-05T02:59:59", undef;
try "1942-04-05T03:00:00", +7200;
try "2039-03-27T00:59:59", +0;
try "2039-03-27T01:00:00", undef;
try "2039-03-27T01:59:59", undef;
try "2039-03-27T02:00:00", +3600;
try "2039-10-30T00:59:59", +3600;
try "2039-10-30T01:00:00", +0;
try "2039-10-30T01:59:59", +0;
try "2039-10-30T02:00:00", +0;

1;
