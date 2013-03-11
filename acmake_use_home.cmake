include(acmake_error)

macro(acmake_use_home TARGET)
    if(NOT EXISTS ${${TARGET}_HOME})
        acmake_error("Invalid ${TARGET}_HOME: ${${TARGET}_HOME}")
    endif()
    set(${TARGET}_ROOT ${${TARGET}_HOME})
    list(APPEND CMAKE_PREFIX_PATH ${${TARGET}_HOME})
endmacro()
