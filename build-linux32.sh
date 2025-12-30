#!/usr/bin/env bash
set -e

echo "== Linux x86 build =="

make distclean || true
rm -f config.status

export CFLAGS="-m32 -O2 -pipe -static -static-libgcc"
export LDFLAGS="-m32 -static"
export LIBS="-lpthread -ldl -lz"

./configure \
  --disable-shared \
  --enable-static \
  CFLAGS="$CFLAGS" \
  LDFLAGS="$LDFLAGS" \
  LIBS="$LIBS"

make -j$(nproc)

strip sugarmaker || true

file sugarmaker | grep static || true
