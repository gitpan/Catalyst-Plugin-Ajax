package Catalyst::Helper::Ajax;

use strict;
use File::Spec;
use HTML::Ajax;

=head1 NAME

Catalyst::Helper::Ajax - Helper to generate Ajax library

=head1 SYNOPSIS

    script/create.pl Ajax

=head1 DESCRIPTION

Helper to generate Ajax library.

=head2 METHODS

=over 4

=item mk_stuff

Make the Ajax library.

=back 

=cut

sub mk_stuff {
    my ( $self, $helper ) = @_;
    my $file = File::Spec->catfile( $helper->{base}, 'root', 'ajax.js' );
    $helper->mk_file( $file, HTML::Ajax->new->raw_library );
}

=head1 SEE ALSO

L<Catalyst::Manual>, L<Catalyst::Test>, L<Catalyst::Request>,
L<Catalyst::Response>, L<Catalyst::Helper>

=head1 AUTHOR

Sebastian Riedel, C<sri@oook.de>

=head1 LICENSE

This library is free software . You can redistribute it and/or modify it under
the same terms as perl itself.

=cut

1;
