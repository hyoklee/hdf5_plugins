#-----------------------------------------------------------------------------
# Include all the necessary files for macros
#-----------------------------------------------------------------------------
include (CheckFunctionExists)
include (CheckIncludeFile)
include (CheckIncludeFileCXX)
include (CheckIncludeFiles)
include (CheckLibraryExists)
include (CheckSymbolExists)
include (CheckTypeSize)
include (CheckVariableExists)
include (TestBigEndian)
if (CMAKE_CXX_COMPILER AND CMAKE_CXX_COMPILER_LOADED)
  include (TestForSTDNamespace)
endif ()

#-----------------------------------------------------------------------------
# APPLE/Darwin setup
#-----------------------------------------------------------------------------
if (APPLE)
  list (LENGTH CMAKE_OSX_ARCHITECTURES ARCH_LENGTH)
  if (ARCH_LENGTH GREATER 1)
    set (CMAKE_OSX_ARCHITECTURES "" CACHE STRING "" FORCE)
    message(FATAL_ERROR "Building Universal Binaries on OS X is NOT supported by the H5BZ2 project. This is"
    "due to technical reasons. The best approach would be build each architecture in separate directories"
    "and use the 'lipo' tool to combine them into a single executable or library. The 'CMAKE_OSX_ARCHITECTURES'"
    "variable has been set to a blank value which will build the default architecture for this system.")
  endif ()
  set (AC_APPLE_UNIVERSAL_BUILD 0)
endif ()

# Check for Darwin (not just Apple - we also want to catch OpenDarwin)
if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    set (HAVE_DARWIN 1)
endif ()

# Check for Solaris
if (${CMAKE_SYSTEM_NAME} MATCHES "SunOS")
    set (HAVE_SOLARIS 1)
endif ()

#-----------------------------------------------------------------------------
# This MACRO checks IF the symbol exists in the library and IF it
# does, it appends library to the list.
#-----------------------------------------------------------------------------
set (LINK_LIBS "")
macro (CHECK_LIBRARY_EXISTS_CONCAT LIBRARY SYMBOL VARIABLE)
  CHECK_LIBRARY_EXISTS ("${LIBRARY};${LINK_LIBS}" ${SYMBOL} "" ${VARIABLE})
  if (${VARIABLE})
    set (LINK_LIBS ${LINK_LIBS} ${LIBRARY})
  endif ()
endmacro ()

# ----------------------------------------------------------------------
# WINDOWS Hard code Values
# ----------------------------------------------------------------------

set (WINDOWS)
if (WIN32)
  if (MINGW)
    set (HAVE_MINGW 1)
    set (WINDOWS 1) # MinGW tries to imitate Windows
    set (CMAKE_REQUIRED_FLAGS "-DWIN32_LEAN_AND_MEAN=1 -DNOGDI=1")
  endif ()
  set (HAVE_WIN32_API 1)
  set (CMAKE_REQUIRED_LIBRARIES "ws2_32.lib;wsock32.lib")
  if (NOT UNIX AND NOT MINGW)
    set (WINDOWS 1)
    set (CMAKE_REQUIRED_FLAGS "/DWIN32_LEAN_AND_MEAN=1 /DNOGDI=1")
    if (MSVC)
      set (HAVE_VISUAL_STUDIO 1)
    endif ()
  endif ()
endif ()

if (WINDOWS)
  set (HAVE_STDDEF_H 1)
  set (HAVE_SYS_STAT_H 1)
  set (HAVE_SYS_TYPES_H 1)
  set (HAVE_LIBM 1)
  set (HAVE_SYSTEM 1)
  if (NOT MINGW)
    set (HAVE_GETHOSTNAME 1)
  endif ()
  if (MINGW)
    set (HAVE_WINSOCK2_H 1)
  endif ()
  set (HAVE_LIBWS2_32 1)
  set (HAVE_LIBWSOCK32 1)
endif ()

# ----------------------------------------------------------------------
# END of WINDOWS Hard code Values
# ----------------------------------------------------------------------

#-----------------------------------------------------------------------------
#  Check for the math library "m"
#-----------------------------------------------------------------------------
if (NOT WINDOWS)
  CHECK_LIBRARY_EXISTS_CONCAT ("m" ceil     HAVE_LIBM)
  CHECK_LIBRARY_EXISTS_CONCAT ("dl" dlopen     HAVE_LIBDL)
  CHECK_LIBRARY_EXISTS_CONCAT ("ws2_32" WSAStartup  HAVE_LIBWS2_32)
  CHECK_LIBRARY_EXISTS_CONCAT ("wsock32" gethostbyname HAVE_LIBWSOCK32)
endif ()

