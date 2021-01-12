cmake_minimum_required (VERSION 3.12)
project (H5BITGROOM C)

#-----------------------------------------------------------------------------
# Basic H5BITGROOM stuff here
#-----------------------------------------------------------------------------
if (NOT H5PL_RESOURCES_DIR)
  include (${H5BITGROOM_SOURCE_DIR}/config/cmake/HDFMacros.cmake)
  include (${H5BITGROOM_SOURCE_DIR}/config/cmake/HDFPluginMacros.cmake)

  SET_HDF_BUILD_TYPE()
endif ()
BASIC_SETTINGS (${BITGROOM_PACKAGE_NAME})

set (H5BITGROOM_VERS_MAJOR 1)
set (H5BITGROOM_VERS_MINOR 0)
set (H5BITGROOM_VERS_RELEASE 0)

set (H5BITGROOM_SOVERS_MAJOR 1)
set (H5BITGROOM_SOVERS_MINOR 0)
set (H5BITGROOM_SOVERS_INTERFACE 1)
set (H5BITGROOM_SOVERS_RELEASE 0)
math (EXPR H5BITGROOM_SOVERS_MAJOR ${H5BITGROOM_SOVERS_INTERFACE}-${H5BITGROOM_SOVERS_RELEASE})

#-----------------------------------------------------------------------------
set (H5BITGROOM_PACKAGE_VERSION "${H5BITGROOM_VERS_MAJOR}.${H5BITGROOM_VERS_MINOR}.${H5BITGROOM_VERS_RELEASE}")
set (H5BITGROOM_PACKAGE_VERSION_STRING "${H5BITGROOM_PACKAGE_VERSION}")
set (H5BITGROOM_PACKAGE_VERSION_MAJOR "${H5BITGROOM_VERS_MAJOR}")
set (H5BITGROOM_PACKAGE_VERSION_MINOR "${H5BITGROOM_VERS_MINOR}")
set (H5BITGROOM_PACKAGE_STRING "${H5BITGROOM_PACKAGE_NAME} ${H5BITGROOM_PACKAGE_VERSION}")
set (H5BITGROOM_PACKAGE_TARNAME "${H5BITGROOM_PACKAGE_NAME}{HDF_PACKAGE_EXT}")
set (H5BITGROOM_PACKAGE_URL "http://www.hdfgroup.org")
set (H5BITGROOM_PACKAGE_BUGREPORT "help@hdfgroup.org")
set (H5BITGROOM_PACKAGE_SOVERSION "${H5BITGROOM_SOVERS_MAJOR}.${H5BITGROOM_SOVERS_RELEASE}.${H5BITGROOM_SOVERS_MINOR}")
set (H5BITGROOM_PACKAGE_SOVERSION_MAJOR "${H5BITGROOM_SOVERS_MAJOR}")
message("Configuring for bitgroom HDF5 Plugin version: " ${H5BITGROOM_PACKAGE_STRING})

#-----------------------------------------------------------------------------
# Include some macros for reusable code
#-----------------------------------------------------------------------------
include (${H5BITGROOM_RESOURCES_DIR}/H5BITGROOMMacros.cmake)

#-----------------------------------------------------------------------------
# Run all the CMake configuration tests for our build environment
#-----------------------------------------------------------------------------
include (${H5BITGROOM_RESOURCES_DIR}/ConfigureChecks.cmake)

#-----------------------------------------------------------------------------
# HDF5 support
#-----------------------------------------------------------------------------
HDF5_SUPPORT (TRUE)
message (STATUS "H5BITGROOM link libs: ${LINK_LIBS}")

include (ExternalProject)
set (H5PL_ALLOW_EXTERNAL_SUPPORT "NO" CACHE STRING "Allow External Library Building (NO GIT TGZ)")
set_property (CACHE H5PL_ALLOW_EXTERNAL_SUPPORT PROPERTY STRINGS NO GIT TGZ)
if (H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "GIT" OR H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
  option (BITGROOM_USE_EXTERNAL "Use External Library Building for BITGROOM" 1)
  if (H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "GIT")
    set (BITGROOM_URL ${BITGROOM_GIT_URL} CACHE STRING "Path to bitgroom git repository")
    set (BITGROOM_BRANCH ${BITGROOM_GIT_BRANCH})
  elseif (H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
    if (NOT TGZPATH)
      set (TGZPATH ${H5BITGROOM_SOURCE_DIR})
    endif ()
    set (BITGROOM_URL ${TGZPATH}/${BITGROOM_TGZ_NAME})
  else ()
    set (BITGROOM_USE_EXTERNAL 0)
  endif ()
endif ()
#-----------------------------------------------------------------------------
# bitgroom Library Settings
#-----------------------------------------------------------------------------
if (NOT BITGROOM_USE_EXTERNAL)
  set (FIND_BITGROOM_COMPONENTS static)
  find_package (BITGROOM NAMES ${BITGROOM_PACKAGE_NAME} COMPONENTS ${FIND_BITGROOM_COMPONENTS})
  message (STATUS "BITGROOM C libs: static:${BITGROOM_static_FOUND}")
  if (NOT BITGROOM_FOUND)
    find_package (BITGROOM) # Legacy find
  endif ()
endif ()
if (BITGROOM_FOUND)
  set (H5BITGROOM_HAVE_BZLIB_H 1)
  set (H5BITGROOM_HAVE_BITGROOM 1)
  set (H5BITGROOM_BITGROOM_HEADER "bitgroom.h")
  set (BITGROOM_INCLUDE_DIR_GEN ${BITGROOM_INCLUDE_DIR})
  set (BITGROOM_INCLUDE_DIRS ${BITGROOM_INCLUDE_DIR})
else ()
  if (H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "GIT" OR H5PL_ALLOW_EXTERNAL_SUPPORT MATCHES "TGZ")
    EXTERNAL_BITGROOM_LIBRARY (${H5PL_ALLOW_EXTERNAL_SUPPORT} STATIC)
    set (H5BITGROOM_HAVE_BZLIB_H 1)
    set (H5BITGROOM_HAVE_BITGROOM 1)
    message (STATUS "Filter BITGROOM is built")
  else ()
    message (FATAL_ERROR " bitgroom is Required for ${H5BITGROOM_PACKAGE_NAME} library")
  endif ()
endif ()
message (STATUS "bitgroom found: INC=${BITGROOM_INCLUDE_DIR} LIBS=${BITGROOM_LIBRARIES}")
set (LINK_LIBS ${LINK_LIBS} ${BITGROOM_LIBRARIES})

#-----------------------------------------------------------------------------
# Dashboard and Testing Settings
#-----------------------------------------------------------------------------
option (BUILD_TESTING "Build h5bitgroom Unit Testing" OFF)
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
  if (BITGROOM_FOUND AND BITGROOM_USE_EXTERNAL)
    add_dependencies (${H5BITGROOM_LIB_TARGET} BITGROOM)
  endif ()
endif ()

option (BUILD_EXAMPLES "Build h5bitgroom Examples" OFF)
if (BUILD_EXAMPLES)
  add_subdirectory (example)
endif ()

#-----------------------------------------------------------------------------
# Add file(s) to CMake Install
#-----------------------------------------------------------------------------
INSTALL_SUPPORT (H5BITGROOM)
