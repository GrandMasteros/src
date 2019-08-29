#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "i2c" for configuration "Release"
set_property(TARGET i2c APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(i2c PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libi2c.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS i2c )
list(APPEND _IMPORT_CHECK_FILES_FOR_i2c "${_IMPORT_PREFIX}/lib/libi2c.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
