include(acmake_parse_arguments)

function(acmake_fill_working_directory WORKING_DIRECTORY)
    parse_arguments(
        ""
        "TARGET"
        ""
        ${ARGN}
        )
    if(NOT ${WORKING_DIRECTORY})
        get_property(TARGET_TYPE TARGET ${_TARGET} PROPERTY TYPE)
        if(TARGET_TYPE MATCHES "EXECUTABLE")
            set(${WORKING_DIRECTORY} $<TARGET_FILE_DIR:${_TARGET}> PARENT_SCOPE)
        else()
            set(${WORKING_DIRECTORY} ${CMAKE_RUNTIME_OUTPUT_DIRECTORY} PARENT_SCOPE)
        endif()
    endif()
endfunction()
