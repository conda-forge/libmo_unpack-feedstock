#!/bin/bash

if [[ $(uname) == 'Darwin' ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == 'Linux' ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi


mkdir m4

# Patch the configure.ac as per https://lists.ubuntu.com/archives/fwts-devel/2013-June/003391.html
sed -i".ac" -e 's/AM_PROG_AR/m4_ifdef([AM_PROG_AR], [AM_PROG_AR])/g' configure.ac
autoreconf --install

CFLAGS="-O3 -mfpmath=sse -msse $CFLAGS"

if [[ $(uname) == Darwin ]]
then
    CFLAGS="$CFLAGS -D_DARWIN_SOURCE"
fi
./configure --prefix=$PREFIX CFLAGS="$CFLAGS"

make
eval ${LIBRARY_SEARCH_VAR}=$PREFIX/lib make check
make install
