include(acmake_error)

macro(acmake_use_home TARGET)
    if(NOT EXISTS ${${TARGET}_HOME})
        acmake_error("Invalid ${TARGET}_HOME: ${${TARGET}_HOME}")
    endif()
    set(${TARGET}_ROOT ${${TARGET}_HOME})
    list(INSERT CMAKE_PREFIX_PATH 0 ${${TARGET}_HOME})
endmacro()
