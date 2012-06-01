include(acmake_common)
include(acmake_env_home)

# usage: acmake_bullet_support(<target>)
# requires: environment variable BULLET_HOME or BULLET_ROOT
macro(acmake_bullet_support TARGET)
    acmake_env_home(BULLET_ROOT BULLET)
    find_package(Bullet REQUIRED)
    include_directories(${BULLET_INCLUDE_DIRS})
    target_link_libraries(${TARGET} ${BULLET_LIBRARIES})
endmacro()
