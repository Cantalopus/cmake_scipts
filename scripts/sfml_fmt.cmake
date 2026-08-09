cmake_minimum_required(VERSION 3.28.0)
message("Generate SFML and fmt project template...")
file(WRITE CMakeLists.txt
[==[cmake_minimum_required(VERSION 3.28)

set(
    CMAKE_TOOLCHAIN_FILE 
    "$ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake" 
    CACHE FILEPATH 
    "Vcpkg toolchain file"
)
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

project(
            rocket

                VERSION 1.0.0
                LANGUAGES CXX
)

set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_SCAN_FOR_MODULES ON)

find_package(fmt CONFIG REQUIRED)
find_package(SFML 3 COMPONENTS System Window Graphics CONFIG REQUIRED)

add_executable(
                bin 
                    
                    main.cpp
)

        target_sources(
            bin
                PUBLIC
                FILE_SET CXX_MODULES 
                FILES 
                    utilities.ixx
        )

        target_link_libraries(
            bin
                PRIVATE
                fmt::fmt
                SFML::Graphics
                SFML::Window
                SFML::System
        )
]==])

file(WRITE CMakePresets.json
[==[{
  "version": 3,
  "configurePresets": [
    {
      "name": "base",
      "hidden": true,
      "generator": "Ninja Multi-Config",
      "binaryDir": "${sourceDir}/build/${presetName}",
      "installDir": "${sourceDir}/install/${presetName}",
      "architecture": {
        "value": "x64",
        "strategy": "external"
      },
      "cacheVariables": {
        "CMAKE_EXPORT_COMPILE_COMMANDS": "ON",
        "CMAKE_COLOR_DIAGNOSTICS": "ON"
      }
    },
    {
      "name": "release",
      "hidden": true,
      "generator": "Ninja",
      "binaryDir": "${sourceDir}/build/release",
      "installDir": "${sourceDir}/install/release",
      "architecture": {
        "value": "x64",
        "strategy": "external"
      },
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Release",
        "CMAKE_COMPILE_WARNING_AS_ERROR": "ON",
        "ES_USE_SYSTEM_LIBRARIES": "OFF",
        "BUILD_TESTING": "OFF"
      },
      "condition": {
        "type": "equals",
        "lhs": "$env{CI}",
        "rhs": "true"
      }
    },
    {
      "name": "linux-gcc",
      "displayName": "Linux GCC",
      "description": "Builds with the default host compiler on Linux",
      "inherits": "base",
      "cacheVariables": {
        "VCPKG_TARGET_TRIPLET": "x64-linux-dynamic",
        "CMAKE_CXX_COMPILER": "g++"
      },
      "condition": {
        "type": "equals",
        "lhs": "${hostSystemName}",
        "rhs": "Linux"
      }
    },
    {
      "name": "macos",
      "displayName": "MacOS",
      "description": "Builds with the default host compiler on x64-based MacOS",
      "inherits": "base",
      "cacheVariables": {
        "CMAKE_OSX_ARCHITECTURES": "x86_64",
        "VCPKG_TARGET_TRIPLET": "x64-osx-dynamic"
      },
      "condition": {
        "type": "equals",
        "lhs": "${hostSystemName}",
        "rhs": "Darwin"
      }
    },
    {
      "name": "macos-arm",
      "displayName": "MacOS ARM",
      "description": "Builds with the default host compiler on ARM-based MacOS",
      "inherits": "base",
      "cacheVariables": {
        "CMAKE_OSX_ARCHITECTURES": "arm64",
        "VCPKG_TARGET_TRIPLET": "arm64-osx-dynamic"
      },
      "architecture": {
        "value": "arm64",
        "strategy": "external"
      },
      "condition": {
        "type": "equals",
        "lhs": "${hostSystemName}",
        "rhs": "Darwin"
      }
    },
    {
      "name": "cl",
      "displayName": "Windows cl",
      "description": "Builds with Visual C++ on Windows",
      "inherits": "base",
      "toolset": {
        "value": "host=x64",
        "strategy": "external"
      },
      "cacheVariables": {
        "VCPKG_TARGET_TRIPLET": "x64-windows",
        "CMAKE_CXX_COMPILER": "cl.exe"
      },
      "condition": {
        "type": "equals",
        "lhs": "${hostSystemName}",
        "rhs": "Windows"
      }
    },
    {
      "name": "linux-release",
      "displayName": "Linux Release",
      "description": "Builds for Linux like an official release",
      "inherits": "release",
      "cacheVariables": {
        "CMAKE_CXX_COMPILER_LAUNCHER": "sccache",
        "VCPKG_HOST_TRIPLET": "linux64-release",
        "VCPKG_TARGET_TRIPLET": "linux64-release"
      }
    },
    {
      "name": "macos-release",
      "displayName": "MacOS Release",
      "description": "Builds for MacOS like an official release",
      "inherits": "release",
      "cacheVariables": {
        "ES_CREATE_BUNDLE": "ON",
        "CMAKE_CXX_COMPILER_LAUNCHER": "sccache",
        "VCPKG_HOST_TRIPLET": "macos64-release",
        "VCPKG_TARGET_TRIPLET": "macos64-release",
        "CMAKE_OSX_ARCHITECTURES": "x86_64",
        "CMAKE_OSX_DEPLOYMENT_TARGET": "10.9"
      }
    },
    {
      "name": "macos-arm-release",
      "displayName": "MacOS ARM Release",
      "description": "Builds for MacOS ARM like an official release",
      "inherits": "release",
      "architecture": {
        "value": "arm64",
        "strategy": "external"
      },
      "cacheVariables": {
        "ES_CREATE_BUNDLE": "ON",
        "CMAKE_CXX_COMPILER_LAUNCHER": "sccache",
        "VCPKG_HOST_TRIPLET": "macos64-release",
        "VCPKG_TARGET_TRIPLET": "macos-arm64-release",
        "CMAKE_OSX_ARCHITECTURES": "arm64",
        "CMAKE_OSX_DEPLOYMENT_TARGET": "10.9"
      }
    },
    {
      "name": "linux-clang",
      "displayName": "Linux Clang++",
      "description": "Builds with the clang++ compiler",
      "inherits": "base",
      "cacheVariables": {
        "CMAKE_CXX_COMPILER": "clang++",
        "VCPKG_TARGET_TRIPLET": "x64-linux-dynamic",
        "CMAKE_BUILD_TYPE": "Debug"
      },
      "condition": {
        "type": "equals",
        "lhs": "${hostSystemName}",
        "rhs": "Linux"
      }
    }
  ],
  "buildPresets": [
    {
      "name": "debug",
      "hidden": true,
      "configuration": "Debug"
    },
    {
      "name": "release",
      "hidden": true,
      "configuration": "Release"
    },
    {
      "name": "linux-gcc-debug",
      "displayName": "Debug",
      "configurePreset": "linux-gcc",
      "inherits": "debug"
    },
    {
      "name": "linux-gcc-release",
      "displayName": "Release",
      "configurePreset": "linux-gcc",
      "inherits": "release"
    },
    {
      "name": "macos-debug",
      "displayName": "Debug",
      "configurePreset": "macos",
      "inherits": "debug"
    },
    {
      "name": "macos-release",
      "displayName": "Release",
      "configurePreset": "macos",
      "inherits": "release"
    },
    {
      "name": "macos-arm-debug",
      "displayName": "Debug",
      "configurePreset": "macos-arm",
      "inherits": "debug"
    },
    {
      "name": "macos-arm-release",
      "displayName": "Release",
      "configurePreset": "macos-arm",
      "inherits": "release"
    },
    {
      "name": "cl-debug",
      "displayName": "Debug",
      "configurePreset": "cl",
      "inherits": "debug"
    },
    {
      "name": "cl-release",
      "displayName": "Release",
      "configurePreset": "cl",
      "inherits": "release"
    },
    {
      "name": "linux-clang-debug",
      "displayName": "Debug",
      "configurePreset": "linux-clang",
      "inherits": "debug"
    },
    {
      "name": "linux-clang-release",
      "displayName": "Release",
      "configurePreset": "linux-clang",
      "inherits": "release"
    }
  ],
  "testPresets": [
  ]
}]==]
)

