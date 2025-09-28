#!/usr/bin/env bash
#
# @(#)autogen.sh
#
# This script generates a GNU Autoconf configure script.
#
: ${ACLOCAL_CMD:='/usr/bin/aclocal'}
: ${AUTOMAKE_CMD:='/usr/bin/automake'}
: ${AUTORECONF_CMD:='/usr/bin/autoreconf'}
: ${BASH_CMD:='/bin/bash'}
: ${CAT_CMD:='/bin/cat'}
: ${REALPATH_CMD:='/bin/realpath'}
: ${SED_CMD:='/usr/bin/sed'}

if set +o 2>/dev/null | grep -q 'pipefail$'; then
    set -o pipefail
fi

which ()
{
    # Red Hat and OpenSUSE define `which' as an alias which isn't
    # exported to sub-shells, and though functions are shadowed by
    # aliases, at least this should be seen by sub-shells. Since
    # `type' is POSIX, and we can reasonably assume this function's
    # argument (one of the autotools) is in the command path, it ought
    # to serve our purposes, knock on wood.
    type "$1" 2>/dev/null |
        sed -n '1s,.*is \(/.*\),\1,p' || return $?
}

check-prerequisites ()
{
    local cmd=''
    local cmd_path=''

    for cmd in $ACLOCAL_CMD $AUTOMAKE_CMD $AUTORECONF_CMD; do
        if ! cmd_path=$(command -v "$cmd" 2>/dev/null); then
            $CAT_CMD >&2 <<EOF
${script_name}: ${cmd}: Command not found

Before running this script, please verify that \$PATH includes GNU
Autoconf and Automake commands.
EOF
            return 1
        fi
    done

    local -i major_ver=0

    major_ver=$(
        $BASH_CMD --version |
            $SED_CMD -n -e '/^.*bash, version \(.\).*/s//\1/p'
          ) || return $?

    if (( major_ver < 5 )); then
        $CAT_CMD >&2 <<EOF
${script_name}: bash: Version too old
Before running this script, please verify that \$PATH includes a
current version of GNU Bash which occurs before others.
EOF
        return 2
    fi
}

run-command ()
{
    local cmd=$1

    $verbose && $CAT_CMD <<EOF
${script_name}: Running:
    pushd "$script_dir" && $cmd
EOF

    local -i exit_status=0
    local cmd_output=''

    if ! cmd_output=$(pushd "$script_dir" && $cmd 2>&1); then
        printf "%s\n" "${script_name}:" "$cmd_output"
        return 3
    fi
}

if test ."$0" = ."${BASH_SOURCE[0]}"; then
    declare script=''
    declare script_name=''
    declare script_dir=''

    script=$($REALPATH_CMD -e "$0") || exit $?
    script_name=${script##*/}
    script_dir=${script%/*}

    declare -a command_list=(
        "$ACLOCAL_CMD --warnings=gnu"
        "$AUTOMAKE_CMD --verbose --add-missing"
        "$AUTORECONF_CMD --verbose --install"
    )

    verbose='true'
    case "$1" in
        -h*|--h*)
            echo "Usage: $script_name [-h|--help] [-s|--silent]"
            exit
            ;;
        -s*|--s*)
            verbose='false'
            shift
            ;;
    esac

    check-prerequisites || exit $?
    for cmd in "${command_list[@]}"; do
        run-command "$cmd" || exit $?
    done

    $verbose && $CAT_CMD >&2 <<EOF
$script_name:
========================================================================

     Automake and autoreconf appear to have completed successfully.
     To continue, optionally create and cd to a build directory, then
     run:

             \$ \$top_srcdir/configure [ZFS_BRANCH=master] [ZFS_TAG=HEAD]
             \$ make [PRS=xxx,...] [ZFS_BUILD_ROOT=${PWD}]
             \$ sudo make install [ZFS_BUILD_ROOT=${PWD}]

------------------------------------------------------------------------
EOF
fi
