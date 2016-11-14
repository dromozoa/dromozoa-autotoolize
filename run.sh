#! /bin/sh -e

here=`pwd`

root=`dirname "$0"`
root=`(cd "$root" && pwd)`

for i in "$@"
do
  name=`basename "$i"`
  name=`expr "x$name" : 'x\(.*\)\.tar\.gz$' || :`

  cd "$here"
  gzip -cd "$i" | tar xf -

  cd "$name"
  "$root/dromozoa-autotoolize"
  autoreconf -i

  cd "$here"
  mkdir -p "$name-build"

  cd "$name-build"
  "../$name/configure"
  make dist
done
