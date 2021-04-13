cmake_minimum_required (VERSION 3.12)
project (H5AV_SRC C)

#-----------------------------------------------------------------------------
# Apply Definitions to compiler in this directory and below
#-----------------------------------------------------------------------------
add_definitions (${HDF5_EXTRA_C_FLAGS})

#-----------------------------------------------------------------------------
# Setup include Directories
#-----------------------------------------------------------------------------
set(H5AV_INCLUDE_DIRS ${H5AV_INCLUDE_DIRS}
    ${HDF5_INCLUDE_DIR} ${H5AV_BINARY_DIR}
    ${H5AV_SRC_SOURCE_DIR}
    ${AV_INCLUDE_DIRS}
)

#-----------------------------------------------------------------------------
# Define H5AV Library
#-----------------------------------------------------------------------------
set (H5AV_SRCS
    ${H5AV_SRC_SOURCE_DIR}/h5_vol_external_async_native.c
    ${H5AV_SRC_SOURCE_DIR}/h5_async_lib.c
)

add_library (${H5AV_LIB_TARGET} MODULE ${H5AV_SRCS})
if (DISABLE_H5AV_ENCODER)
  set_target_properties(${H5AV_LIB_TARGET} PROPERTIES COMPILE_DEFINITIONS "FILTER_DECODE_ONLY")
endif ()
target_include_directories(${H5AV_LIB_TARGET} PRIVATE ${H5AV_INCLUDE_DIRS})
target_link_libraries (${H5AV_LIB_TARGET} PRIVATE ${LINK_LIBS} abt)
set_global_variable (H5AV_LIBRARIES_TO_EXPORT ${H5AV_LIB_TARGET})
HDF_SET_LIB_VERSIONS ("H5AV" ${H5AV_LIB_TARGET} ${H5AV_LIB_NAME} MODULE)

if (BUILD_TESTING)
  #-----------------------------------------------------------------------------
  # Copy plugin library to a plugins folder
  #-----------------------------------------------------------------------------

  # make plugins dir
  file (MAKE_DIRECTORY "${CMAKE_BINARY_DIR}/plugins")
  add_custom_command (
      TARGET     ${H5AV_LIB_TARGET}
      POST_BUILD
      COMMAND    ${CMAKE_COMMAND}
      ARGS       -E copy_if_different
        "$<TARGET_FILE:${H5AV_LIB_TARGET}>"
        "${CMAKE_BINARY_DIR}/plugins/$<TARGET_FILE_NAME:${H5AV_LIB_TARGET}>"
  )
endif ()

#-----------------------------------------------------------------------------
# Add Target(s) to CMake Install for import into other projects
#-----------------------------------------------------------------------------
if (H5AV_EXPORTED_TARGETS)
  install (
      TARGETS
          ${H5AV_LIB_TARGET}
      EXPORT
          ${H5AV_EXPORTED_TARGETS}
      LIBRARY DESTINATION ${H5AV_INSTALL_LIB_DIR} COMPONENT libraries
      ARCHIVE DESTINATION ${H5AV_INSTALL_LIB_DIR} COMPONENT libraries
      RUNTIME DESTINATION ${H5AV_INSTALL_BIN_DIR} COMPONENT libraries
  )
endif ()
