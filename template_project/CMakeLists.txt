cmake_minimum_required(VERSION 2.8.5)

project(%(project_name)s)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_SOURCE_DIR}/misc/cmake)
include(config)

add_subdirectory(src)

enable_testing()
add_subdirectory(test)
