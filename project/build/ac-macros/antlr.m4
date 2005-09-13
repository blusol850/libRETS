dnl
dnl Check for ANTLR
dnl
AC_DEFUN([MY_TEST_ANTLR], [
  AC_CHECK_PROG(ANTLR, antlr, antlr, [])
  if test x$ANTLR == "x"; then
    AC_MSG_ERROR([antlr is required to build librets])
  fi

  AC_MSG_CHECKING([whether linking with -lantlr works])
  save_LIBS=$LIBS
  LIBS="$LIBS -lantlr"
  AC_LANG_PUSH(C++)
  AC_LINK_IFELSE([
#include <antlr/CommonAST.hpp>
class TestAST : public ANTLR_USE_NAMESPACE(antlr)CommonAST {
};

int main(int, char * argv[])
{
  TestAST testAST;
  return 0;
}
  ], [
    AC_MSG_RESULT(yes)
    ANTLR_LIBS=-lantlr
  ], [
    AC_MSG_RESULT(no)
    AC_MSG_ERROR([Could not link with -lantlr])
  ]
  )
  AC_LANG_POP()
  LIBS=$save_LIBS

  AC_SUBST(ANTLR)
  AC_SUBST(ANTLR_LIBS)
])