# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(projection SHARED)
add_library(${PROJECT_NAME}::projection ALIAS projection)
target_sources(projection PRIVATE
  src/CPM.cpp
  src/Geocentric.cpp
  src/LocalCartesian.cpp
  src/UTM.cpp
)
target_compile_features(projection
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
target_link_libraries(projection PUBLIC
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::io
  GeographicLib::GeographicLib
)
target_include_directories(projection
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
set_target_properties(projection PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN
  PREFIX        lib${PROJECT_NAME}_
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  # Add test sources.
  set(TESTS
    test/test_Geocentric.cpp
    test/test_LocalCartesian.cpp
    test/test_Mercator.cpp
    test/test_UTM.cpp
  )
  # Add test targets.
  foreach(TEST ${TESTS})
    get_filename_component(TEST_NAME ${TEST} NAME_WE)
    add_executable(${TEST_NAME} ${TEST})
    target_link_libraries(${TEST_NAME}
      projection
      GTest::GTest
      GTest::Main
    )
    add_test(${TEST_NAME} ${TEST_NAME})
  endforeach()
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              projection
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
  DIRECTORY   doc
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/projection
)
