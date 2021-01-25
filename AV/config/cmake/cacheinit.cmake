# This is the CMakeCache file.

########################
# EXTERNAL cache entries
########################

set (BUILD_TESTING ON CACHE BOOL "Build h5av Unit Testing" FORCE)

set (BUILD_EXAMPLES ON CACHE BOOL "Build h5av Examples" FORCE)

set (HDF5_PACKAGE_NAME "hdf5" CACHE STRING "Name of HDF5 package" FORCE)

set (AV_GIT_URL "https://github.com/hyoklee/av.git" CACHE STRING "Use AV from HDF repository" FORCE)
set (AV_GIT_BRANCH "av" CACHE STRING "" FORCE)

set (AV_TGZ_NAME "AV.tar.gz" CACHE STRING "Use AV from compressed file" FORCE)

set (AV_PACKAGE_NAME "av" CACHE STRING "Name of AV package" FORCE)
set (H5AV_CPACK_ENABLE ON CACHE BOOL "Enable the CPACK include and components" FORCE)

set (H5PL_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO GIT TGZ)" FORCE)
set_property (CACHE H5PL_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO GIT TGZ)
