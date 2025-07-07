# cmake -DCMAKE_TOOLCHAIN_FILE=../qt-toolchain.cmake ..

set(CMAKE_SYSTEM_NAME Windows)
set(CMAKE_SYSTEM_VERSION 10)

if(NOT DEFINED QT_HOME)
    if(EXISTS "D:/qt6.8.2/6.8.2/mingw_64")
	set(QT_HOME "D:/qt6.8.2/6.8.2/mingw_64")
    elseif(EXISTS "$ENV{QTDIR}")
        set(QT_HOME "$ENV{QTDIR}")
    else()
        message(FATAL_ERROR "请通过 -DQT_HOME= 指定Qt安装路径")
    endif()
endif()


set(CMAKE_C_COMPILER "${QT_HOME}/bin/gcc.exe")
set(CMAKE_CXX_COMPILER "${QT_HOME}/bin/g++.exe")
set(CMAKE_RC_COMPILER "${QT_HOME}/bin/windres.exe")
set(CMAKE_MAKE_PROGRAM "${QT_HOME}/bin/mingw32-make.exe")


list(APPEND CMAKE_PREFIX_PATH "${QT_HOME}")
set(Qt6_DIR "${QT_HOME}/lib/cmake/Qt6")


set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)


set(CMAKE_FIND_ROOT_PATH "${QT_HOME}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

message(STATUS "====================================")
message(STATUS "Qt工具链配置信息：")
message(STATUS "Qt路径: ${QT_HOME}")
message(STATUS "C编译器: ${CMAKE_C_COMPILER}")
message(STATUS "C++编译器: ${CMAKE_CXX_COMPILER}")
message(STATUS "====================================")
