package Pod::Weaver::Section::CollectWithIntro;

# ABSTRACT: Preface pod collections

use Moose;
use namespace::autoclean;
use autobox::Core;
use aliased 'Pod::Elemental::Element::Pod5::Ordinary';

extends 'Pod::Weaver::Section::Collect';

=attr content *required*

The intro paragraph.  Right now this is expected to be a bog-simple string.
Using POD or other bits will probably be supported down the road, but for now,
it's just a string.

This is wrapped in a L<Pod::Elemental::Element::Pod5::Ordinary> and included
after the section header but before any of the elements.

=cut

has content => (is => 'ro', isa => 'Str', required => 1);

before weave_section => sub {
    my ($self, $document, $input) = @_;

    return unless $self->__used_container;

    ### make our paragraph node here...
    my $para = Ordinary->new(
        content => $self->content,
    );

    ### and add to the beginning of the node list..
    $self->__used_container->children->unshift($para);

    return;
};

__PACKAGE__->meta->make_immutable;
!!42;
__END__

=head1 SYNOPSIS

    ; weaver.ini
    [CollectWithIntro / ATTRIBUTES]
    command = attr
    content = These attributes are especially tasty in the fall.

    # in your Perl...
    =attr blueberries

    Holds our blueberries.

    =cut

    # in the output pod...
    =head1 ATTRIBUTES

    These attributes are especially tasty in the fall.

    =head2 blueberries

    # ... you get the idea.

=head1 DESCRIPTION

This is a subclass of L<Pod::Weaver::Section::Collect> that allows one to
attach a prefix paragraph to the collected section/node.

=head1 SEE ALSO

L<Pod::Weaver::Section::Collect>

=cut
