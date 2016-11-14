#! /bin/sh -e

here=`pwd`

root=`dirname "$0"`
root=`(cd "$root" && pwd)`

for i in "$@"
do
  cd "$here"

  name=`basename "$i"`
  name=`expr "x$name" : 'x\(.*\)\.tar\.gz$' || :`

  echo "processing $i"
  gzip -cd "$i" | tar xf -

  cd "$name"
  "$root/dromozoa-autotoolize"
  autoreconf -i

  mkdir -p tmp
  cd tmp
  ../configure
  make dist
done
