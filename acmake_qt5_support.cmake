if(ACMAKE_QT5_SUPPORT_INCLUDED)
    return()
endif()
set(ACMAKE_QT5_SUPPORT_INCLUDED ON)

cmake_minimum_required(VERSION 3.1.0)
include(CMakeParseArguments)

macro(acmake_qt5_support target)
    cmake_parse_arguments(
        ACMAKE_QT5_SUPPORT
        ""
        ""
        "COMPONENTS;RESOURCES"
        ${ARGN}
    )
    set_target_properties(${target} PROPERTIES AUTOMOC ON)
    foreach(comp ${ACMAKE_QT5_SUPPORT_COMPONENTS})
        find_package(Qt5${comp} REQUIRED)
    endforeach()
    # for moc
    target_include_directories(${target} PRIVATE ${CMAKE_CURRENT_BINARY_DIR})
    foreach(comp ${ACMAKE_QT5_SUPPORT_COMPONENTS})
        target_link_libraries(${target} LINK_PUBLIC Qt5::${comp})
    endforeach()

    if(ACMAKE_QT5_SUPPORT_RESOURCES)
        qt5_add_resources(ACMAKE_QT5_SUPPORT_RESOURCE_SRC ${ACMAKE_QT5_SUPPORT_RESOURCES})
        add_library(${target}-resources STATIC ${ACMAKE_QT5_SUPPORT_RESOURCE_SRC})
        target_link_libraries(${target} LINK_PUBLIC ${target}-resources)
    endif()
endmacro()
