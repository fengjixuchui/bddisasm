cmake_minimum_required(VERSION 3.12)

project(disasmtool LANGUAGES CXX)

# Use Release as the build type if no build type was specified and we're not using a multi-config generator    .
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "No build type given. Will use 'Release'")
    set(CMAKE_BUILD_TYPE
        "Release"
        CACHE STRING "Choose the type of build." FORCE)
    # Set the possible values of build type for cmake-gui.
    set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS "Debug" "Release")
endif ()

add_executable(disasmtool disasmtool.cpp dumpers.cpp)

target_compile_options(
    disasmtool
    PRIVATE "$<$<CONFIG:Release>:-U_FORTIFY_SOURCE>"
            "$<$<CONFIG:Release>:-D_FORTIFY_SOURCE=2>"
            -Wall
            -Wextra
            -Wshadow
            -Wformat-security
            -Wstrict-overflow=2
            -Wno-unused-function
            -Wno-multichar
            -Werror=format-security
            -pipe
            -fpie
            -fwrapv
            -fno-strict-aliasing
            -fstack-protector-strong
            -ffunction-sections
            -fdata-sections
            -g3
            -gdwarf-4
            -grecord-gcc-switches
            -march=nehalem
            -fno-omit-frame-pointer)

# find_package(bddisasm REQUIRED)
find_package(RapidJSON QUIET)

target_link_libraries(disasmtool PRIVATE bddisasm::bddisasm bddisasm::bdshemu)
if (RapidJSON_FOUND)
    # :( https://github.com/satishbabariya/modern-cmake#good-boys-export-their-targets
    target_include_directories(disasmtool PRIVATE ${RapidJSON_INCLUDE_DIRS})
    target_sources(disasmtool PRIVATE rapidjson.cpp)
    target_compile_definitions(disasmtool PRIVATE HAS_RAPIDJSON)
endif ()

if ("${CMAKE_BUILD_TYPE}" STREQUAL "Release")
    include(CheckIPOSupported)
    check_ipo_supported(RESULT USE_IPO)
    if (USE_IPO)
        set_target_properties(bddisasm PROPERTIES INTERPROCEDURAL_OPTIMIZATION True)
    endif ()
endif ()

set_target_properties(
    disasmtool
    PROPERTIES POSITION_INDEPENDENT_CODE ON
               CXX_STANDARD 17
               CXX_STANDARD_REQUIRED ON
               CXX_EXTENSIONS ON)
