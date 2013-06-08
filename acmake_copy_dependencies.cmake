if(ACMAKE_COPY_DEPENDENCIES_INCLUDED)
    return()
endif()
set(ACMAKE_COPY_DEPENDENCIES_INCLUDED TRUE)

include(acmake_parse_arguments)

set(ACMAKE_FIXUP_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup.cmake.in)
set(ACMAKE_FIXUP_INSTALL_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup_install.cmake.in)
set(ACMAKE_FIXUP_COMMON_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup_common.cmake)

macro(acmake_copy_dependencies TARGET)
    acmake_parse_arguments(
        ACMAKE_COPY_DEPENDENCIES
        "INSTALL_DIR"
        "INSTALL"
        ${ARGN}
        )
    acmake_get_target_property(RUNTIME_DIRS ${TARGET} ACMAKE_RUNTIME_DIRS)
    acmake_get_target_property(RUNTIME ${TARGET} ACMAKE_RUNTIME)
    acmake_get_target_property(RUNTIME_DEBUG ${TARGET} ACMAKE_RUNTIME_DEBUG)
    acmake_get_target_property(RUNTIME_RELEASE ${TARGET} ACMAKE_RUNTIME_RELEASE)
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
            -DCMAKE_BUILD_TYPE=$<CONFIGURATION>
            -P ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup.cmake
        VERBATIM
        )
    if(ACMAKE_COPY_DEPENDENCIES_INSTALL)
        string(
            REPLACE "${CMAKE_INSTALL_PREFIX}" "\${CMAKE_INSTALL_PREFIX}" 
            ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR
            ${ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR}
            )
        add_custom_command(
            TARGET ${TARGET}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND}
                -DTARGET_FILE_PATH=${ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR}/$<TARGET_FILE_NAME:${TARGET}>
                -DCMAKE_BUILD_TYPE=$<CONFIGURATION>
                -DINSTALL_TEMPLATE=${ACMAKE_FIXUP_INSTALL_PATH}
                -DINSTALL_SCRIPT=${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup_install.cmake
                -P ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup.cmake
            VERBATIM
            )
        install(SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup_install.cmake)
    endif()
endmacro()
