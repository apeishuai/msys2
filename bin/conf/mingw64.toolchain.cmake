# cmake -G "MinGW Makefiles" -DCMAKE_TOOLCHAIN_FILE=path/to/this/file.cmake ..

# set os
set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_PROCESSOR x86_64)


# tool chain
set(MINGW_ROOT "D:/softwares/msys64/mingw64")
set(CMAKE_FIND_ROOT_PATH "${MINGW_ROOT}")
set(CMAKE_C_COMPILER "${MINGW_ROOT}/bin/gcc.exe")
set(CMAKE_CXX_COMPILER "${MINGW_ROOT}/bin/g++.exe")
set(CMAKE_RC_COMPILER "${MINGW_ROOT}/bin/windres.exe")

# option, whether 
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)    
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)    
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)  
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE NEVER)  


set(CMAKE_C_FLAGS "-march=x86-64 -mtune=generic")
set(CMAKE_CXX_FLAGS "${CMAKE_C_FLAGS} -std=c++17")


# message
message(STATUS "MinGW Toolchain Configuration:")
message(STATUS "  - C Compiler: ${CMAKE_C_COMPILER}")
message(STATUS "  - C++ Compiler: ${CMAKE_CXX_COMPILER}")
message(STATUS "  - Make Program: ${CMAKE_MAKE_PROGRAM}")
message(STATUS "  - Root Path: ${CMAKE_FIND_ROOT_PATH}")


set(VCPKG_TARGET_TRIPLET x64-mingw-dynamic CACHE STRING "VCPKG Target Triplet")
include("D:/softwares/scoop/apps/vcpkg/current/scripts/buildsystems/vcpkg.cmake")
list(APPEND CMAKE_FIND_ROOT_PATH "D:/softwares/scoop/apps/vcpkg/current/installed/x64-mingw-dynamic")
