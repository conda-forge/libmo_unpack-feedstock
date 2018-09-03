#!/bin/bash

if [[ $(uname) == Linux ]]; then
  export CFLAGS="-I$PREFIX/include $CFLAGS"
elif [[ $(uname) == Darwin ]]; then
  export CFLAGS="-Wl,-U,_MO_syslog -I$PREFIX/include $CFLAGS" 
fi

 
mkdir build && cd build

cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      $SRC_DIR

make -j$CPU_COUNT
make test
make install

# We can remove this when we start using the new conda-build.
find $PREFIX -name '*.la' -delete
