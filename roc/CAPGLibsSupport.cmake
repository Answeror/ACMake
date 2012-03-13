# Boost support
macro(compileWithBoost)
    set(Boost_USE_STATIC_LIBS OFF)
    set(Boost_USE_MULTITHREADED ON)
    #find_package(Boost COMPONENTS date_time filesystem graph iostreams regex serialization signals system thread unit_test_framework wave)
    find_package(Boost REQUIRED)
    include_directories(${Boost_INCLUDE_DIRS})
    link_directories(${Boost_LIBRARY_DIRS})
endmacro(compileWithBoost)

macro(linkWithBoost projectName)
    if(NOT MSVC)
        target_link_libraries(${projectName} ${Boost_LIBRARIES})
    endif(NOT MSVC)
endmacro(linkWithBoost)

# FBX SDK and FreeImage
macro(linkWithFBXSDK projectName)
    if(MSVC)
        target_link_libraries(${projectName}
            debug       FreeImaged
            optimized   FreeImage)
        target_link_libraries(${projectName} wininet)
        if(MSVC80)
            target_link_libraries(${projectName}
                debug       fbxsdk_md2005d
                optimized   fbxsdk_md2005)
        elseif(MSVC90)
            target_link_libraries(${projectName}
                debug       fbxsdk_md2008d
                optimized   fbxsdk_md2008)
        # 支持vs2010, download: {http://goo.gl/gsHP0 } 
        else()
            target_link_libraries(${projectName}
                debug       fbxsdk_md2010d
                optimized   fbxsdk_md2010)
        endif()
    endif(MSVC)
    if(UNIX)
        target_link_libraries(${projectName} freeimage)
        if(CMAKE_SIZEOF_VOID_P EQUAL 4)
            target_link_libraries(${projectName}
                debug       fbxsdk_gcc4
                optimized   fbxsdk_gcc4)
        else(CMAKE_SIZEOF_VOID_P EQUAL 4)
            target_link_libraries(${projectName}
                debug       fbxsdk_gcc4_x64d
                optimized   fbxsdk_gcc4_x64)
        endif(CMAKE_SIZEOF_VOID_P EQUAL 4)
    endif(UNIX)
endmacro(linkWithFBXSDK)

# Bullet Physics
macro(linkWithBullet projectName)
    target_link_libraries(${projectName}
            BulletSoftBody BulletDynamics BulletCollision LinearMath)
endmacro(linkWithBullet)

# Libxml2
macro(compileWithXML2)
    if(NOT MSVC)
        include(FindLibXml2)
    endif(NOT MSVC)
    if(LIBXML2_FOUND)
        include_directories(${LIBXML2_INCLUDE_DIR})
    endif(LIBXML2_FOUND)
endmacro(compileWithXML2)

macro(linkWithXML2 projectName)
    if(LIBXML2_FOUND)
        target_link_libraries(${projectName} ${LIBXML2_LIBRARIES})
    else(LIBXML2_FOUND)
        target_link_libraries(${projectName} libxml2)
    endif(LIBXML2_FOUND)
endmacro(linkWithXML2)

# mysql-connector
macro(linkWithMySQLConn projectName)
    if(UNIX)
        target_link_libraries(${projectName} mysqlcppconn)
    else(UNIX)
        target_link_libraries(${projectName}
                              debug       mysqlpp_d
                              optimized   mysqlpp )
    endif(UNIX)
endmacro(linkWithMySQLConn)

# OpenGL
macro(compileWithOpenGL)
    # 2011-04-16 Answeror: add "required" to solve vs2010 building problem
    find_package(OpenGL REQUIRED)
    find_package(GLUT REQUIRED)
    if(OPENGL_FOUND)
        include_directories(${OPENGL_INCLUDE_DIR})
    endif(OPENGL_FOUND)
    if(GLUT_FOUND)
        include_directories(${GLUT_INCLUDE_DIR})
    endif(GLUT_FOUND)
endmacro(compileWithOpenGL)
macro(linkWithOpenGL projectName)
    if(OPENGL_FOUND)
        target_link_libraries(${projectName} ${OPENGL_LIBRARIES})
    endif(OPENGL_FOUND)
    if(GLUT_FOUND)
        target_link_libraries(${projectName} ${GLUT_LIBRARIES})
    endif(GLUT_FOUND)
endmacro(linkWithOpenGL)


# CAPG Roc SDK
macro(compileWithRocSDK)
    compileWithBoost()
    compileWithQt()
    compileWithXML2()
    compileWithOpenGL()
endmacro(compileWithRocSDK)

macro(linkWithRocSDK projectName)
    linkWithBoost(${projectName})
    linkWithQt(${projectName})
    linkWithXML2(${projectName})
    linkWithOpenGL(${projectName})
    linkWithFBXSDK(${projectName})
    linkWithBullet(${projectName})
    linkWithMySQLConn(${projectName})
    target_link_libraries(${projectName} GLEW)
    if(USE_INNER_ROC_SDK)
        target_link_libraries(${projectName} CAPGCore CAPGMotion CAPGNet CAPGCoreUI)
    else(USE_INNER_ROC_SDK)
        target_link_libraries(${projectName} 
                              debug CAPGCored
                              debug CAPGMotiond
                              debug CAPGNetd
                              debug CAPGCoreUId
                              optimized CAPGCore
                              optimized CAPGMotion
                              optimized CAPGNet
                              optimized CAPGCoreUI)
    endif(USE_INNER_ROC_SDK)
endmacro(linkWithRocSDK)

# Wml
macro(linkWithWML projectName)
        target_link_libraries(${projectName}
            debug       WildMagic2d
            optimized   WildMagic2)            
endmacro(linkWithWML)



