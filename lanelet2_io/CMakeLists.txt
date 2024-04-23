# ──────────────────────────────────────────────────────────────────────────── #
# Add targets #

add_library(io SHARED)
add_library(${PROJECT_NAME}::io ALIAS io)
target_sources(io PRIVATE
  src/BinHandler.cpp
  src/Factory.cpp
  src/Io.cpp
  src/OsmFile.cpp
  src/OsmHandlerLoad.cpp
  src/OsmHandlerWrite.cpp
)
target_include_directories(io
  PUBLIC  $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}/include>
          $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>
  PRIVATE src
)
target_link_libraries(io PUBLIC
  pugixml::pugixml
  Boost::boost
  Boost::filesystem
  Boost::serialization
  ${PROJECT_NAME}::core
)
target_compile_features(io
  PUBLIC  cxx_auto_type
  PRIVATE cxx_variadic_templates
)
set_target_properties(io PROPERTIES
  VERSION       ${CMAKE_PROJECT_VERSION}
  INSTALL_RPATH $ORIGIN
  PREFIX        lib${PROJECT_NAME}_
)

# ──────────────────────────────────────────────────────────────────────────── #
# Add tests #

if (WITH_TESTS)
  # Add test sources.
  set(TESTS
    test/TestBinHandler.cpp
    test/TestLanelet2Io.cpp
    test/TestOsmFile.cpp
    test/TestOsmHandler.cpp
    test/TestSimpleUsage.cpp
  )
  # Add test targets.
  foreach(TEST ${TESTS})
    get_filename_component(TEST_NAME ${TEST} NAME_WE)
    add_executable(${TEST_NAME} ${TEST})
    target_link_libraries(${TEST_NAME}
      io
      GTest::GTest
      GTest::Main
    )
    add_test(${TEST_NAME} ${TEST_NAME})
  endforeach()
endif()

# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  TARGETS              io
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
