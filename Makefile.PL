use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Vimeo::Download',
    AUTHOR              => q{Alessandro Ghedini <alexbio@cpan.org>},
    VERSION_FROM        => 'lib/WWW/Vimeo/Download.pm',
    ABSTRACT_FROM       => 'lib/WWW/Vimeo/Download.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
        'LWP::UserAgent' => 0,
	'HTTP::Request::Common' => 0,
	'XML::Simple' => 0
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Vimeo-Download-*' },
);
