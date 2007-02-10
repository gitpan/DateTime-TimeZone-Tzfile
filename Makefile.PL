use ExtUtils::MakeMaker;

WriteMakefile(
	NAME => "DateTime::TimeZone::Tzfile",
	VERSION_FROM => "lib/DateTime/TimeZone/Tzfile.pm",
	PREREQ_PM => {
		DateTime::TimeZone::SystemV => "0.000",
		IO::File => "1.03",
		IO::Handle => "1.08",
	},
);
