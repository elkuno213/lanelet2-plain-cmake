# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(validation SHARED)
add_library(${PROJECT_NAME}::validation ALIAS validation)
target_sources(validation PRIVATE
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
target_include_directories(validation
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(validation PUBLIC
  Boost::boost
  Boost::program_options
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::io
  ${PROJECT_NAME}::routing
  ${PROJECT_NAME}::projection
  ${PROJECT_NAME}::traffic_rules
)
target_compile_features(validation
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(validation PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN
  PREFIX        lib${PROJECT_NAME}_
)

add_executable(validator
  tools/lanelet2_validate/main.cpp
)
target_link_libraries(validator validation)
set_target_properties(validator PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN/../lib
  PREFIX        ${PROJECT_NAME}_
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  add_executable(test_lanelet2_validation test/lanelet2_validation.cpp)
  target_link_libraries(test_lanelet2_validation
    validation
    GTest::GTest
    GTest::Main
  )
  add_test(test_lanelet2_validation test_lanelet2_validation)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              validation
                       validator
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
