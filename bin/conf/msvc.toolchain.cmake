# cmake -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE=path/to/this/file.cmake ..

# set os
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)


if(NOT DEFINED QT_HOME)
    if(EXISTS "D:/qt6.8.2/6.8.2/mingw_64")
    set(QT_HOME "D:/qt6.8.2/6.8.2/mingw_64")
    elseif(EXISTS "$ENV{QTDIR}")
        set(QT_HOME "$ENV{QTDIR}")
    else()
        message(FATAL_ERROR "请通过 -DQT_HOME= 指定Qt安装路径")
    endif()
endif()


# tool chain
set(MSVC_ROOT "C:/Program Files/Microsoft Visual Studio/2022/Community/VC/Tools/MSVC/14.44.35207/bin/Hostx64/x64")
set(CMAKE_C_COMPILER "${MSVC_ROOT}/cl.exe")
set(CMAKE_CXX_COMPILER "${MSVC_ROOT}/cl.exe")
set(CMAKE_RC_COMPILER "${MSVC_ROOT}/rc.exe")
set(CMAKE_MAKE_PROGRAM "${MSVC_ROOT}/nmake.exe")

list(APPEND CMAKE_PREFIX_PATH "${QT_HOME}")
set(Qt6_DIR "${QT_HOME}/lib/cmake/Qt6")

set(CMAKE_FIND_ROOT_PATH "${QT_HOME}")


# option, whether 
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)    
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)    
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)  
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)  

# set(CMAKE_C_FLAGS "-march=x86-64 -mtune=generic")
# set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17")

# message
message(STATUS "MSVC Toolchain Configuration:")
message(STATUS "  - C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "  - C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "  - Make Program: ${CMAKE_MAKE_PROGRAM}")


set(VCPKG_TARGET_TRIPLET x64-windows CACHE STRING "VCPKG Target Triplet")
include("D:/softwares/scoop/apps/vcpkg/current/scripts/buildsystems/vcpkg.cmake")
list(APPEND CMAKE_FIND_ROOT_PATH "D:/softwares/scoop/apps/vcpkg/current/installed/x64-windows")
