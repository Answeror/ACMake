if(ACMAKE_COPY_SHARED_INCLUDED)
    return()
endif()
if(ACMAKE_COPY_SHARED_INCLUDED TRUE)

include(acmake_parse_arguments)
include(acmake_get_dll)
include(acmake_fill_working_directory)
include(acmake_target_platform)
include(acmake_warning)

macro(acmake_copy_shared)
    parse_arguments(
        ACMAKE_COPY_SHARED
        "TARGET;DESTINATION;LIBRARIES;DLLS;DLLS_DEBUG;DLLS_OPTIMIZED;CONFIGURATIONS;INSTALL"
        "DEBUG"
        ${ARGN}
        )

    acmake_target_platform()
    
    if(NOT ACMAKE_TARGET_PLATFORM_WINDOWS)
        acmake_warning("Target platform isn't windows.")
    else()
        # get dll path from lib path
        if(ACMAKE_COPY_SHARED_LIBRARIES)
            acmake_get_dll(
                ACMAKE_COPY_SHARED_DLLS
                ACMAKE_COPY_SHARED_DLLS_DEBUG
                ACMAKE_COPY_SHARED_DLLS_OPTIMIZED
                ${ACMAKE_COPY_SHARED_LIBRARIES}
            )
        endif()

        if(ACMAKE_COPY_SHARED_DEBUG)
            message("ACMAKE_COPY_SHARED_LIBRARIES: ${ACMAKE_COPY_SHARED_LIBRARIES}")
            message("ACMAKE_COPY_SHARED_DLLS: ${ACMAKE_COPY_SHARED_DLLS}")
            message("ACMAKE_COPY_SHARED_DLLS_OPTIMIZED: ${ACMAKE_COPY_SHARED_DLLS_OPTIMIZED}")
            message("ACMAKE_COPY_SHARED_DLLS_DEBUG: ${ACMAKE_COPY_SHARED_DLLS_DEBUG}")
        endif()

        # fill working directory if necessary
        acmake_fill_working_directory(
            ACMAKE_COPY_SHARED_DESTINATION
            TARGET ${ACMAKE_COPY_SHARED_TARGET}
            )

        if(ACMAKE_COPY_SHARED_DEBUG)
            message("ACMAKE_COPY_SHARED_DESTINATION_DEBUG: ${ACMAKE_COPY_SHARED_DESTINATION_DEBUG}")
            message("ACMAKE_COPY_SHARED_DESTINATION_RELEASE: ${ACMAKE_COPY_SHARED_DESTINATION_RELEASE}")
        endif()

        foreach(CONFIG ${ACMAKE_COPY_SHARED_CONFIGURATIONS})
            string(TOUPPER ${CONFIG} _CONFIG_SUFFIX)
            if(CONFIG MATCHES Debug)
                set(_DLL_TYPE_SUFFIX _DEBUG)
            else()
                set(_DLL_TYPE_SUFFIX _OPTIMIZED)
            endif()
            if(ACMAKE_COPY_SHARED_DESTINATION${_CONFIG_SUFFIX})
                foreach(DLL ${ACMAKE_COPY_SHARED_DLLS} ${ACMAKE_COPY_SHARED_DLLS${_DLL_TYPE_SUFFIX}})
                    add_custom_command(
                        TARGET ${ACMAKE_COPY_SHARED_TARGET}
                        POST_BUILD
                        COMMAND ${CMAKE_COMMAND} -E copy_if_different
                        ${DLL}
                        ${ACMAKE_COPY_SHARED_DESTINATION${_CONFIG_SUFFIX}}
                    )
                endforeach()
            endif()
        endforeach()

        if(ACMAKE_COPY_SHARED_INSTALL)
            install(
                FILES ACMAKE_COPY_SHARED_
        endif()
    endif()
endmacro()
