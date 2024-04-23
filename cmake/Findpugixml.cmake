# Hints:
# - Set pugixml_ROOT to the installation prefix of pugixml.
# Results:
# - pugixml_FOUND
# - pugixml_LIBRARIES = pugixml::pugixml
# - pugixml_INCLUDE_DIRS

find_path(
  pugixml_INCLUDE_DIRS pugixml.hpp
  HINTS "${pugixml_ROOT}/include"
        "/usr/include"
        "/usr/local/include"
  DOC   "The directory containing pugixml.hpp"
)

if(pugixml_INCLUDE_DIRS)
  find_library(pugixml_LIBRARIES
    NAMES pugixml
          libpugixml
    HINTS "${pugixml_ROOT}/lib"
          "/usr/lib"
          "/usr/local/lib"
  )
  if(pugixml_LIBRARIES)
    set(pugixml_FOUND true)
  endif()
endif()

# Support the REQUIRED and QUIET arguments, and set PUGIXML_FOUND if found.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(pugixml REQUIRED_VARS
  pugixml_LIBRARIES
  pugixml_INCLUDE_DIRS
)
mark_as_advanced(
  pugixml_INCLUDE_DIRS
  pugixml_LIBRARIES
)

if(pugixml_FOUND)
  add_library(pugixml::pugixml INTERFACE IMPORTED)
  target_link_libraries(pugixml::pugixml INTERFACE ${pugixml_LIBRARIES})
  target_include_directories(pugixml::pugixml INTERFACE ${pugixml_INCLUDE_DIRS})
endif()
