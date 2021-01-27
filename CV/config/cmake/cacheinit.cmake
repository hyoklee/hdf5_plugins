# This is the CMakeCache file.

########################
# EXTERNAL cache entries
########################

set (BUILD_TESTING ON CACHE BOOL "Build h5cv Unit Testing" FORCE)

set (BUILD_EXAMPLES ON CACHE BOOL "Build h5cv Examples" FORCE)

set (HDF5_PACKAGE_NAME "hdf5" CACHE STRING "Name of HDF5 package" FORCE)

set (CV_GIT_URL "https://github.com/hyoklee/cv.git" CACHE STRING "Use CV from HDF repository" FORCE)
set (CV_GIT_BRANCH "cv" CACHE STRING "" FORCE)

set (CV_TGZ_NAME "CV.tar.gz" CACHE STRING "Use CV from compressed file" FORCE)

set (CV_PACKAGE_NAME "cv" CACHE STRING "Name of CV package" FORCE)
set (H5CV_CPACK_ENABLE ON CACHE BOOL "Enable the CPACK include and components" FORCE)

set (H5PL_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO GIT TGZ)" FORCE)
set_property (CACHE H5PL_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO GIT TGZ)
