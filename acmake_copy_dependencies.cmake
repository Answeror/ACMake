if(ACMAKE_COPY_DEPENDENCIES_INCLUDED)
    return()
endif()
set(ACMAKE_COPY_DEPENDENCIES_INCLUDED TRUE)

include(acmake_parse_arguments)

set(ACMAKE_FIXUP_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup.cmake.in)
set(ACMAKE_FIXUP_INSTALL_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup_install.cmake.in)
set(ACMAKE_MAKE_FIXUP_INSTALL_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_make_fixup_install.cmake.in)
set(ACMAKE_FIXUP_COMMON_PATH ${CMAKE_CURRENT_LIST_DIR}/acmake_fixup_common.cmake)

macro(acmake_copy_dependencies TARGET)
    acmake_parse_arguments(
        ACMAKE_COPY_DEPENDENCIES
        "INSTALL_DIR;CONFIGURATIONS;SUFFIX"
        "INSTALL"
        ${ARGN}
        )
    acmake_get_target_property(RUNTIME_DIRS ${TARGET} ACMAKE_RUNTIME_DIRS)
    acmake_get_target_property(RUNTIME ${TARGET} ACMAKE_RUNTIME)
    foreach(CONFIG Debug Release)
        string(TOUPPER ${CONFIG} _CONFIG_UPPER)
        acmake_get_target_property(RUNTIME_${_CONFIG_UPPER} ${TARGET} ACMAKE_RUNTIME_${_CONFIG_UPPER})
    endforeach()
    configure_file(
        ${ACMAKE_FIXUP_PATH}
        ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake
        @ONLY
        )
    set(CONFIGURATIONS ${ACMAKE_COPY_DEPENDENCIES_CONFIGURATIONS})
    add_custom_command(
        TARGET ${TARGET}
        POST_BUILD
        COMMAND ${CMAKE_COMMAND}
            -DTARGET_FILE_PATH=$<TARGET_FILE:${TARGET}>
            -DCMAKE_BUILD_TYPE=$<CONFIGURATION>
            -P ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake
        VERBATIM
        )
    if(ACMAKE_COPY_DEPENDENCIES_INSTALL)
        configure_file(
            ${ACMAKE_MAKE_FIXUP_INSTALL_PATH}
            ${CMAKE_CURRENT_BINARY_DIR}/acmake_make_fixup_install${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake
            @ONLY
            )
        add_custom_command(
            TARGET ${TARGET}
            POST_BUILD
            COMMAND ${CMAKE_COMMAND}
                -DTARGET_FILE_PATH=${ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR}/$<TARGET_FILE_NAME:${TARGET}>
                -DCMAKE_BUILD_TYPE=$<CONFIGURATION>
                -DINSTALL_TEMPLATE=${ACMAKE_FIXUP_INSTALL_PATH}
                -DINSTALL_SCRIPT=${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup_install${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake
                -P ${CMAKE_CURRENT_BINARY_DIR}/acmake_make_fixup_install${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake
            VERBATIM
            )
        string(
            REPLACE "${CMAKE_INSTALL_PREFIX}" "\${CMAKE_INSTALL_PREFIX}" 
            ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR
            ${ACMAKE_COPY_DEPENDENCIES_INSTALL_DIR}
            )
            install(SCRIPT ${CMAKE_CURRENT_BINARY_DIR}/acmake_fixup_install${ACMAKE_COPY_DEPENDENCIES_SUFFIX}.cmake)
    endif()
endmacro()
