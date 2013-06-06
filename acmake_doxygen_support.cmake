if(ACMAKE_DOXYGEN_SUPPORT_INCLUDED)
    return()
endif()

set(ACMAKE_DOXYGEN_SUPPORT_INCLUDED TRUE)

include(ans.doxygen_support)

macro(acmake_doxygen_support)
    doxygen_support(${ARGN})
endmacro()
