#! /bin/sh
#
# Copyright by The HDF Group.
# Copyright by the Board of Trustees of the University of Illinois.
# All rights reserved.
#
# This file is part of HDF5.  The full HDF5 copyright notice, including
# terms governing use, modification, and redistribution, is contained in
# the files COPYING and Copyright.html.  COPYING can be found at the root
# of the source code distribution tree; Copyright.html can be found at the
# root level of an installed copy of the electronic HDF5 document set and
# is linked from the top-level documents page.  It can also be found at
# http://hdfgroup.org/HDF5/doc/Copyright.html.  If you do not have
# access to either file, you may request a copy from help@hdfgroup.org.

# This file is to test Async VOL created with the CMake process via Spack.
# Set SPACK_HOME. Modify this.
SPACK_HOME=/scr/hyoklee/src/spack-hyoklee

# Please do not change the rest.
. $SPACK_HOME/share/spack/setup-env.sh
spack load hdf5-cmake
HDF5_HOME="`$SPACK_HOME/bin/spack find --paths hdf5-cmake | tail  -1 | cut -d' ' -f 3-`"
ARGOBOTS_HOME="`$SPACK_HOME/bin/spack find --paths argobots | tail  -1 | cut -d' ' -f 3-`"

srcdir=..
builddir=.
verbose=yes
nerrors=0
asyncdir=../../src
H5CC=$HDF5_HOME/bin/h5cc
LD_LIBRARY_PATH=$HDF5_HOME/lib:$HDF5_HOME/lib/plugin:$ARGOBOTS_HOME/lib
HDF5_PLUGIN_PATH=$HDF5_HOME/lib:$HDF5_HOME/lib/plugin
export LD_LIBRARY_PATH
export HDF5_PLUGIN_PATH

if ! test -f $H5CC; then
    echo "Set paths for H5CC and LD_LIBRARY_PATH in test.sh"
    echo "Set environment variable HDF5_HOME to the hdf5 install dir"
    echo "h5cc was not found at $H5CC"
    exit $EXIT_FAILURE
fi

# Shell commands used in Makefiles
RM="rm -rf"
DIFF="diff -c"
CMP="cmp -s"
GREP='grep'
CP="cp -p"  # Use -p to preserve mode,ownership,timestamps
DIRNAME='dirname'
LS='ls'
AWK='awk'

# setup plugin path
ENVCMD="env HDF5_PLUGIN_PATH=$LD_LIBRARY_PATH/plugin"

TESTDIR=$builddir

$H5CC -g -I$asyncdir $srcdir/async_test_multifile.c -o async_test_multifile -L$HDF5_HOME/lib/plugin -lh5av -L$ARGOBOTS_HOME/lib -labt
./async_test_multifile

