macro(acmake_error MSG)
    message(
        FATAL_ERROR
        "[ ${CMAKE_CURRENT_LIST_FILE}:${CMAKE_CURRENT_LIST_LINE} ] ${MSG}"
    )
endmacro()
