include(ans.env)

macro(expand_find_package_hints NAME)
    set(${NAME}_FIND_PACKAGE_HINTS ${ACMAKE_FIND_PACKAGE_HINTS})
    foreach(D ${ACMAKE_FIND_PACKAGE_HINTS})
        list(APPEND ${NAME}_FIND_PACKAGE_HINTS ${D})
    endforeach()
endmacro()
