include(ans.opencv_support)

set(OPENCV_HOME $ENV{OpenCV_DIR} CACHE PATH "OpenCV home path.")
if(NOT OPENCV_HOME)
    message(FATAL_ERROR "Please define cache variable OPENCV_HOME.")
endif()
list(APPEND CMAKE_PREFIX_PATH ${OPENCV_HOME})

macro(acmake_opencv_support TARGET)
    opencv_support(${TARGET} ${ARGN})
endmacro()
