package WWW::Vimeo::Download;

use Carp;
use LWP::UserAgent;
use HTTP::Request::Common;
use XML::Simple;

use warnings;
use strict;

=head1 NAME

WWW::Vimeo::Download - Very simple Vimeo video downloader.

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.01';

=head1 SYNOPSIS

WWW::Vimeo::Download is a simple Vimeo video downloader.

    use WWW::Vimeo::Download;

    my $video = WWW::Vimeo::Download->new('123456');

    my $video_url = $video->get_video_url;

    $video->download('test.flv');

=head1 METHODS

=head2 new( $video_id )

Create a L<WWW::Vimeo::Download> object

=cut

sub new {
	my ($class, $video_id) = @_;
 
	my $self = bless({id => $video_id}, $class);

	return $self;
}

=head2 get_video_url

Return given video download URL

=cut

sub get_video_url {
	my $self = shift;

	my $xml_url  = "http://www.vimeo.com/moogaloop/load/clip:".$self -> {'id'};
	my $xml_data = get_request($xml_url);

	my $xml_handler = XMLin($xml_data);

	my $error = $xml_handler -> {error} -> {message};

	croak("ERROR: $error") unless !$error;

	my $req_sign 	 = $xml_handler -> {request_signature};
	my $req_sign_exp = $xml_handler -> {request_signature_expires};

	my $video_url = "http://www.vimeo.com/moogaloop/play/clip:".$self -> {'id'}."/$req_sign/$req_sign_exp/?q=sd";

	return $video_url;
}

=head2 download( $output_file )

Download the given video

=cut

sub download {
	my ($self, $output_file) = @_;

	croak("ERROR: Set output file") if !$output_file;

	my $video_url = $self -> get_video_url;

	get_request($video_url, $output_file);	
}

=head1 SUBROUTINES

=head2 get_request( $url )

Make a GET request.

=cut

sub get_request {
	my $url = shift;
	my @args = @_;
	
	my $ua = LWP::UserAgent -> new;
	$ua -> agent("");

	my $response = $ua -> request(HTTP::Request->new( GET => $url ), @args) -> as_string;
	

	my $status = (split / /,(split /\n/, $response)[0])[1];

	croak "ERROR: Server reported status $status" if $status != 200;

	my @data = split('\n\n', $response);

	return $data[1];
}

=head1 AUTHOR

Alessandro Ghedini, C<< <alexbio at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-www-vimeo-download at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WWW-Vimeo-Download>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WWW::Vimeo::Download


You can also look for information at:

=over 4

=item * Homepage

L<http://alexlog.co.cc/projects/www-vimeo-download>

=item * Git Repository

L<http://github.com/AlexBio/WWW-Vimeo-Download>

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WWW-Vimeo-Download>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WWW-Vimeo-Download>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WWW-Vimeo-Download>

=item * Search CPAN

L<http://search.cpan.org/dist/WWW-Vimeo-Download/>

=back

=head1 LICENSE AND COPYRIGHT

Copyright 2010 Alessandro Ghedini.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1; # End of WWW::Vimeo::Download