# UCB (BSD) compatibility library
CHECK_LIBRARY_EXISTS_CONCAT ("ucb"    gethostname  HAVE_LIBUCB)

# For other tests to use the same libraries
set (CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES} ${LINK_LIBS})

set (USE_INCLUDES "")
if (WINDOWS)
  set (USE_INCLUDES ${USE_INCLUDES} "windows.h")
endif ()

if (NOT WINDOWS)
  TEST_BIG_ENDIAN (WORDS_BIGENDIAN)
endif ()

# For other specific tests, use this MACRO.
macro (H5BZ2_FUNCTION_TEST OTHER_TEST)
  if (NOT DEFINED ${OTHER_TEST})
    set (MACRO_CHECK_FUNCTION_DEFINITIONS "-D${OTHER_TEST} ${CMAKE_REQUIRED_FLAGS}")
    set (OTHER_TEST_ADD_LIBRARIES)
    if (CMAKE_REQUIRED_LIBRARIES)
      set (OTHER_TEST_ADD_LIBRARIES "-DLINK_LIBRARIES:STRING=${CMAKE_REQUIRED_LIBRARIES}")
    endif ()

    foreach (def ${H5BZ2_EXTRA_TEST_DEFINITIONS})
      set (MACRO_CHECK_FUNCTION_DEFINITIONS "${MACRO_CHECK_FUNCTION_DEFINITIONS} -D${def}=${${def}}")
    endforeach ()

    foreach (def
        HAVE_UNISTD_H
        HAVE_SYS_TYPES_H
    )
      if ("${${def}}")
        set (MACRO_CHECK_FUNCTION_DEFINITIONS "${MACRO_CHECK_FUNCTION_DEFINITIONS} -D${def}")
      endif ()
    endforeach ()

    if (LARGEFILE)
      set (MACRO_CHECK_FUNCTION_DEFINITIONS
          "${MACRO_CHECK_FUNCTION_DEFINITIONS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE"
      )
    endif ()

    #message (STATUS "Performing ${OTHER_TEST}")
    try_compile (${OTHER_TEST}
        ${CMAKE_BINARY_DIR}
        ${H5BZ2_RESOURCES_DIR}/H5PLTests.c
        CMAKE_FLAGS -DCOMPILE_DEFINITIONS:STRING=${MACRO_CHECK_FUNCTION_DEFINITIONS}
        "${OTHER_TEST_ADD_LIBRARIES}"
        OUTPUT_VARIABLE OUTPUT
    )
    if (${OTHER_TEST})
      set (${OTHER_TEST} 1 CACHE INTERNAL "Other test ${FUNCTION}")
      message (STATUS "Performing Other Test ${OTHER_TEST} - Success")
    else ()
      message (STATUS "Performing Other Test ${OTHER_TEST} - Failed")
      set (${OTHER_TEST} "" CACHE INTERNAL "Other test ${FUNCTION}")
      file (APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
          "Performing Other Test ${OTHER_TEST} failed with the following output:\n"
          "${OUTPUT}\n"
      )
    endif ()
  endif ()
endmacro ()

H5BZ2_FUNCTION_TEST (STDC_HEADERS)

#-----------------------------------------------------------------------------

#-----------------------------------------------------------------------------
# Check IF header file exists and add it to the list.
#-----------------------------------------------------------------------------
macro (CHECK_INCLUDE_FILE_CONCAT FILE VARIABLE)
  CHECK_INCLUDE_FILES ("${USE_INCLUDES};${FILE}" ${VARIABLE})
  if (${VARIABLE})
    set (USE_INCLUDES ${USE_INCLUDES} ${FILE})
  endif ()
endmacro ()

#-----------------------------------------------------------------------------
#  Check for the existence of certain header files
#-----------------------------------------------------------------------------
CHECK_INCLUDE_FILE_CONCAT ("sys/stat.h"      HAVE_SYS_STAT_H)
CHECK_INCLUDE_FILE_CONCAT ("sys/types.h"     HAVE_SYS_TYPES_H)
CHECK_INCLUDE_FILE_CONCAT ("stddef.h"        HAVE_STDDEF_H)
CHECK_INCLUDE_FILE_CONCAT ("stdint.h"        HAVE_STDINT_H)
CHECK_INCLUDE_FILE_CONCAT ("unistd.h"        HAVE_UNISTD_H)

# IF the c compiler found stdint, check the C++ as well. On some systems this
# file will be found by C but not C++, only do this test IF the C++ compiler
# has been initialized (e.g. the project also includes some c++)
if (HAVE_STDINT_H AND CMAKE_CXX_COMPILER_LOADED)
  CHECK_INCLUDE_FILE_CXX ("stdint.h" HAVE_STDINT_H_CXX)
  if (NOT HAVE_STDINT_H_CXX)
    set (HAVE_STDINT_H "" CACHE INTERNAL "Have includes HAVE_STDINT_H")
    set (USE_INCLUDES ${USE_INCLUDES} "stdint.h")
  endif ()
