if(ACMAKE_VERSION_INCLUDED)
    return()
endif()
set(ACMAKE_VERSION_INCLUDED TRUE)

list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR}/cmake-modules)
include(GetGitRevisionDescription)

macro(acmake_version TARGET)
    git_describe(${TARGET}_RELEASE_VERSION)
    string(REPLACE "." "-" ${TARGET}_FILE_VERSION ${${TARGET}_RELEASE_VERSION})
endmacro()
