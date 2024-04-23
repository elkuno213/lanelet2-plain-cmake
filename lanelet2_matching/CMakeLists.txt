# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(matching SHARED)
add_library(${PROJECT_NAME}::matching ALIAS matching)
target_sources(matching PRIVATE
  src/LaneletMatching.cpp
  src/Utilities.cpp
)
target_include_directories(matching
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
          $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include/lanelet2_matching>
)
target_link_libraries(matching PUBLIC
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::traffic_rules
)
target_compile_features(matching
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(matching PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN
  PREFIX        lib${PROJECT_NAME}_
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  add_executable(test_lanelet2_matching test/lanelet2_matching.cpp)
  target_include_directories(test_lanelet2_matching PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/include/lanelet2_matching
  )
  target_link_libraries(test_lanelet2_matching
    matching
    ${PROJECT_NAME}::io
    ${PROJECT_NAME}::projection
    GTest::GTest
    GTest::Main
  )
  add_test(test_lanelet2_matching test_lanelet2_matching)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              matching
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
