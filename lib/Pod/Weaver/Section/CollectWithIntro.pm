package Pod::Weaver::Section::CollectWithIntro;

# ABSTRACT: Preface pod collections

use Moose;
use namespace::autoclean;
use autobox::Core;
use MooseX::AttributeShortcuts 0.015;
use Pod::Elemental::Element::Pod5::Ordinary; 

extends 'Pod::Weaver::Section::Collect';

has content => (is => 'ro', isa => 'Str', required => 1);

before weave_section => sub {
    my ($self, $document, $input) = @_;

    return unless $self->__used_container;

    ### make our paragraph node here...
    my $para = Pod::Elemental::Element::Pod5::Ordinary->new(
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
