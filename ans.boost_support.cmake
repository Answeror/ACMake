# don't use this, use `acmake_boost_support` instead

if(NOT ACMAKE_BOOST_SUPPORT_INCLUDED)
    set(ACMAKE_BOOST_SUPPORT_INCLUDED TRUE)

    include(ans.env)
    include(ans.parse_arguments)
    include(acmake_copy_dll)
    include(acmake_error)
    include(acmake_find_package)
    include(acmake_target_platform)
    include(${CMAKE_CURRENT_LIST_DIR}/cmake_cxx11/CheckCXX11Features.cmake)
    include(acmake_append_runtime_dirs)
    
    
    # Include [and link] with boost.
    # 
    # Use shared and multithread version
    # Decltype will be supported under MSVC10.
    # USAGE: boost_support([<target>])
    # 
    # @param target libs will be linked if it is specified
    macro(boost_support)
        parse_arguments(
            BOOST_SUPPORT
            "COMPONENTS;WORKING_DIRECTORY;THREAD"
            "STATIC;SHARED;COPY_DLL;COPY_SHARED"
            ${ARGN}
            )
        car(BOOST_SUPPORT_TARGET ${BOOST_SUPPORT_DEFAULT_ARGS})
        # threading {{{
        if(NOT BOOST_SUPPORT_THREAD)
            set(Boost_USE_MULTITHREADED ON)
        elseif("${BOOST_SUPPORT_THREAD}" EQUAL "SINGLE")
            set(Boost_USE_MULTITHREADED OFF)
        elseif("${BOOST_SUPPORT_THREAD}" EQUAL "MULTI")
            set(Boost_USE_MULTITHREADED ON)
        else()
            acmake_error("Known threading option: %{BOOST_SUPPORT_THREAD}")
        endif()
        # }}}
        if(ANDROID)
            # FindBoost.cmake cannot determine compiler on windows
            set(Boost_COMPILER -gcc)
            set(Boost_USE_STATIC_RUNTIME ON)
        else()
            set(Boost_USE_STATIC_RUNTIME OFF)
        endif()
        if(BOOST_SUPPORT_STATIC)
            set(Boost_USE_STATIC_LIBS ON)
        else()
            # use shared library by default
            set(BOOST_SUPPORT_SHARED TRUE)
            set(Boost_USE_STATIC_LIBS OFF)
            # use shared library in unit test {{{
            list(FIND BOOST_SUPPORT_COMPONENTS unit_test_framework
                BOOST_SUPPORT_UNIT_TEST)
            if(NOT "${BOOST_SUPPORT_UNIT_TEST}" EQUAL "-1")
                add_definitions(-DBOOST_TEST_DYN_LINK)
            endif()
            list(FIND BOOST_SUPPORT_COMPONENTS program_options
                BOOST_SUPPORT_PROGRAM_OPTIONS)
            if(NOT "${BOOST_SUPPORT_PROGRAM_OPTIONS}" EQUAL "-1")
                add_definitions(-DBOOST_PROGRAM_OPTIONS_DYN_LINK)
            endif()
            # }}}
        endif()
        set(Boost_USE_MULTITHREADED ON)
        if(BOOST_SUPPORT_COMPONENTS)
            if (NOT BOOST_SUPPORT_TARGET)
                message(FATAL_ERROR "Target must be specified.")
            endif()
            acmake_find_package(
                Boost
                REQUIRED
                COMPONENTS
                ${BOOST_SUPPORT_COMPONENTS}
                )
            link_directories(${Boost_LIBRARY_DIRS})
            target_link_libraries("${BOOST_SUPPORT_TARGET}" ${Boost_LIBRARIES})
    
            # copy dll
            if(BOOST_SUPPORT_SHARED)
                if(BOOST_SUPPORT_COPY_DLL OR BOOST_SUPPORT_COPY_SHARED)
                    acmake_append_runtime_dirs(${BOOST_SUPPORT_TARGET} ${Boost_LIBRARY_DIRS})
                endif()
            endif()
        else()
            # head only support
            acmake_find_package(Boost REQUIRED)
        endif()
    
        boost_config()
        include_directories(${Boost_INCLUDE_DIRS})
    
        # try to find extensions
        if(OVEN_TO_BOOST_HOME)
            message("Found OvenToBoost.")
            include_directories(${OVEN_TO_BOOST_HOME})
        endif()
    endmacro()
    
    # include boost header files, also extensions
    # decltype will be supported under MSVC10
    macro(boost_header_only_support)
        if(NOT ANS_BOOST_HEADER_ONLY_SUPPORTED)
            set(Boost_USE_STATIC_LIBS OFF)
            set(Boost_USE_MULTITHREADED ON)
            acmake_find_package(Boost REQUIRED)
            include_directories(${Boost_INCLUDE_DIRS})
            boost_config()
            # try to find extensions
            acmake_find_package(OvenToBoost)
            if(OVEN_TO_BOOST_FOUND)
                #message("${OVEN_TO_BOOST_INCLUDE_DIRS}")
                include_directories(${OVEN_TO_BOOST_INCLUDE_DIRS})
            endif()
            set(ANS_BOOST_HEADER_ONLY_SUPPORTED TRUE)
        endif()
    endmacro()
    
    # helper function
    # decltype will be supported under MSVC10
    macro(boost_config)
        # decltype
        if(HAS_CXX11_DECLTYPE)
            add_definitions(-DBOOST_RESULT_OF_USE_DECLTYPE)
        endif()
        # disable auto link on windows, use dynamic boost lib instead
        add_definitions(-DBOOST_ALL_NO_LIB)
        add_definitions(-DBOOST_LIB_DIAGNOSTIC)
    endmacro()
endif()
