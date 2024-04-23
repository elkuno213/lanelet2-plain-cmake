import os
from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMakeDeps, CMake, cmake_layout
from conan.tools.build import can_run, check_max_cppstd, check_min_cppstd


class Lanelet2Conan(ConanFile):
  name = 'lanelet2'
  version = '1.2.1'

  # Optional metadata
  license = 'BSD'
  url = 'https://github.com/fzi-forschungszentrum-informatik/lanelet2'
  description = 'Map handling framework for automated driving'

  # Binary configuration
  settings = 'os', 'compiler', 'build_type', 'arch'

  options = {
    'shared': [True, False],
    'fPIC': [True, False],
    'with_tests': [True, False],
  }

  default_options = {
    'shared': True,
    'fPIC': True,
    'boost/*:shared': True,
    'with_tests': False,
  }

  # Sources are located in the same place as this recipe, copy them to the recipe
  exports_sources = 'CMakeLists.txt', 'lanelet2_*/*', 'cmake/*'

  project_list = [
    'lanelet2_core'
    'lanelet2_io'
    'lanelet2_projection'
    'lanelet2_traffic_rules'
    'lanelet2_routing'
    'lanelet2_validation'
    'lanelet2_maps'
    'lanelet2_matching'
  ]

  def config_options(self):
    if self.settings.os == 'Windows':
      del self.options.fPIC

  def configure(self):
    if self.options.shared:
      # If os=Windows, fPIC will have been removed in config_options()
      # use rm_safe to avoid double delete errors
      self.options.rm_safe('fPIC')

  def layout(self):
    self.folders.source = "."
    self.folders.build = "build"
    self.folders.generators = os.path.join(self.folders.build, "conan")
    self.folders.imports = os.path.join(self.folders.generators, "imports")

  def validate(self):
    if self.settings.compiler.cppstd:
      check_min_cppstd(self, '17')

  def requirements(self):
    self.requires('boost/[>=1.75.0 <=1.81.0]')
    self.requires('eigen/3.4.0')
    self.requires('geographiclib/1.52')
    self.requires('pugixml/1.13')
    self.test_requires('gtest/1.14.0')

  def generate(self):
    deps = CMakeDeps(self)
    deps.generate()

    tc = CMakeToolchain(self, generator='Ninja')
    if self.options.with_tests:
      tc.variables['WITH_TESTS'] = True
    tc.generate()

  def build(self):
    cmake = CMake(self)
    cmake.configure()
    cmake.build()
    if self.options.with_tests:
      cmake.test()

  def package(self):
    cmake = CMake(self)
    cmake.install()

  def package_info(self):
    self.cpp_info.libs = list(reversed(self.project_list))
    libpath = os.path.join(self.package_folder, 'lib')
    boost_libpaths = self.dependencies['boost'].cpp_info.libs
    execs = ('lanelet2_validator')
    binpaths = [os.path.join(self.package_folder, 'bin', exec) for exec in execs]
    self.env_info.LD_LIBRARY_PATH += [libpath] + boost_libpaths
    self.env_info.DYLD_LIBRARY_PATH += [libpath] + boost_libpaths
    self.env_info.PATH += binpaths
