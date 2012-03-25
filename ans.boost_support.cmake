# include boost header files, also extensions
# decltype will be supported under MSVC10
macro(boost_header_only_support)
    if(NOT ANS_BOOST_HEADER_ONLY_SUPPORTED)
        set(Boost_USE_STATIC_LIBS OFF)
        set(Boost_USE_MULTITHREADED ON)
        find_package(Boost REQUIRED)
        include_directories(${Boost_INCLUDE_DIRS})
        boost_config()
        # try to find extensions
        find_package(OvenToBoost)
        if(OVEN_TO_BOOST_FOUND)
            #message("${OVEN_TO_BOOST_INCLUDE_DIRS}")
            include_directories(${OVEN_TO_BOOST_INCLUDE_DIRS})
        endif()
        set(ANS_BOOST_HEADER_ONLY_SUPPORTED TRUE)
    endif()
endmacro()

# include and link with boost
# use shared and multithread version
# decltype will be supported under MSVC10
macro(boost_support TARGET)
    if(NOT ANS_BOOST_SUPPORTED)
        set(Boost_USE_STATIC_LIBS OFF)
        set(Boost_USE_MULTITHREADED ON)
        find_package(Boost COMPONENTS
            date_time
            filesystem
            graph
            iostreams
            regex
            serialization
            signals
            system
            thread
            unit_test_framework
            wave
            )
        include_directories(${Boost_INCLUDE_DIRS})
        link_directories(${Boost_LIBRARY_DIRS})
        boost_config()
        # try to find extensions
        find_package(OvenToBoost)
        if(OVEN_TO_BOOST_FOUND)
            #message("${OVEN_TO_BOOST_INCLUDE_DIRS}")
            include_directories(${OVEN_TO_BOOST_INCLUDE_DIRS})
        endif()
        set(ANS_BOOST_SUPPORTED TRUE)
    endif()
    target_link_libraries(${TARGET} ${Boost_LIBRARIES})
endmacro()

# helper function
# decltype will be supported under MSVC10
macro(boost_config)
    # decltype
    if(MSVC10)
        add_definitions(-DBOOST_RESULT_OF_USE_DECLTYPE)
    endif()
    # disable auto link on windows, use dynamic boost lib instead
    add_definitions(-DBOOST_ALL_NO_LIB)
    add_definitions(-DBOOST_LIB_DIAGNOSTIC)
endmacro()
