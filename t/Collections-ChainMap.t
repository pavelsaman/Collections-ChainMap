use strict;
use warnings;
use Test::More qw(no_plan);

use Collections::ChainMap;

###############################################################################

my %a = (
    1 => 'a',
    2 => 'b'
);

my %b = (
    3 => 'c',
    4 => 'd'
);

###############################################################################

subtest 'Compile Module' => sub {
    use_ok('Collections::ChainMap');
};

###############################################################################

subtest 'No Maps Provided' => sub {
    my $chain_map = eval{ Collections::ChainMap->new({ }) };
    my $error = $@;

    is($chain_map, undef);
    like($error, qr/no map provided/);
};

###############################################################################

subtest 'No Maps Provided' => sub {
    my $chain_map = eval{ Collections::ChainMap->new({ maps => "" }) };
    my $error = $@;

    is($chain_map, undef);
    like($error, qr/no map provided/);
};

###############################################################################

subtest 'Create ChainMap Object' => sub {
    isa_ok(Collections::ChainMap->new({ maps => [\%a, \%b] }),
        'Collections::ChainMap')
    ;
};

###############################################################################

subtest 'Find Key From a' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%b] });

    is($cm->find(1), 'a');
};

###############################################################################

subtest 'Key Does Not Exist' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%b] });

    is($cm->find(8), undef);
};

###############################################################################

subtest 'Find Key From b' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%b] });

    is($cm->find(3), 'c');
};

###############################################################################

subtest 'Return Only One Value' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%a] });

    is($cm->find(1), 'a');
};

###############################################################################

subtest 'Add Map' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%a] });
    $cm->add({ '5' => 'e' });

    is($cm->find(5), 'e');
};

###############################################################################

subtest 'Add Multiple Maps' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%a] });
    $cm->add_maps({ maps => [{ '5' => 'e' }, { '6' => 'f' }] });

    is($cm->find(6), 'f');
};

###############################################################################

subtest 'Parents - Skip The First Map' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a, \%b] });   

    my $cm_parents = $cm->parents();
    isa_ok($cm_parents, 'Collections::ChainMap');
    is($cm_parents->find(1), undef);
    is($cm_parents->find(3), 'c');
};

###############################################################################

subtest 'Parents - No More Maps' => sub {
    my $cm = Collections::ChainMap->new({ maps => [\%a] });   

    my $cm_parents = $cm->parents();
    isa_ok($cm_parents, 'Collections::ChainMap');
    is($cm_parents->find(1), undef);
    is($cm_parents->find(3), undef);
};
