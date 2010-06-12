use Test::More tests => 1;

use strict;
use WWW::Vimeo::Download;

my $video = WWW::Vimeo::Download->new;

can_ok($video, qw(get_video_url download));
