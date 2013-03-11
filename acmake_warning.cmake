if(NOT ACMAKE_WARNING_INCLUDED)
    set(ACMAKE_WARNING_INCLUDED TRUE)
    macro(acmake_warning MSG)
        message(
            WARNING
            "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] ${MSG}"
        )
    endmacro()
endif()
