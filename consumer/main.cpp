// A consumer binary to test the linkage to lanelet2 libraries.

#include <string>

#include <lanelet2_core/LaneletMap.h>
#include <lanelet2_core/primitives/Point.h>
#include <lanelet2_io/Io.h>
#include <lanelet2_projection/UTM.h>

std::string exampleMapPath
  = std::string(SHARE_DIR) + "/lanelet2/maps/res/mapping_example.osm";

int main() {
  lanelet::Point3d point{lanelet::utils::getId(), 1.0, 2.0, 3.0};

  lanelet::projection::UtmProjector projector(lanelet::Origin({49, 8.4}));  // we will go into details later
  lanelet::ErrorMessages errors;
  lanelet::LaneletMapPtr map = load(exampleMapPath, projector, &errors);
  assert(errors.empty());  // of no errors occurred, the map could be fully parsed.

  return 0;
}
