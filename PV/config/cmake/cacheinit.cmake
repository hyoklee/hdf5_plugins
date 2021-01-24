# This is the CMakeCache file.

########################
# EXTERNAL cache entries
########################

set (BUILD_TESTING ON CACHE BOOL "Build h5pv Unit Testing" FORCE)

set (BUILD_EXAMPLES ON CACHE BOOL "Build h5pv Examples" FORCE)

set (HDF5_PACKAGE_NAME "hdf5" CACHE STRING "Name of HDF5 package" FORCE)

set (PV_GIT_URL "https://github.com/hyoklee/pv.git" CACHE STRING "Use PV from HDF repository" FORCE)
set (PV_GIT_BRANCH "pv" CACHE STRING "" FORCE)

set (PV_TGZ_NAME "PV.tar.gz" CACHE STRING "Use PV from compressed file" FORCE)

set (PV_PACKAGE_NAME "pv" CACHE STRING "Name of PV package" FORCE)
set (H5PV_CPACK_ENABLE ON CACHE BOOL "Enable the CPACK include and components" FORCE)

set (H5PL_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO GIT TGZ)" FORCE)
set_property (CACHE H5PL_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO GIT TGZ)
