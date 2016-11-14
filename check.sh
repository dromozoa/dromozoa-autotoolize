#! /bin/sh -e

here=`pwd`

root=`dirname "$0"`
root=`(cd "$root" && pwd)`

version=`"$root/dromozoa-autotoolize" version`

for i in "$@"
do
  name=`basename "$i"`
  name=`expr "x$name" : 'x\(.*\)\.tar\.gz$' || :`

  case x$name in
    xlua-5.1) dist=lua-5.1.0.dromozoa-autotoolize-$version;;
    x*) dist=$name.dromozoa-autotoolize-$version;;
  esac

  cd "$here"
  rm -fr "$dist"
  gzip -cd "$name-build/$dist.tar.gz" | tar xf -
  diff -r -x Makefile -x autom4te.cache -x luaconf.h "$name" "$dist"
done
