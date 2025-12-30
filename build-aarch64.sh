#!/usr/bin/env bash
set -e

echo "== Linux AArch64 build =="

make distclean || true
rm -f config.status

export CFLAGS="-O2 -pipe -static"
export LDFLAGS="-static"
export LIBS="-lpthread -ldl -lz"

./configure \
  --host=aarch64-linux-gnu \
  --disable-shared \
  --enable-static \
  CFLAGS="$CFLAGS" \
  LDFLAGS="$LDFLAGS" \
  LIBS="$LIBS"

make -j$(nproc)

strip sugarmaker || true

file sugarmaker | grep static || true
