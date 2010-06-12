#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'WWW::Vimeo::Download' ) || print "Bail out!
";
}

diag( "Testing WWW::Vimeo::Download $WWW::Vimeo::Download::VERSION, Perl $], $^X" );
