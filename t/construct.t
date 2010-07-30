use warnings;
use strict;

use IO::File 1.03;
use Test::More tests => 21;

require_ok "DateTime::TimeZone::Tzfile";

my $tz;

sub new_fh() { IO::File->new("t/london.tz") or die $! }

$tz = DateTime::TimeZone::Tzfile->new("t/london.tz");
ok $tz;
is $tz->name, "t/london.tz";

$tz = DateTime::TimeZone::Tzfile->new(filename => "t/london.tz");
ok $tz;
is $tz->name, "t/london.tz";

$tz = DateTime::TimeZone::Tzfile->new(filename => "t/london.tz",
	name => "foobar");
ok $tz;
is $tz->name, "foobar";

$tz = DateTime::TimeZone::Tzfile->new(name => "foobar",
	filename => "t/london.tz");
ok $tz;
is $tz->name, "foobar";

my $fh = new_fh();
$tz = DateTime::TimeZone::Tzfile->new(name => "foobar", filehandle => $fh);
ok $tz;
is $tz->name, "foobar";
ok $fh->eof;

eval { DateTime::TimeZone::Tzfile->new(); };
like $@, qr/\Afile not specified\b/;

eval { DateTime::TimeZone::Tzfile->new(name => "foobar"); };
like $@, qr/\Afile not specified\b/;

eval { DateTime::TimeZone::Tzfile->new(quux => "foobar"); };
like $@, qr/\Aunrecognised attribute\b/;

eval { DateTime::TimeZone::Tzfile->new(name => "foobar", name => "quux"); };
like $@, qr/\Atimezone name specified redundantly\b/;

eval { DateTime::TimeZone::Tzfile->new(filehandle => new_fh()); };
like $@, qr/\Atimezone name not specified\b/;

eval {
	DateTime::TimeZone::Tzfile->new(filename => "t/london.tz",
		filename => "t/london.tz");
};
like $@, qr/\Afilename specified redundantly\b/;

eval {
	DateTime::TimeZone::Tzfile->new(filehandle => new_fh(),
		filename => "t/london.tz");
};
like $@, qr/\Afilename specified redundantly\b/;

eval {
	DateTime::TimeZone::Tzfile->new(filename => "t/london.tz",
		filehandle => new_fh());
};
like $@, qr/\Afilehandle specified redundantly\b/;

eval {
	DateTime::TimeZone::Tzfile->new(filehandle => new_fh(),
		filehandle => new_fh());
};
like $@, qr/\Afilehandle specified redundantly\b/;

1;
