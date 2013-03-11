include(acmake_parse_arguments)
include(acmake_copy_dll)
include(acmake_target_platform)

macro(opencv_support TARGET)
    parse_arguments(
        ACMAKE_OPENCV_SUPPORT
        "WORKING_DIRECTORY"
        "COPY_DLL;COPY_SHARED"
        ${ARGN}
        )

    find_package(OpenCV REQUIRED)
    message("opencv lib dir: ${OpenCV_LIB_DIR}")
    link_directories(${OpenCV_LIB_DIR})
    target_link_libraries(${TARGET} ${OpenCV_LIBS})

    if(ACMAKE_OPENCV_SUPPORT_COPY_DLL OR ACMAKE_OPENCV_SUPPORT_COPY_SHARED)
        acmake_target_platform()
        if(ACMAKE_TARGET_PLATFORM_WINDOWS)
            acmake_copy_dll(
                TARGET ${TARGET}
                WORKING_DIRECTORY ${ACMAKE_OPENCV_SUPPORT_WORKING_DIRECTORY}
                LIBRARIES ${OpenCV_LIBS}
                )
        endif()
    endif()
endmacro()
