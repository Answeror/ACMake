# MLPACK_INCLUDE_DIRS
# MLPACK_LIBRARIES

include(FindPkgMacros)

findpkg_begin(MLPACK)

# Get path, convert backslashes as ${ENV_${var}}
getenv_path(MLPACK_HOME)

# construct search paths
set(MLPACK_PREFIX_PATH ${MLPACK_HOME} ${ENV_MLPACK_HOME})
create_search_paths(MLPACK)

# redo search if prefix path changed
clear_if_changed(
    MLPACK_PREFIX_PATH
    MLPACK_LIBRARY_FWK
    MLPACK_LIBRARY_REL
    MLPACK_LIBRARY_DBG
    MLPACK_INCLUDE_DIR
)

set(MLPACK_LIBRARY_NAMES mlpack)
get_debug_names(MLPACK_LIBRARY_NAMES)

# fill in variables
use_pkgconfig(MLPACK_PKGC mlpack)
findpkg_framework(MLPACK)
find_path(MLPACK_INCLUDE_DIR NAMES mlpack/core.hpp HINTS ${MLPACK_INC_SEARCH_PATH} ${MLPACK_PKGC_INCLUDE_DIRS})
find_library(MLPACK_LIBRARY_REL NAMES ${MLPACK_LIBRARY_NAMES} HINTS ${MLPACK_LIB_SEARCH_PATH} ${MLPACK_PKGC_LIBRARY_DIRS})
find_library(MLPACK_LIBRARY_DBG NAMES ${MLPACK_LIBRARY_NAMES_DBG} HINTS ${MLPACK_LIB_SEARCH_PATH} ${MLPACK_PKGC_LIBRARY_DIRS})
make_library_set(MLPACK_LIBRARY)

findpkg_finish(MLPACK)
