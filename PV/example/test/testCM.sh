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

# This file is to test Pass-through external VOL created with the CMake process 
# via Spack.

# Set SPACK_HOME. Modify this.
SPACK_HOME=/scr/hyoklee/src/spack-hyoklee

# Please do not change the rest.
. $SPACK_HOME/share/spack/setup-env.sh
spack load hdf5-cmake
HDF5_HOME="`$SPACK_HOME/bin/spack find --paths hdf5-cmake | tail  -1 | cut -d' ' -f 3-`"

srcdir=..
builddir=.
verbose=yes
nerrors=0
libdir=../../src
H5CC=$HDF5_HOME/bin/h5cc
LD_LIBRARY_PATH=$HDF5_HOME/lib:$HDF5_HOME/lib/plugin
export LD_LIBRARY_PATH

if ! test -f $H5CC; then
    echo "Set paths for H5CC and LD_LIBRARY_PATH in test.sh"
    echo "Set environment variable HDF5_HOME to the hdf5 install dir"
    echo "h5cc was not found at $H5CC"
    exit $EXIT_FAILURE
fi

case $H5CC in
*/*)    H5DUMP=`echo $H5CC | sed -e 's/\/[^/]*$/\/h5dump-shared/'`;
        test -x $H5DUMP || H5DUMP=h5dump-shared;
        H5REPACK=`echo $H5CC | sed -e 's/\/[^/]*$/\/h5repack-shared/'`;
        test -x $H5REPACK || H5REPACK=h5repack-shared;;
*)      H5DUMP=h5dump-shared;
        H5REPACK=h5repack-shared;;
esac

# Set command options.
RM="rm -rf"
DIFF="diff -c"
CMP="cmp -s"
GREP='grep'
CP="cp -p"
DIRNAME='dirname'
LS='ls'
AWK='awk'

# Set up plugin path.
ENVCMD="env HDF5_PLUGIN_PATH=$LD_LIBRARY_PATH/plugin"
TESTDIR=$builddir
$H5CC -g  -I$libdir -DENABLE_EXT_PASSTHRU_LOGGING  $srcdir/new_h5api_ex.c $srcdir/new_h5api.c  -o new_h5api_ex -L$HDF5_HOME/lib/plugin -lh5pv 
./new_h5api_ex
