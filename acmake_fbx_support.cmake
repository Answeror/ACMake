# usage: acmake_fbx_support(<target>)
# requires: cache/environment variable FBX_HOME or FBX_ROOT
macro(acmake_fbx_support TARGET)
    find_package(FBX REQUIRED)
    include_directories(${FBX_INCLUDE_DIRS})
    message("asdf ${FBX_LIBRARIES}")
    target_link_libraries(${TARGET} ${FBX_LIBRARIES})
endmacro()
