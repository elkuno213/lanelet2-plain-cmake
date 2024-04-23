# Add res/ and josm/ folders into build directory
file(COPY res DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
  PATTERN ".gitignore" EXCLUDE
)
file(COPY josm DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
  PATTERN ".gitignore" EXCLUDE
)

# Install into install directory
install(
  DIRECTORY   res
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/maps
)

install(
  DIRECTORY   josm
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/maps
)
