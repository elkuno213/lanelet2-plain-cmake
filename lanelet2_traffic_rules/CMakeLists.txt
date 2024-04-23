# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(lanelet2_traffic_rules SHARED)
target_sources(lanelet2_traffic_rules PRIVATE
  src/GermanTrafficRules.cpp
  src/GenericTrafficRules.cpp
  src/TrafficRulesFactory.cpp
)
target_include_directories(lanelet2_traffic_rules
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(lanelet2_traffic_rules PUBLIC
  lanelet2_core
)
target_compile_features(lanelet2_traffic_rules
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(lanelet2_traffic_rules PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  add_executable(test_lanelet2_traffic_rules test/lanelet2_traffic_rules.cpp)
  target_link_libraries(test_lanelet2_traffic_rules
    lanelet2_traffic_rules
    GTest::GTest
    GTest::Main
  )
  add_test(test_lanelet2_traffic_rules test_lanelet2_traffic_rules)
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              lanelet2_traffic_rules
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
