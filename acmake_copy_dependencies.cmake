set(ACMAKE_FIXUP_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup.cmake.in)
macro(acmake_copy_dependencies TARGET)
    acmake_get_target_property(RUNTIME_DIRS ${TARGET} ACMAKE_RUNTIME_DIRS)
    configure_file(
        ${ACMAKE_FIXUP_PATH}
        ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup.cmake
        @ONLY
        )
    add_custom_command(
        TARGET ${TARGET}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND}
            -DTARGET_FILE_PATH=$<TARGET_FILE:${TARGET}>
            -P "${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup.cmake"
        VERBATIM
    )
endmacro()
