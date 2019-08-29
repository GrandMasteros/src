#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "connectionManager" for configuration "Release"
set_property(TARGET connectionManager APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(connectionManager PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libconnectionManager.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS connectionManager )
list(APPEND _IMPORT_CHECK_FILES_FOR_connectionManager "${_IMPORT_PREFIX}/lib/libconnectionManager.a" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
