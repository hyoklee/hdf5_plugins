cmake_minimum_required (VERSION 3.12)
project (H5CV_SRC C)

#-----------------------------------------------------------------------------
# Apply Definitions to compiler in this directory and below
#-----------------------------------------------------------------------------
add_definitions (${HDF5_EXTRA_C_FLAGS})

#-----------------------------------------------------------------------------
# Setup include Directories
#-----------------------------------------------------------------------------
set(H5CV_INCLUDE_DIRS ${H5CV_INCLUDE_DIRS}
    ${HDF5_INCLUDE_DIR} ${H5CV_BINARY_DIR}
    ${H5CV_SRC_SOURCE_DIR}
    ${CV_INCLUDE_DIRS}
)

#-----------------------------------------------------------------------------
# Define H5CV Library
#-----------------------------------------------------------------------------
set (H5CV_SRCS
    ${H5CV_SRC_SOURCE_DIR}/H5VLpassthru_ext.c
)

add_library (${H5CV_LIB_TARGET} MODULE ${H5CV_SRCS})
if (DISABLE_H5CV_ENCODER)
  set_target_properties(${H5CV_LIB_TARGET} PROPERTIES COMPILE_DEFINITIONS "FILTER_DECODE_ONLY")
endif ()
target_include_directories(${H5CV_LIB_TARGET} PRIVATE ${H5CV_INCLUDE_DIRS})
target_link_libraries (${H5CV_LIB_TARGET} PRIVATE ${LINK_LIBS})
set_global_variable (H5CV_LIBRARIES_TO_EXPORT ${H5CV_LIB_TARGET})
HDF_SET_LIB_VERSIONS ("H5CV" ${H5CV_LIB_TARGET} ${H5CV_LIB_NAME} MODULE)

if (BUILD_TESTING)
  #-----------------------------------------------------------------------------
  # Copy plugin library to a plugins folder
  #-----------------------------------------------------------------------------

  # make plugins dir
  file (MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/plugins")
  add_custom_command (
      TARGET     ${H5CV_LIB_TARGET}
      POST_BUILD
      COMMAND    ${CMAKE_COMMAND}
      ARGS       -E copy_if_different
        "$<TARGET_FILE:${H5CV_LIB_TARGET}>"
        "${CMAKE_BINARY_DIR}/plugins/$<TARGET_FILE_NAME:${H5CV_LIB_TARGET}>"
  )
endif ()

#-----------------------------------------------------------------------------
# Add Target(s) to CMake Install for import into other projects
#-----------------------------------------------------------------------------
if (H5CV_EXPORTED_TARGETS)
  install (
      TARGETS
          ${H5CV_LIB_TARGET}
      EXPORT
          ${H5CV_EXPORTED_TARGETS}
      LIBRARY DESTINATION ${H5CV_INSTALL_LIB_DIR} COMPONENT libraries
      ARCHIVE DESTINATION ${H5CV_INSTALL_LIB_DIR} COMPONENT libraries
      RUNTIME DESTINATION ${H5CV_INSTALL_BIN_DIR} COMPONENT libraries
  )
endif ()
