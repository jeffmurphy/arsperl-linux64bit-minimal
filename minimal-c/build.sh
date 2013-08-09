#!/bin/sh -x

API=/root/api764sp2linux

gcc  -I. -I${API}/include -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -fstack-protector -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m64 -mtune=generic   -DVERSION=\"0.01\" -DXS_VERSION=\"0.01\" "-I/usr/lib64/perl5/CORE"   arstest.c -L${API}/lib -lnsl -lpthread -lar_lx64 -ldl

export LD_LIBRARY_PATH=${API}/lib:${API}/bin

./a.out