file(WRITE main.cpp
[==[#include <fmt/format.h>
#include <SFML/Graphics.hpp>


import utilities;

int main(){

    fmt::println("Hello, from main.cpp");
    module_to_main();
    
    return 0;
}]==]
)

file(WRITE utilities.ixx
[==[module;

#include<fmt/format.h>
#include<SFML/Graphics.hpp>

export module utilities;

export void module_to_main(){
    fmt::println("Hello, to main, from utilities.ixx");
}]==]
)

file(WRITE vcpkg.json
[==[{
    "name": "rocket",
    "version": "0.1.0",
    "dependencies": [
        "fmt",
        "sfml"
    ],
    "builtin-baseline": "e861f04798ca54fa70ff906b5e43e5fc99b7f406"
}]==]
)

set(CONFIGURE_PRESET "linux-clang")

message(STATUS "Configuring generated project... ")

execute_process(
    COMMAND 
        "${CMAKE_COMMAND}"
        --preset "${CONFIGURE_PRESET}"

    WORKING_DIRECTORY
        "${PROJECT_ROOT}"

    RESULT_VARIABLE CONFIGURE_RESULT
)
if(NOT CONFIGURE_RESULT EQUAL 0)
    message(FATAL_ERROR "Configuration failed with exit code: ${CONFIGURE_RESULT}")
endif()

message(STATUS "project configured successfully")

execute_process(
    COMMAND 
        ln -sfn ./build/linux-clang/compile_commands.json compile_commands.json
)
