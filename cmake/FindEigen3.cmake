# Hints:
# - set Eigen3_ROOT to the installation prefix of Eigen3.
# - append the installation prefix of Eigen3 to CMAKE_PREFIX_PATH.
# Results:
# - Eigen3_FOUND
# - Eigen3::Eigen
# - Eigen3_INCLUDE_DIRS
# - Eigen3_VERSION

list(APPEND hints_list
  "${CMAKE_INSTALL_PREFIX}/include/eigen3"
  "/usr/include/eigen3"
  "/usr/local/include/eigen3"
)
if(Eigen3_ROOT)
  list(APPEND hints_list "${Eigen3_ROOT}/include/eigen3")
endif()
foreach(path IN LISTS ${CMAKE_PREFIX_PATH})
  list(APPEND hints_list "${path}/include/eigen3")
endforeach()

find_path(Eigen3_INCLUDE_DIR
  NAMES         signature_of_eigen3_matrix_library
  PATH_SUFFIXES eigen3 eigen
  HINTS         ${hints_list}
  DOC           "The include directory of the Eigen3 library"
)
mark_as_advanced(Eigen3_INCLUDE_DIR)

if(Eigen3_INCLUDE_DIR)
  file(
    STRINGS "${Eigen3_INCLUDE_DIR}/Eigen/src/Core/util/Macros.h" _Eigen3_version_lines
    REGEX   "#define[ \t]+EIGEN_(WORLD|MAJOR|MINOR)_VERSION"
  )
  string(REGEX REPLACE ".*EIGEN_WORLD_VERSION *\([0-9]*\).*" "\\1" _Eigen3_version_world "${_Eigen3_version_lines}")
  string(REGEX REPLACE ".*EIGEN_MAJOR_VERSION *\([0-9]*\).*" "\\1" _Eigen3_version_major "${_Eigen3_version_lines}")
  string(REGEX REPLACE ".*EIGEN_MINOR_VERSION *\([0-9]*\).*" "\\1" _Eigen3_version_minor "${_Eigen3_version_lines}")
  set(Eigen3_VERSION "${_Eigen3_version_world}.${_Eigen3_version_major}.${_Eigen3_version_minor}")
  unset(_Eigen3_version_world)
  unset(_Eigen3_version_major)
  unset(_Eigen3_version_minor)
  unset(_Eigen3_version_lines)
endif()

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(Eigen3
  REQUIRED_VARS Eigen3_INCLUDE_DIR
  VERSION_VAR   Eigen3_VERSION
)

if(Eigen3_FOUND)
  set(Eigen3_INCLUDE_DIRS "${Eigen3_INCLUDE_DIR}")

  if(NOT TARGET Eigen3::Eigen)
    add_library(Eigen3::Eigen INTERFACE IMPORTED)
    set_target_properties(Eigen3::Eigen PROPERTIES
      INTERFACE_INCLUDE_DIRECTORIES "${Eigen3_INCLUDE_DIR}"
    )
  endif()
endif()
