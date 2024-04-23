# ──────────────────────────────────────────────────────────────────────────── #
# Installation #

install(
  DIRECTORY   res
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_maps
)

install(
  DIRECTORY   josm
  DESTINATION ${CMAKE_INSTALL_DATADIR}/${PROJECT_NAME}/lanelet2_maps
)
