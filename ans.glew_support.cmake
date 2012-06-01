# warning: use acmake_glew_support instead

include(ans.env)
include(ans.parse_arguments)

# glew_support([<target_name>])
# @praram target_name live empty if target is not executable
macro(glew_support)
    parse_arguments(
        GLEW_SUPPORT
        ""
        ""
        ${ARGN}
        )
    car(GLEW_SUPPORT_TARGET ${GLEW_SUPPORT_DEFAULT_ARGS})
    find_package(GLEW)
    if(GLEW_FOUND)
        include_directories(${GLEW_INCLUDE_PATH})
    else()
        set(GLEW_LIBRARY glew32)
        set(GLEW_FOUND TRUE)
    endif()
    if(GLEW_SUPPORT_TARGET)
        target_link_libraries("${GLEW_SUPPORT_TARGET}" ${GLEW_LIBRARY})
    endif()
endmacro()
