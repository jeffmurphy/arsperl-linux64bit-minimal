 package arstest;
    use 5.008008;
    use strict;
    use warnings;
    require Exporter;
    our @ISA = qw(Exporter);
    our %EXPORT_TAGS = ( 'all' => [ qw(ars_Login) ] );
    our @EXPORT_OK = ( @{ $EXPORT_TAGS{'all'} } );
    our @EXPORT = qw(ars_Login);
    our $VERSION = '0.01';
    require XSLoader;
    XSLoader::load('arstest', $VERSION);
    # Preloaded methods go here.
    1;
    __END__
