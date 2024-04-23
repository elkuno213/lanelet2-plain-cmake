# Hints:
# - Set pugixml_ROOT to the installation prefix of pugixml.
# - append the installation prefix of pugixml to CMAKE_PREFIX_PATH.
# Results:
# - pugixml_FOUND
# - pugixml_LIBRARIES = pugixml::pugixml
# - pugixml_INCLUDE_DIRS

list(APPEND hints_list
  "${CMAKE_INSTALL_PREFIX}/include"
  "/usr/include"
  "/usr/local/include"
)
if(pugixml_ROOT)
  list(APPEND hints_list "${pugixml_ROOT}/include")
endif()
foreach(path IN LISTS ${CMAKE_PREFIX_PATH})
  list(APPEND hints_list "${path}/include")
endforeach()

find_path(pugixml_INCLUDE_DIRS pugixml.hpp
  HINTS ${hints_list}
  DOC   "The directory containing pugixml.hpp"
)

if(pugixml_INCLUDE_DIRS)
  find_library(pugixml_LIBRARIES
    NAMES pugixml
          libpugixml
    HINTS "${pugixml_INCLUDE_DIRS}/../lib"
  )
endif()

# Support the REQUIRED and QUIET arguments, and set pugixml_FOUND if found.
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(pugixml REQUIRED_VARS
  pugixml_INCLUDE_DIRS
  pugixml_LIBRARIES
)
mark_as_advanced(
  pugixml_INCLUDE_DIRS
  pugixml_LIBRARIES
)

# Add pugixml::pugixml target
if(pugixml_FOUND)
  add_library(pugixml::pugixml INTERFACE IMPORTED)
  target_link_libraries     (pugixml::pugixml INTERFACE ${pugixml_LIBRARIES}   )
  target_include_directories(pugixml::pugixml INTERFACE ${pugixml_INCLUDE_DIRS})
endif()
