use 5.030002;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME          => 'Collections::ChainMap',
    VERSION_FROM  => 'lib/Collections/ChainMap.pm',
    PREREQ_PM     => {},
    ABSTRACT_FROM => 'lib/Collections/ChainMap.pm',
    AUTHOR        => 'Pavel Saman <pavelsam@centrum.cz>',   
    LICENSE       => 'perl'
);
