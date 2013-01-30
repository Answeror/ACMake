include(acmake_parse_arguments)
include(acmake_copy_dll)

macro(opencv_support TARGET)
    parse_arguments(
        ACMAKE_OPENCV_SUPPORT
        "WORKING_DIRECTORY"
        "COPY_DLL"
        ${ARGN}
        )

    find_package(OpenCV REQUIRED)
    message("opencv lib dir: ${OpenCV_LIB_DIR}")
    link_directories(${OpenCV_LIB_DIR})
    target_link_libraries(${TARGET} ${OpenCV_LIBS})

    if(ACMAKE_OPENCV_SUPPORT_COPY_DLL)
        acmake_copy_dll(
            TARGET ${TARGET}
            WORKING_DIRECTORY ${ACMAKE_OPENCV_SUPPORT_WORKING_DIRECTORY}
            LIBRARIES ${OpenCV_LIBS}
            )
    endif()
endmacro()
