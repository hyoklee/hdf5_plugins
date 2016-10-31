# This is the CMakeCache file.

########################
# EXTERNAL cache entries
########################

set (USE_SHARED_LIBS ON CACHE BOOL "Use Shared Libraries" FORCE)

set (BUILD_TESTING ON CACHE BOOL "Build h5blosc Unit Testing" FORCE)

set (BUILD_EXAMPLES ON CACHE BOOL "Build h5blosc Examples" FORCE)

set (HDF_ENABLE_PARALLEL OFF CACHE BOOL "Enable parallel build (requires MPI)" FORCE)

set (H5BLOSC_PACKAGE_NAME "h5blosc" CACHE STRING "Name of h5blosc package" FORCE)

set (H5BLOSC_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO GIT TGZ)" FORCE)
set_property (CACHE H5BLOSC_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO GIT TGZ)

set (BLOSC_GIT_URL "https://github.com/Blosc/c-blosc.git" CACHE STRING "Use BLOSC from Github" FORCE)
set (BLOSC_GIT_BRANCH "master" CACHE STRING "" FORCE)

set (BLOSC_TGZ_NAME "c-blosc.tar.gz" CACHE STRING "Use BLOSC from compressed file" FORCE)

set (BLOSC_PACKAGE_NAME "blosc" CACHE STRING "Name of BLOSC package" FORCE)

set (ZLIB_GIT_URL "https://git@bitbucket.hdfgroup.org/scm/test/zlib.git" CACHE STRING "Use ZLIB from HDF repo" FORCE)
set (ZLIB_GIT_BRANCH "master" CACHE STRING "" FORCE)

set (ZLIB_TGZ_NAME "ZLib.tar.gz" CACHE STRING "Use ZLib from compressed file" FORCE)

set (ZLIB_PACKAGE_NAME "zlib" CACHE STRING "Name of ZLIB package" FORCE)
