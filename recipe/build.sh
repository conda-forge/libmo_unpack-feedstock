#!/bin/bash

export CFLAGS="-I$PREFIX/include $CFLAGS"

mkdir build && cd build

cmake -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      $SRC_DIR

make
make test
make install
