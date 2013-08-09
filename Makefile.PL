use 5.008008;
use ExtUtils::MakeMaker;

$API = "/root/api764sp2linux";

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    NAME              => 'arstest',
    VERSION_FROM      => 'lib/arstest.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ($] >= 5.005 ?     ## Add these new keywords supported since 5.005
      (ABSTRACT_FROM  => 'lib/arstest.pm', # retrieve abstract from module
       AUTHOR         => 'Jeff Murphy <jcmurphy@localdomain>') : ()),
    LIBS              => ["-L$API/lib  -lnsl  -lpthread -R$API/lib  -lar_lx64 "], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => "-I. -I$API/include", # e.g., '-I. -I/usr/include/other'
	# Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
