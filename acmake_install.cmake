if(ACMAKE_INSTALL_INCLUDED)
    return()
endif()
set(ACMAKE_INSTALL_INCLUDED TRUE)

include(acmake_recursive_install)

macro(acmake_install_static_library target)
    install(
        TARGETS ${target}
        RUNTIME DESTINATION bin/debug CONFIGURATIONS Debug
        LIBRARY DESTINATION lib/debug CONFIGURATIONS Debug
        ARCHIVE DESTINATION lib/debug CONFIGURATIONS Debug
    )
    install(
        TARGETS ${target}
        RUNTIME DESTINATION bin/release CONFIGURATIONS Release
        LIBRARY DESTINATION lib/release CONFIGURATIONS Release
        ARCHIVE DESTINATION lib/release CONFIGURATIONS Release
    )
    acmake_recursive_install(${target} ${ARGN})
endmacro()
