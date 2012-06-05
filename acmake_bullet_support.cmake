include(acmake_common)
include(acmake_env_home)

# usage: acmake_bullet_support([<target>])
#   if target is not specified, no linking
# requires: environment variable BULLET_HOME or BULLET_ROOT
macro(acmake_bullet_support)
    acmake_env_home(BULLET_ROOT BULLET)
    find_package(Bullet REQUIRED)
    include_directories(${BULLET_INCLUDE_DIRS})
    if(ARGN)
        target_link_libraries(${ARGN} ${BULLET_LIBRARIES})
    endif()
endmacro()
