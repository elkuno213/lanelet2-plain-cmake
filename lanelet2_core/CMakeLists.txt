# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

# TODO: add sources of python api.

add_library(lanelet2_core SHARED)
target_sources(lanelet2_core PRIVATE
  src/Attribute.cpp
  src/BasicRegulatoryElements.cpp
  src/Lanelet.cpp
  src/LaneletMap.cpp
  src/LaneletSequence.cpp
  src/LineStringGeometry.cpp
  src/PolygonTriangulationGeometry.cpp
  src/RegulatoryElement.cpp
  src/RegulatoryElementGeometry.cpp
)
target_include_directories(lanelet2_core
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(lanelet2_core PUBLIC
  Boost::boost
  Eigen3::Eigen
)
target_compile_features(lanelet2_core
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(lanelet2_core PROPERTIES
  VERSION ${CMAKE_PROJECT_VERSION}
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  # Add test sources.
  set(TESTS
    test/test_area.cpp
    test/test_attribute.cpp
    test/test_lanelet.cpp
    test/test_lanelet_map.cpp
    test/test_lanelet_map_geometry.cpp
    test/test_lanelet_or_area.cpp
    test/test_lanelet_sequence.cpp
    test/test_linestring.cpp
    test/test_point.cpp
    test/test_polygon.cpp
    test/test_regulatory_element.cpp
  )
  # Add test targets.
  foreach(TEST ${TESTS})
    get_filename_component(TEST_NAME ${TEST} NAME_WE)
    add_executable(${TEST_NAME} ${TEST})
    target_include_directories(${TEST_NAME} PRIVATE
      ${CMAKE_CURRENT_SOURCE_DIR}/include/lanelet2_core
    )
    target_link_libraries(${TEST_NAME}
      lanelet2_core
      GTest::GTest
      GTest::Main
    )
    add_test(${TEST_NAME} ${TEST_NAME})
  endforeach()
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              lanelet2_core
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
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_core
)

install(
  DIRECTORY   doc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_core
)
