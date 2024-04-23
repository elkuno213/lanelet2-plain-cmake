# Hints:
# - Set geographiclib_ROOT to the installation prefix of geographiclib.
# Results:
# - geographiclib_FOUND
# - geographiclib_LIBRARIES = GeographicLib::GeographicLib
# - geographiclib_INCLUDE_DIRS
# - geographiclib_LIBRARY_DIRS

find_library(geographiclib_LIBRARIES Geographic
  HINTS "${geographiclib_ROOT}/lib"
        "/usr/lib"
        "/usr/local/lib"
  DOC   "The GeographicLib library"
)

if(geographiclib_LIBRARIES)
  get_filename_component(geographiclib_LIBRARY_DIRS
    "${geographiclib_LIBRARIES}" PATH
  )
  get_filename_component(_ROOT_DIR "${geographiclib_LIBRARY_DIRS}" PATH)
  set(geographiclib_INCLUDE_DIRS "${_ROOT_DIR}/include")
  set(geographiclib_BINARY_DIRS "${_ROOT_DIR}/bin")
  if(NOT EXISTS "${geographiclib_INCLUDE_DIRS}/GeographicLib/Config.h")
    get_filename_component(_ROOT_DIR "${_ROOT_DIR}" PATH)                    # Added to script
    set(geographiclib_INCLUDE_DIRS "${_ROOT_DIR}/include")                   # Added to script
    set(geographiclib_BINARY_DIRS "${_ROOT_DIR}/bin")                        # Added to script
    if(NOT EXISTS "${geographiclib_INCLUDE_DIRS}/GeographicLib/Config.h")    # Added to script
      unset(geographiclib_INCLUDE_DIRS)
      unset(geographiclib_LIBRARIES)
      unset(geographiclib_LIBRARY_DIRS)
      unset(geographiclib_BINARY_DIRS)
    endif()                                                                  # Added to script
  endif()
  unset(_ROOT_DIR)                                                           # Moved below if() statements
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(geographiclib DEFAULT_MSG
  geographiclib_LIBRARY_DIRS
  geographiclib_LIBRARIES
  geographiclib_INCLUDE_DIRS
)
mark_as_advanced(
  geographiclib_LIBRARY_DIRS
  geographiclib_LIBRARIES
  geographiclib_INCLUDE_DIRS
)

if(geographiclib_FOUND)
  add_library(GeographicLib::GeographicLib INTERFACE IMPORTED)
  target_link_libraries(GeographicLib::GeographicLib INTERFACE ${geographiclib_LIBRARIES})
  target_include_directories(GeographicLib::GeographicLib INTERFACE ${geographiclib_INCLUDE_DIRS})
endif()
