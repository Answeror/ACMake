# warning: do not use this directly, use acmake_xxx_support instead

include(acmake_common)

# usage: acmake_simple_support(<target> <library>)
# 
# XXX_HOME will be considered
macro(acmake_simple_support TARGET LIBRARY)
    string(TOUPPER ${LIBRARY} UPPER_LIBRARY)
    if(EXISTS "${${LIBRARY}_HOME}")
        list(APPEND CMAKE_PREFIX_PATH "${${LIBRARY}_HOME}")
    endif()
    if(EXISTS "${${UPPER_LIBRARY}_HOME}")
        list(APPEND CMAKE_PREFIX_PATH "${${UPPER_LIBRARY}_HOME}")
    endif()
    find_package(${LIBRARY} REQUIRED)
    include_directories(${${LIBRARY}_INCLUDE_DIRS})
    include_directories(${${UPPER_LIBRARY}_INCLUDE_DIRS})
    target_link_libraries(${TARGET} ${${LIBRARY}_LIBRARIES})
    target_link_libraries(${TARGET} ${${UPPER_LIBRARY}_LIBRARIES})
endmacro()
