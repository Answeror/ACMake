include(ans.env)
include(ans.expand_find_package_hints)

macro(cmlex_support)
    cml_support()
    expand_find_package_hints(cmlex)
    find_package(CMLex REQUIRED HINTS ${cmlex_FIND_PACKAGE_HINTS})
    include_directories(${CMLEX_INCLUDE_DIRS})
endmacro()
