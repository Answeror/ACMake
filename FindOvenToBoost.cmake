# OVEN_TO_BOOST_FOUND
# OVEN_TO_BOOST_INCLUDE_DIRS
# answeror at 2011-11-13

include(ans.env)
include(ans.expand_find_package_hints)

include(FindPkgMacros)
findpkg_begin(OVEN_TO_BOOST)

# get home path from enviounment
getenv_path(OVEN_TO_BOOST_HOME)
if(NOT ENV_OVEN_TO_BOOST_HOME)
    getenv_path(OVEN_TO_BOOST_ROOT)
    set(ENV_OVEN_TO_BOOST_HOME ${ENV_OVEN_TO_BOOST_ROOT})
endif()

expand_find_package_hints(OvenToBoost)
set(OVEN_TO_BOOST_HOME ${ENV_OVEN_TO_BOOST_HOME}
    ${OvenToBoost_FIND_PACKAGE_HINTS})

if(OVEN_TO_BOOST_HOME)
    find_path(OVEN_TO_BOOST_INCLUDE_DIR NAMES boost/range/to_container.hpp
        PATHS ${OVEN_TO_BOOST_HOME})
endif()

findpkg_finish(OVEN_TO_BOOST)
