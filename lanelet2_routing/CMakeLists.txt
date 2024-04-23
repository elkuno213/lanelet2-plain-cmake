# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(routing SHARED)
add_library(${PROJECT_NAME}::routing ALIAS routing)
target_sources(routing PRIVATE
  src/LaneletPath.cpp
  src/Route.cpp
  src/RouteBuilder.cpp
  src/RoutingCost.cpp
  src/RoutingGraph.cpp
  src/RoutingGraphBuilder.cpp
)
target_include_directories(routing
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(routing PUBLIC
  Boost::boost
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::traffic_rules
)
target_compile_features(routing
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(routing PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN
  PREFIX        lib${PROJECT_NAME}_
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
      routing
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
  TARGETS              routing
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
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/routing
)

install(
  DIRECTORY   doc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/routing
)
