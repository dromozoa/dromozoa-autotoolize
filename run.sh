#! /bin/sh -e

here=`pwd`

root=`dirname "$0"`
root=`(cd "$root" && pwd)`

version=`"$root/dromozoa-autotoolize" version`

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

  cd "$here"
  case x$name in
    xlua-5.1) dist=lua-5.1.0.dromozoa-autotoolize-$version;;
    *) dist=$name.dromozoa-autotoolize-$version;;
  esac

  gzip -cd "$name/tmp/$dist.tar.gz" | tar xf -
  diff -qr "$name" "$dist" | tee "$dist.diff"
done
