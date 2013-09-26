if(ACMAKE_RECURSIVE_INSTALL_INCLUDED)
    return()
endif()
set(ACMAKE_RECURSIVE_INSTALL_INCLUDED TRUE)

macro(acmake_recursive_install target)
    get_target_property(include_deps ${target} INCLUDE_DIRECTORIES)
    set(include_patterns)
    foreach(pattern ${ARGN})
        list(APPEND include_patterns PATTERN ${pattern})
    endforeach()
    foreach(dep ${include_deps})
        # only include lightweight libraries' headers
        if(${dep} MATCHES ^${CMAKE_SOURCE_DIR})
            if(NOT ${dep} MATCHES .*/$)
                set(dep ${dep}/)
            endif()
            install(
                DIRECTORY ${dep}
                DESTINATION include
                FILES_MATCHING
                ${include_patterns}
                )
        endif()
    endforeach()

    get_target_property(link_deps ${target} LINK_INTERFACE_LIBRARIES)
    foreach(dep ${link_deps})
        # only include lightweight libraries' libs
        if(${dep} MATCHES ^${CMAKE_SOURCE_DIR})
            install(
                FILES ${dep}
                DESTINATION lib/release
                )
        endif()
    endforeach()

    get_target_property(link_deps_d ${target} LINK_INTERFACE_LIBRARIES_DEBUG)
    foreach(dep ${link_deps_d})
        # only include lightweight libraries' libs
        if(${dep} MATCHES ^${CMAKE_SOURCE_DIR})
            install(
                FILES ${dep}
                DESTINATION lib/debug
                )
        endif()
    endforeach()
endmacro()
