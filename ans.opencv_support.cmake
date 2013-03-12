if(NOT ACMAKE_OPENCV_SUPPORT_INCLUDED)
    set(ACMAKE_OPENCV_SUPPORT_INCLUDED TRUE)

    include(acmake_parse_arguments)
    include(acmake_copy_dll)
    include(acmake_target_platform)
    
    macro(opencv_support)
        parse_arguments(
            ACMAKE_OPENCV_SUPPORT
            "WORKING_DIRECTORY"
            "COPY_DLL;COPY_SHARED"
            ${ARGN}
            )
        car(ACMAKE_OPENCV_SUPPORT_TARGET ${ACMAKE_OPENCV_SUPPORT_DEFAULT_ARGS})
    
        find_package(OpenCV REQUIRED)
    
        # check if header only support
        if(ACMAKE_OPENCV_SUPPORT_TARGET)
            link_directories(${OpenCV_LIB_DIR})
            target_link_libraries(${ACMAKE_OPENCV_SUPPORT_TARGET} ${OpenCV_LIBS})
    
            if(ACMAKE_OPENCV_SUPPORT_COPY_DLL OR ACMAKE_OPENCV_SUPPORT_COPY_SHARED)
                acmake_target_platform()
                if(ACMAKE_TARGET_PLATFORM_WINDOWS)
                    acmake_copy_dll(
                        TARGET ${ACMAKE_OPENCV_SUPPORT_TARGET}
                        WORKING_DIRECTORY ${ACMAKE_OPENCV_SUPPORT_WORKING_DIRECTORY}
                        LIBRARIES ${OpenCV_LIBS}
                        )
                endif()
            endif()
        endif()
    endmacro()
endif()
