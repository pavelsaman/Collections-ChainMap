package Collections::ChainMap;

use strict;
use warnings;
use Readonly;
use Class::Std;
use Carp qw(croak);

our $VERSION = 0.002;

{
    my %maps :ATTR;

    sub BUILD {
        my $self     = shift;
        my $ident    = shift;
        my $args_ref = $self->_check_maps(shift);

        $maps{maps} = $args_ref->{maps};

        return;
    }

    sub _check_maps :PRIVATE {
        my $self     = shift;
        my $args_ref = shift;

        if (not defined $args_ref->{maps}
            or not ref $args_ref->{maps} eq ref []) {
            croak __PACKAGE__ . '::new(): no map provided.'
        }

        return $args_ref;
    }

    sub find {
        my $self  = shift;
        my $value = shift;

        foreach my $map (@{ $maps{maps} }) {
            if (defined $map->{$value}) {
                return $map->{$value};
            }
        }

        return;
    }

    sub add {
        my $self    = shift;
        my $map_ref = shift;

        if (not defined $map_ref
            or not ref $map_ref eq ref {}) {
            croak __PACKAGE__ . '::add(): no map provided';
        }

        push @{ $maps{maps} }, $map_ref;

        return;
    }

    sub add_maps {
        my $self     = shift;
        my $maps_ref = $self->_check_maps(shift);

        foreach my $map (@{ $maps_ref->{maps} }) {
            push @{ $maps{maps} }, $map;
        }

        return;
    }

    sub parents {
        my $self = shift;

        my @parents = ();
        for my $i (1..scalar @{ $maps{maps} } - 1) {
            push @parents, $maps{maps}->[$i];
        }

        my $map = Collections::ChainMap->new({ maps => \@parents });

        return $map;
    }
}

1;