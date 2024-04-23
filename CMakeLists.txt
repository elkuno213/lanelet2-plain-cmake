# ──────────────────────────────────────────────────────────────────────────── #
# Project configuration #

cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(lanelet2 VERSION 1.2.1 LANGUAGES CXX)

include(GNUInstallDirs)

option(WITH_TESTS "Enable building and testing tests" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if (NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE Release)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Find packages #

list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake/")

find_package(Boost REQUIRED serialization filesystem program_options)
find_package(Eigen3 REQUIRED)
find_package(pugixml REQUIRED)
find_package(geographiclib REQUIRED)

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

# Write version file.
include(CMakePackageConfigHelpers)
write_basic_package_version_file(${PROJECT_NAME}ConfigVersion.cmake
  VERSION       ${CMAKE_PROJECT_VERSION}
  COMPATIBILITY SameMajorVersion
)

# Configure config file.
configure_file(
  ${CMAKE_CURRENT_SOURCE_DIR}/cmake/config.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
  @ONLY
)

# Install config files.
install(
  FILES       ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake
              ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}ConfigVersion.cmake
  DESTINATION share/${PROJECT_NAME}/cmake
)
install(
  DIRECTORY      ${CMAKE_CURRENT_SOURCE_DIR}/cmake/
  DESTINATION    share/${PROJECT_NAME}/cmake/modules
  FILES_MATCHING PATTERN "*.cmake"
)

# Install targets file.
install(
  EXPORT      ${PROJECT_NAME}Targets
  NAMESPACE   ${PROJECT_NAME}::
  DESTINATION share/${PROJECT_NAME}/cmake
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add subdirectories #

if (WITH_TESTS)
  enable_testing()
  find_package(GTest REQUIRED)
endif()

add_subdirectory(lanelet2_core)
add_subdirectory(lanelet2_io)
add_subdirectory(lanelet2_projection)
add_subdirectory(lanelet2_traffic_rules)
add_subdirectory(lanelet2_routing)
add_subdirectory(lanelet2_validation)
add_subdirectory(lanelet2_maps)
add_subdirectory(lanelet2_matching)
# TODO: Add python bindings using FindPythonLibs and Boost::python
# add_subdirectory(lanelet2_python)
# TODO: Add lanelet2_examples
# add_subdirectory(lanelet2_examples)
