# Collections::ChainMap

Simple Perl implementation of Python `collections.ChainMap`

## Methods

- `find(scalar)`:

    Searches in all maps and returns an associated value for the key in param if the key exists in at least one map.

- `add(hashref)`:

    Adds one map.

- `add_maps({ maps => [hashref, hashref] })`:

    Adds multiple maps, param is the same as with `new()` constructor.

## Usage

```
use Collections::ChainMap;

my %phonebook = ('pavel' => '785496125');
my %phonebook_old = ('peter' => '777258369');

my $chain_map = Collections::ChainMap->new({
    maps => [\%phonebook, \%phonebook_old]
});

if ($chain_map->find('mark')) {
    print 'Yes, one of your phonebooks contains Mark\'s number.';
}
else {
    print 'Mark is not in either phonebook.';
}
```

## Installation

```
$ perl Makefile.PL
$ make
$ make test
# make install
```