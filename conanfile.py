from conans import ConanFile, CMake


class MypkgConan(ConanFile):
    name = "myPkg"
    version = "1.0"
    license = "<Put the package license here>"
    author = "<Put your name here> <And your email here>"
    url = "<Package recipe repository url here, for issues about the package>"
    description = "<Description of Mypkg here>"
    topics = ("<Put some tag here>", "<here>", "<and here>")
    settings = "os", "compiler", "build_type", "arch"
    options = {"shared": [True, False]}
    default_options = "shared=False"
    generators = "cmake"
    exports_sources = "src/*"
    requires = "gtest/1.8.1@bincrafters/stable"


    def cmake_configure(self):
        cmake = CMake(self)
        cmake.configure(source_folder="src")
        return cmake

    def build(self):
        cmake = self.cmake_configure()
        cmake.build()

    def package(self):
        cmake = self.cmake_configure()
        cmake.install()

