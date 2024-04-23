# ──────────────────────────────────────────────────────────────────────────── #
# Add examples #

add_executable(lanelet_primitives_example
  src/01_dealing_with_lanelet_primitives/main.cpp
)
target_include_directories(lanelet_primitives_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(lanelet_primitives_example PUBLIC
  ${PROJECT_NAME}::core
)

add_executable(regulatory_elements_example
  src/02_regulatory_elements/main.cpp
)
target_include_directories(regulatory_elements_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(regulatory_elements_example PUBLIC
  ${PROJECT_NAME}::core
)

add_executable(lanelet_map_example
  src/03_lanelet_map/main.cpp
)
target_include_directories(lanelet_map_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(lanelet_map_example PUBLIC
  ${PROJECT_NAME}::core
)

add_executable(reading_and_writing_example
  src/04_reading_and_writing/main.cpp
)
target_include_directories(reading_and_writing_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(reading_and_writing_example PUBLIC
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::io
  ${PROJECT_NAME}::projection
)
target_compile_definitions(reading_and_writing_example PRIVATE
  PKG_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)

add_executable(traffic_rules_example
  src/05_traffic_rules/main.cpp
)
target_include_directories(traffic_rules_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(traffic_rules_example PUBLIC
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::traffic_rules
)

add_executable(routing_example
  src/06_routing/main.cpp
)
target_include_directories(routing_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(routing_example PUBLIC
  ${PROJECT_NAME}::core
  ${PROJECT_NAME}::io
  ${PROJECT_NAME}::projection
  ${PROJECT_NAME}::routing
  ${PROJECT_NAME}::traffic_rules
)
target_compile_definitions(routing_example PRIVATE
  PKG_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)

add_executable(matching_example
  src/07_matching/main.cpp
)
target_include_directories(matching_example PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}/include
)
target_link_libraries(matching_example PUBLIC
  ${PROJECT_NAME}::io
  ${PROJECT_NAME}::projection
  ${PROJECT_NAME}::traffic_rules
  ${PROJECT_NAME}::matching
)
target_compile_definitions(matching_example PRIVATE
  PKG_DIR="${CMAKE_CURRENT_BINARY_DIR}"
)
