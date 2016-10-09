m4_include([.dromozoa-release.m4])
m4_include([.dromozoa-version.m4])
AC_INIT([lua], LUA_R.DROMOZOA_PATCH, [moyu@dromozoa.com], [], [https://github.com/dromozoa/dromozoa-autotoolize/])
AM_INIT_AUTOMAKE
LT_INIT

AC_CONFIG_MACRO_DIR([m4])
AC_CONFIG_HEADER([src/config.h])
AC_CONFIG_FILES([Makefile doc/Makefile src/Makefile src/luaconf.h])

AC_PROG_CC
AC_PROG_MKDIR_P
AX_LIB_READLINE
LT_LIB_M
LT_LIB_DLLOAD

[LUA_R]='LUA_R'
[LUA_V]='LUA_V'
case x$ax_cv_lib_readline in
  xno) LUA_USE_READLINE='#undef LUA_USE_READLINE';;
  *) LUA_USE_READLINE='#define LUA_USE_READLINE';;
esac

AC_SUBST([LUA_R])
AC_SUBST([LUA_V])
AC_SUBST([LUA_USE_READLINE])

AC_OUTPUT
