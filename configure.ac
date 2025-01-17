# configure.ac: Autoconf template for zfs-rpms.  -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([zfs-rpms], [1.0.0], [])
AM_INIT_AUTOMAKE([foreign])

USR_PREFIX=/usr/sbin${PATH_SEPARATOR}/usr/bin${PATH_SEPARATOR}
LOCAL_PREFIX=/usr/local/sbin${PATH_SEPARATOR}/usr/local/bin${PATH_SEPARATOR}

AC_ARG_VAR([ZFS_BRANCH], "Branch of OpenZFS repository to clone")
AC_ARG_VAR([ZFS_TAG], "Tag/HEAD of OpenZFS branch to checkout")

AC_MSG_CHECKING([whether to search optional path])
AC_ARG_WITH([opt-path],
  [AS_HELP_STRING([--with-opt-path@<:@=PATH@:>@],
    [search optional PATH @{:@default: /opt/local/bin@:}@])],
  [], [with_opt_path=check])
if test ."$with_opt_path" = .'yes' || test ."$with_opt_path" = .'check'; then
    if test -d /opt/local/bin; then
        OPT_PREFIX=/opt/local/sbin${PATH_SEPARATOR}/opt/local/bin
    fi
elif test ! ."$with_opt_path" = .'no'; then
    if test -d "$with_opt_path"; then
        OPT_PREFIX=${with_opt_path}
    else
        AC_MSG_WARN([${with_opt_path}: No such file or directory])
    fi
fi
AC_MSG_RESULT([${OPT_PREFIX:-no}])
OPT_PATHS=$(echo "$OPT_PREFIX" | tr "${PATH_SEPARATOR}" ' ')
AC_SUBST([OPT_PATHS], ["$OPT_PATHS"])
OPT_PREFIX=${OPT_PREFIX:+"${OPT_PREFIX}${PATH_SEPARATOR}"}

# Checks for programs.
AC_PATH_PROGS([AWK_CMD],        [gawk awk],           [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROGS([CAT_CMD],        [gcat cat],           [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([DKMS_CMD],        [dkms],           [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([DNF_CMD],         [dnf],            [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([DRACUT_CMD],      [dracut],         [], [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROGS([FIND_CMD],       [gfind find],         [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROGS([FMT_CMD],        [gfmt fmt],           [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([GETOPT_CMD],      [getopt],         [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([GH_CMD],          [gh],             [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([GIT_CMD],         [git],            [], [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROGS([GREP_CMD],       [ggrep grep],         [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([ID_CMD],          [id],             [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([INSTALL_CMD],     [install],        [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([JQ_CMD],          [jq],             [], [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROGS([LS_CMD],         [gls ls],             [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([LSINITRD_CMD],    [lsinitrd],       [], [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROGS([MAKE_CMD],       [gmake make],         [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([MODPROBE_CMD],    [modprobe],       [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([MOKUTIL_CMD],     [mokutil],        [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([PYTHON_CMD],      [python],         [], [], [${USR_PREFIX}${PATH}])

AC_PATH_PROGS([REALPATH_CMD],   [grealpath realpath], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROGS([RMDIR_CMD],      [grmdir rmdir],       [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([RPM_CMD],         [rpm],            [], [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROGS([SED_CMD],        [gsed sed]            [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROGS([SLEEP_CMD],      [gsleep sleep],       [], [${OPT_PREFIX}${PATH}])

AC_PATH_PROG([SUDO_CMD],        [sudo],           [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([SYSTEMCTL_CMD],   [systemctl],      [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROG([TPUT_CMD],        [tput],           [], [], [${OPT_PREFIX}${PATH}])
AC_PATH_PROGS([UNAME_CMD],      [uname],          [], [], [${OPT_PREFIX}${PATH}])

AC_CONFIG_FILES([Makefile])
AC_CONFIG_FILES([zfs-rpms],                           [chmod +x zfs-rpms])

AC_OUTPUT
