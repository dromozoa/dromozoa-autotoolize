#! /bin/sh -e

# Copyright (C) 2016 Tomoyuki Fujimori <moyu@dromozoa.com>
#
# This file is part of dromozoa-autotoolize.
#
# dromozoa-autotoolize is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# dromozoa-autotoolize is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with dromozoa-autotoolize. If not, see <https://www.gnu.org/licenses/>.

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

  cd "$dist"
  ./configure
  make
  make check

  ./src/lua -v
  ./src/luac -v
done
