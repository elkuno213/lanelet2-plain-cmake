# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(lanelet2_routing SHARED)
target_sources(lanelet2_routing PRIVATE
  src/LaneletPath.cpp
  src/Route.cpp
  src/RouteBuilder.cpp
  src/RoutingCost.cpp
  src/RoutingGraph.cpp
  src/RoutingGraphBuilder.cpp
)
target_include_directories(lanelet2_routing
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(lanelet2_routing PUBLIC
  Boost::boost
  lanelet2_core
  lanelet2_traffic_rules
)
target_compile_features(lanelet2_routing
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(lanelet2_routing PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  # Add test sources.
  set(TESTS
    test/test_lanelet_or_area_path.cpp
    test/test_relations.cpp
    test/test_route.cpp
    test/test_routing.cpp
    test/test_routing_graph_container.cpp
    test/test_routing_visualization.cpp
  )
  # Add test targets.
  foreach(TEST ${TESTS})
    get_filename_component(TEST_NAME ${TEST} NAME_WE)
    add_executable(${TEST_NAME} ${TEST})
    target_link_libraries(${TEST_NAME}
      lanelet2_routing
      Boost::filesystem
      GTest::GTest
      GTest::Main
    )
    add_test(${TEST_NAME} ${TEST_NAME})
  endforeach()
endif()


# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              lanelet2_routing
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

install(
  DIRECTORY   res
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_routing
)

install(
  DIRECTORY   doc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_routing
)
