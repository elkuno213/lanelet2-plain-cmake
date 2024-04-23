# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(lanelet2_validation SHARED)
target_sources(lanelet2_validation PRIVATE
  src/validators/CheckTags.cpp
  src/validators/CurvatureTooBig.cpp
  src/validators/DuplicatedPoints.cpp
  src/validators/PointsTooClose.cpp
  src/validators/RoutingGraphIsValid.cpp
  src/BasicValidator.cpp
  src/Cli.cpp
  src/Validation.cpp
  src/ValidatorFactory.cpp
)
target_include_directories(lanelet2_validation
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(lanelet2_validation PUBLIC
  Boost::boost
  Boost::program_options
  lanelet2_core
  lanelet2_io
  lanelet2_routing
  lanelet2_projection
  lanelet2_traffic_rules
)
target_compile_features(lanelet2_validation
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(lanelet2_validation PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
)

add_executable(lanelet2_validator
  tools/lanelet2_validate/main.cpp
)
target_link_libraries(lanelet2_validator lanelet2_validation)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  add_executable(test_lanelet2_validation test/lanelet2_validation.cpp)
  target_link_libraries(test_lanelet2_validation
    lanelet2_validation
    GTest::GTest
    GTest::Main
  )
  add_test(test_lanelet2_validation test_lanelet2_validation)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              lanelet2_validation
                       lanelet2_validator
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
