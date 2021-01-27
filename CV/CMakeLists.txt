cmake_minimum_required (VERSION 3.12)
project (H5CV C)

#-----------------------------------------------------------------------------
# Basic H5CV stuff here
#-----------------------------------------------------------------------------
if (NOT H5PL_RESOURCES_DIR)
  include (${H5CV_SOURCE_DIR}/config/cmake/HDFMacros.cmake)
  include (${H5CV_SOURCE_DIR}/config/cmake/HDFPluginMacros.cmake)

  SET_HDF_BUILD_TYPE()
endif ()
BASIC_SETTINGS (${CV_PACKAGE_NAME})

set (H5CV_VERS_MAJOR 1)
set (H5CV_VERS_MINOR 0)
set (H5CV_VERS_RELEASE 0)

set (H5CV_SOVERS_MAJOR 1)
set (H5CV_SOVERS_MINOR 0)
set (H5CV_SOVERS_INTERFACE 1)
set (H5CV_SOVERS_RELEASE 0)
math (EXPR H5CV_SOVERS_MAJOR ${H5CV_SOVERS_INTERFACE}-${H5CV_SOVERS_RELEASE})

#-----------------------------------------------------------------------------
set (H5CV_PACKAGE_VERSION "${H5CV_VERS_MAJOR}.${H5CV_VERS_MINOR}.${H5CV_VERS_RELEASE}")
set (H5CV_PACKAGE_VERSION_STRING "${H5CV_PACKAGE_VERSION}")
set (H5CV_PACKAGE_VERSION_MAJOR "${H5CV_VERS_MAJOR}")
set (H5CV_PACKAGE_VERSION_MINOR "${H5CV_VERS_MINOR}")
set (H5CV_PACKAGE_STRING "${H5CV_PACKAGE_NAME} ${H5CV_PACKAGE_VERSION}")
set (H5CV_PACKAGE_TARNAME "${H5CV_PACKAGE_NAME}{HDF_PACKAGE_EXT}")
set (H5CV_PACKAGE_URL "http://www.hdfgroup.org")
set (H5CV_PACKAGE_BUGREPORT "help@hdfgroup.org")
set (H5CV_PACKAGE_SOVERSION "${H5CV_SOVERS_MAJOR}.${H5CV_SOVERS_RELEASE}.${H5CV_SOVERS_MINOR}")
set (H5CV_PACKAGE_SOVERSION_MAJOR "${H5CV_SOVERS_MAJOR}")
message("Configuring for cv HDF5 Plugin version: " ${H5CV_PACKAGE_STRING})

#-----------------------------------------------------------------------------
# Include some macros for reusable code
#-----------------------------------------------------------------------------
include (${H5CV_RESOURCES_DIR}/H5CVMacros.cmake)

#-----------------------------------------------------------------------------
# Run all the CMake configuration tests for our build environment
#-----------------------------------------------------------------------------
include (${H5CV_RESOURCES_DIR}/ConfigureChecks.cmake)

#-----------------------------------------------------------------------------
# HDF5 support
#-----------------------------------------------------------------------------
HDF5_SUPPORT (TRUE)
message (STATUS "H5CV link libs: ${LINK_LIBS}")


set (LINK_LIBS ${LINK_LIBS} ${CV_LIBRARIES})

#-----------------------------------------------------------------------------
# Dashboard and Testing Settings
#-----------------------------------------------------------------------------
option (BUILD_TESTING "Build h5cv Unit Testing" OFF)
if (BUILD_TESTING)
  set (DART_TESTING_TIMEOUT 1200 CACHE STRING
       "Timeout in seconds for each test (default 1200=20minutes)")
  enable_testing ()
  include (CTest)
  include (${PROJECT_SOURCE_DIR}/CTestConfig.cmake)
  configure_file (${${PLUGIN_PACKAGE_NAME}_RESOURCES_DIR}/CTestCustom.cmake ${PROJECT_BINARY_DIR}/CTestCustom.ctest @ONLY)
endif ()

add_subdirectory (src)

if (H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "GIT" OR H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
  if (CV_FOUND AND CV_USE_EXTERNAL)
    add_dependencies (${H5CV_LIB_TARGET} CV)
  endif ()
endif ()

# option (BUILD_EXAMPLES "Build h5cv Examples" OFF)
# if (BUILD_EXAMPLES)
#  add_subdirectory (example)
# endif ()

#-----------------------------------------------------------------------------
# Add file(s) to CMake Install
#-----------------------------------------------------------------------------
INSTALL_SUPPORT (H5CV)
