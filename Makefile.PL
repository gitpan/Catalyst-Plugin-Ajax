use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Catalyst::Plugin::Ajax',
    'VERSION_FROM' => 'Ajax.pm',
    'PREREQ_PM'    => { Catalyst => 0 }
);
