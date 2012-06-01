include(ans.parse_arguments)

# see <http://www.itk.org/Wiki/CMakeMacroParseArguments>
macro(acmake_parse_arguments)
    parse_arguments(${ARGN})
endmacro()
