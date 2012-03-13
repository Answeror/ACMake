# OVEN_TO_BOOST_FOUND
# OVEN_TO_BOOST_INCLUDE_DIRS
# answeror at 2011-11-13

include(FindPkgMacros)
findpkg_begin(OVEN_TO_BOOST)

# get home path from enviounment
getenv_path(OVEN_TO_BOOST_HOME)
if(NOT ENV_OVEN_TO_BOOST_HOME)
    getenv_path(OVEN_TO_BOOST_ROOT)
    set(ENV_OVEN_TO_BOOST_HOME ${ENV_OVEN_TO_BOOST_ROOT})
    if(NOT ENV_OVEN_TO_BOOST_HOME)
        getenv_path(CODE)
        if(ENV_CODE)
            set(MAYBE ${ENV_CODE}/others/OvenToBoost)
            if(EXISTS ${MAYBE})
                set(ENV_OVEN_TO_BOOST_HOME ${MAYBE})
            endif()
        endif()
    endif()
endif()

if(ENV_OVEN_TO_BOOST_HOME)
    set(OVEN_TO_BOOST_INCLUDE_DIR ${ENV_OVEN_TO_BOOST_HOME})
endif()

findpkg_finish(OVEN_TO_BOOST)
