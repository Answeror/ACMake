if(ACMAKE_PACK_INCLUDED)
    return()
endif()
set(ACMAKE_PACK_INCLUDED TRUE)

include(acmake_version)

macro(acmake_pack TARGET)
    find_program(ACMAKE_SEVENZ 7z)
    if(NOT ACMAKE_SEVENZ)
        message("Can't find 7z, packaging failed.")
    else()
        acmake_version(${TARGET})
        add_custom_target(
            pack
            COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_BINARY_DIR}/install ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}
            COMMAND ${ACMAKE_SEVENZ} a -y -sfx7z.sfx ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}.exe ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}
            VERBATIM
            )
    endif()
endmacro()
