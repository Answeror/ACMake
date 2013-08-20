if(ACMAKE_PACK_INCLUDED)
    return()
endif()
set(ACMAKE_PACK_INCLUDED TRUE)

include(acmake_version)

macro(acmake_pack TARGET)
    acmake_version(${TARGET})
    add_custom_target(
        pack
        COMMAND ${CMAKE_COMMAND} -E copy_directory ${CMAKE_BINARY_DIR}/install ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}
        COMMAND ${CMAKE_COMMAND} -E tar czf ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}.tar.gz ${CMAKE_BINARY_DIR}/${TARGET}.${${TARGET}_FILE_VERSION}
        VERBATIM
        )
endmacro()
