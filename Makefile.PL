use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Catalyst::Plugin::Ajax',
    'VERSION_FROM' => 'Ajax.pm',
    'PREREQ_PM'    =>
      { Class::Data::Inheritable => 0, Catalyst => 0, HTML::Ajax => 0 }
);
