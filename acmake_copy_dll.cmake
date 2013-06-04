include(acmake_parse_arguments)
include(acmake_get_dll)
include(acmake_fill_working_directory)
include(acmake_target_platform)
include(acmake_warning)

macro(acmake_copy_dll)
    parse_arguments(
        ACMAKE_COPY_DLL
        "TARGET;WORKING_DIRECTORY;LIBRARIES;DLLS;DLLS_DEBUG;DLLS_RELEASE"
        "DEBUG"
        ${ARGN}
        )

    acmake_target_platform()
    
    if(NOT ACMAKE_TARGET_PLATFORM_WINDOWS)
        acmake_warning("Target platform isn't windows.")
    else()
        # get dll path from lib path
        if(ACMAKE_COPY_DLL_LIBRARIES)
            acmake_get_dll(
                ACMAKE_COPY_DLL_DLLS
                ACMAKE_COPY_DLL_DLLS_DEBUG
                ACMAKE_COPY_DLL_DLLS_RELEASE
                ${ACMAKE_COPY_DLL_LIBRARIES}
            )
        endif()

        if(ACMAKE_COPY_DLL_DEBUG)
            message("ACMAKE_COPY_DLL_LIBRARIES: ${ACMAKE_COPY_DLL_LIBRARIES}")
            message("ACMAKE_COPY_DLL_DLLS: ${ACMAKE_COPY_DLL_DLLS}")
            message("ACMAKE_COPY_DLL_DLLS_RELEASE: ${ACMAKE_COPY_DLL_DLLS_RELEASE}")
            message("ACMAKE_COPY_DLL_DLLS_DEBUG: ${ACMAKE_COPY_DLL_DLLS_DEBUG}")
        endif()

        # fill working directory if necessary
        acmake_fill_working_directory(
            ACMAKE_COPY_DLL_WORKING_DIRECTORY
            TARGET ${ACMAKE_COPY_DLL_TARGET}
            )

        if(ACMAKE_COPY_DLL_DEBUG)
            message("ACMAKE_COPY_DLL_WORKING_DIRECTORY_DEBUG: ${ACMAKE_COPY_DLL_WORKING_DIRECTORY_DEBUG}")
            message("ACMAKE_COPY_DLL_WORKING_DIRECTORY_RELEASE: ${ACMAKE_COPY_DLL_WORKING_DIRECTORY_RELEASE}")
        endif()

        foreach(SUFFIX _DEBUG _RELEASE)
            if(ACMAKE_COPY_DLL_WORKING_DIRECTORY${SUFFIX})
                foreach(DLL ${ACMAKE_COPY_DLL_DLLS} ${ACMAKE_COPY_DLL_DLLS${SUFFIX}})
                    add_custom_command(
                        TARGET ${ACMAKE_COPY_DLL_TARGET}
                        POST_BUILD
                            COMMAND ${CMAKE_COMMAND} -E copy_if_different
                            ${DLL}
                            ${ACMAKE_COPY_DLL_WORKING_DIRECTORY${SUFFIX}}
                    )
                endforeach()
            endif()
        endforeach()
    endif()
endmacro()
