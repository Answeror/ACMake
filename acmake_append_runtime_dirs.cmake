if(ACMAKE_APPEND_RUNTIME_DIRS_INCLUDED)
    return()
endif()
set(ACMAKE_APPEND_RUNTIME_DIRS_INCLUDED)

include(acmake_target_property)

macro(acmake_append_runtime_dirs TARGET)
    foreach(D ${ARGN}) 
        acmake_append_target_property(${TARGET} ACMAKE_RUNTIME_DIRS ${D})
    endforeach()
endmacro()
