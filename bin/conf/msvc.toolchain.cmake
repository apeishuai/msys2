#cmake -G Ninja -DCMAKE_TOOLCHAIN_FILE=../msvc.toolchain.cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_CXX_FLAGS="/Zi /Od /FC" -DCMAKE_EXE_LINKER_FLAGS="/DEBUG /PDB:hello.pdb" .. //msvc带调试符号

# set os
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_VERSION 10)
set(CMAKE_SYSTEM_PROCESSOR x86_64)

if(NOT DEFINED QT_HOME)
    if(EXISTS "D:/qt6.8.3/6.8.3/msvc2022_64")
    set(QT_HOME "D:/qt6.8.3/6.8.3/msvc2022_64")
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
set(CMAKE_LINKER "${MSVC_ROOT}/link.exe")
set(WINDOWS_SDK_ROOT "D:/Windows Kits/10")
set(CMAKE_RC_COMPILER "${WINDOWS_SDK_ROOT}/bin/10.0.22000.0/x64/rc.exe")

set(CMAKE_C_FLAGS "/Zc:__cplusplus /Zi /Od")
set(CMAKE_CXX_FLAGS_INIT "-DQT_QML_DEBUG")
set(CMAKE_FIND_ROOT_PATH "${QT_HOME}")

# option, whether 
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)    
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)    
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)  
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)  


set(VCPKG_TARGET_TRIPLET x64-windows CACHE STRING "VCPKG Target Triplet")
set(VCPKG_TOOLCHAIN_FILE "D:/softwares/scoop/apps/vcpkg/current/scripts/buildsystems/vcpkg.cmake")
include(${VCPKG_TOOLCHAIN_FILE})

list(APPEND CMAKE_PREFIX_PATH
    "D:/softwares/scoop/apps/vcpkg/current/installed/x64-windows"
    "D:/qt6.8.3/6.8.3/msvc2022_64"
    "${QT_HOME}"
)
set(Qt6_DIR "D:/qt6.8.3/6.8.3/msvc2022_64/lib/cmake/Qt6")


# message
message(STATUS "MSVC Toolchain Configuration:")
message(STATUS "  - C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "  - C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "  - Make Program: ${CMAKE_MAKE_PROGRAM}")
