include(ans.boost_support)
include(acmake_assert)

set(BOOST_HOME CACHE PATH "Boost home path.")
if($ENV{BOOST_HOME})
    set(BOOST_HOME $ENV{BOOST_HOME})
elseif($ENV{BOOST_ROOT})
    set(BOOST_HOME $ENV{BOOST_ROOT})
endif()
acmake_assert(BOOST_HOME)
list(APPEND CMAKE_PREFIX_PATH ${BOOST_HOME})

# Include [and/or link] with boost.
# 
# Use **shared** and **multithread** version.
# Runtime library is multithread (debug) dll.
# Decltype will be supported under MSVC10.
# 
# USAGE: acmake_boost_support([<target>] [COMPONENTS component1 component2
#   ...])
# 
# @param target libs will be linked if it is specified
macro(acmake_boost_support)
    boost_support(${ARGN})
endmacro()
