#!/usr/bin/env bash
set -e

echo "== Linux x64 build =="

make distclean || true
rm -f config.status

export CFLAGS="-O2 -pipe -static -static-libgcc -static-libstdc++"
export LDFLAGS="-static -static-libgcc"
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