endif ()

# Windows
CHECK_INCLUDE_FILE_CONCAT ("io.h"            HAVE_IO_H)
if (NOT CYGWIN)
  CHECK_INCLUDE_FILE_CONCAT ("winsock2.h"      HAVE_WINSOCK_H)
endif ()

CHECK_INCLUDE_FILE_CONCAT ("pthread.h"       HAVE_PTHREAD_H)
CHECK_INCLUDE_FILE_CONCAT ("string.h"        HAVE_STRING_H)
CHECK_INCLUDE_FILE_CONCAT ("strings.h"       HAVE_STRINGS_H)
CHECK_INCLUDE_FILE_CONCAT ("stdlib.h"        HAVE_STDLIB_H)
CHECK_INCLUDE_FILE_CONCAT ("memory.h"        HAVE_MEMORY_H)
CHECK_INCLUDE_FILE_CONCAT ("dlfcn.h"         HAVE_DLFCN_H)
CHECK_INCLUDE_FILE_CONCAT ("fcntl.h"         HAVE_FCNTL_H)
CHECK_INCLUDE_FILE_CONCAT ("inttypes.h"      HAVE_INTTYPES_H)

#-----------------------------------------------------------------------------
#  Check for large file support
#-----------------------------------------------------------------------------

# The linux-lfs option is deprecated.
set (LINUX_LFS 0)

set (H5BZ2_EXTRA_C_FLAGS)
set (H5BZ2_EXTRA_FLAGS)
if (NOT WINDOWS)
  if (NOT HAVE_SOLARIS)
  # Linux Specific flags
  set (H5BZ2_EXTRA_C_FLAGS -D_POSIX_C_SOURCE=200112L)

  option (H5BZ2_ENABLE_LARGE_FILE "Enable support for large (64-bit) files on Linux." ON)
  if (H5BZ2_ENABLE_LARGE_FILE)
    set (msg "Performing TEST_LFS_WORKS")
    try_run (TEST_LFS_WORKS_RUN   TEST_LFS_WORKS_COMPILE
        ${CMAKE_BINARY_DIR}
        ${H5BZ2_RESOURCES_DIR}/H5PLTests.c
        CMAKE_FLAGS -DCOMPILE_DEFINITIONS:STRING=-DTEST_LFS_WORKS
        OUTPUT_VARIABLE OUTPUT
    )
    if (TEST_LFS_WORKS_COMPILE)
      if (TEST_LFS_WORKS_RUN MATCHES 0)
        set (TEST_LFS_WORKS 1 CACHE INTERNAL ${msg})
        set (LARGEFILE 1)
        set (H5BZ2_EXTRA_FLAGS ${H5BZ2_EXTRA_FLAGS} -D_FILE_OFFSET_BITS=64 -D_LARGEFILE64_SOURCE -D_LARGEFILE_SOURCE)
        message (STATUS "${msg}... yes")
      else ()
        set (TEST_LFS_WORKS "" CACHE INTERNAL ${msg})
        message (STATUS "${msg}... no")
        file (APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
              "Test TEST_LFS_WORKS Run failed with the following output and exit code:\n ${OUTPUT}\n"
        )
      endif ()
    else ()
      set (TEST_LFS_WORKS "" CACHE INTERNAL ${msg})
      message (STATUS "${msg}... no")
      file (APPEND ${CMAKE_BINARY_DIR}${CMAKE_FILES_DIRECTORY}/CMakeError.log
          "Test TEST_LFS_WORKS Compile failed with the following output:\n ${OUTPUT}\n"
      )
    endif ()
  endif ()
  set (CMAKE_REQUIRED_DEFINITIONS ${CMAKE_REQUIRED_DEFINITIONS} ${H5BZ2_EXTRA_FLAGS})
  endif ()
endif ()

add_definitions (${H5BZ2_EXTRA_FLAGS})
#-----------------------------------------------------------------------------
# Check for some functions that are used
#
CHECK_FUNCTION_EXISTS (vprintf               HAVE_VPRINTF)
CHECK_FUNCTION_EXISTS (_doprnt               HAVE_DOPRNT)
CHECK_FUNCTION_EXISTS (memset                HAVE_MEMSET)

if (NOT WINDOWS)
  foreach (test
      HAVE_ATTRIBUTE
      SYSTEM_SCOPE_THREADS
      CXX_HAVE_OFFSETOF
  )
    H5BZ2_FUNCTION_TEST (${test})
  endforeach ()
endif ()
