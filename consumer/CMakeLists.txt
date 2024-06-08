# ──────────────────────────────────────────────────────────────────────────── #
# Project configuration #

cmake_minimum_required(VERSION 3.15 FATAL_ERROR)
project(consumer VERSION 1.2.1 LANGUAGES CXX)

include(GNUInstallDirs)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

if(NOT CMAKE_BUILD_TYPE)
  message(STATUS "No build type selected, default to Release")
  set(CMAKE_BUILD_TYPE Release)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Find packages #

find_package(lanelet2 1.2.1 CONFIG REQUIRED COMPONENTS
  core
  io
  projection
  traffic_rules
  routing
  validation
  matching
)

# ──────────────────────────────────────────────────────────────────────────── #
# Targets #

add_executable(consumer main.cpp)
target_link_libraries(consumer PRIVATE
  lanelet2::core
  lanelet2::io
  lanelet2::projection
  lanelet2::traffic_rules
  lanelet2::routing
  lanelet2::validation
  lanelet2::matching
)
target_compile_definitions(consumer PRIVATE
  SHARE_DIR="${lanelet2_DIR}/../.."
)
