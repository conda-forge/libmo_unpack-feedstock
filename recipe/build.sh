#!/bin/bash

if [[ $(uname) == Linux ]]; then
  export CFLAGS="-I$PREFIX/include $CFLAGS"
elif [[ $(uname) == Darwin ]]; then
  export CFLAGS="-Wl,-U,_MO_syslog -I$PREFIX/include $CFLAGS" 
fi

 
mkdir build && cd build

cmake ${CMAKE_ARGS} -D CMAKE_INSTALL_PREFIX=$PREFIX \
      -D CMAKE_INSTALL_LIBDIR:PATH=$PREFIX/lib \
      $SRC_DIR

make -j$CPU_COUNT
if [[ "${CONDA_BUILD_CROSS_COMPILATION:-}" != "1" || "${CROSSCOMPILING_EMULATOR}" != "" ]]; then
make test
fi
make install
