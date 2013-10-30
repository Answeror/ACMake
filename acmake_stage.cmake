if(ACMAKE_STAGE_INCLUDED)
    return()
endif()
set(ACMAKE_STAGE_INCLUDED TRUE)

macro(acmake_stage)
    set(STAGE intern CACHE STRING "project build stage: intern or extern")
    include(${STAGE}.cmake)
endmacro()
