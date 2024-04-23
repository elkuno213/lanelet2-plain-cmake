# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(lanelet2_matching SHARED)
target_sources(lanelet2_matching PRIVATE
  src/LaneletMatching.cpp
  src/Utilities.cpp
)
target_include_directories(lanelet2_matching
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/lanelet2_matching>
)
target_link_libraries(lanelet2_matching PUBLIC
  lanelet2_core
  lanelet2_traffic_rules
)
target_compile_features(lanelet2_matching
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(lanelet2_matching PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  add_executable(test_lanelet2_matching test/lanelet2_matching.cpp)
  target_include_directories(test_lanelet2_matching PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include/lanelet2_matching
  )
  target_link_libraries(test_lanelet2_matching
    lanelet2_matching
    lanelet2_io
    lanelet2_projection
    GTest::GTest
    GTest::Main
  )
  add_test(test_lanelet2_matching test_lanelet2_matching)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              lanelet2_matching
  EXPORT               ${PROJECT_NAME}Targets
  ARCHIVE  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  LIBRARY  DESTINATION ${CMAKE_INSTALL_LIBDIR}
  RUNTIME  DESTINATION ${CMAKE_INSTALL_BINDIR}
  INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
  DIRECTORY   include/
  DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)
