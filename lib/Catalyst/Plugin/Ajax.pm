package Catalyst::Plugin::Ajax;

use strict;
use base 'Class::Data::Inheritable';
use HTML::Ajax;

our $VERSION = '0.04';

__PACKAGE__->mk_classdata('ajax');
__PACKAGE__->ajax( HTML::Ajax->new );

=head1 NAME

Catalyst::Plugin::Ajax - Plugin for Ajax

=head1 SYNOPSIS

    # use it
    use Catalyst qw/Ajax/;

    # ...add this to your tt2 template...
    [% c.ajax.library %]

    # ...and use the helper methods...
    <div id="view"></div>
    <textarea id="editor" cols="80" rows="24"></textarea>
    [% uri = base _ 'edit/' _ page.title %]
    [% c.ajax.observe_field( 'editor', uri, 2, 'view', 'body' ) %]

=head1 DESCRIPTION

Some stuff to make Ajax fun.

This plugin replaces L<Catalyst::Helper::Ajax>.

=head2 METHODS

=head3 ajax

    Returns a ready to use L<HTML::Ajax> object.

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
