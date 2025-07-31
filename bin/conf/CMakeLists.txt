cmake_minimum_required(VERSION 3.16)
project(xx LANGUAGES CXX)

set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)
set(CMAKE_AUTOUIC ON)

set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(Qt6 REQUIRED COMPONENTS Quick Core QuickControls2 Concurrent Widgets QuickControls2 Gui OpenGL)

qt_standard_project_setup(REQUIRES 6.5)


# include
include_directories(
    "D:/g/pro/cpp/lib/ringbuffer"
)

# src
set(PROJECT_SRC
    main.cpp
    qml.qrc
)

qt_add_executable(hello
    ${PROJECT_SRC}
)


target_link_libraries(xx PRIVATE
    Qt6::Quick
    Qt6::Core
    Qt6::Concurrent
    Qt6::Widgets
    Qt6::QuickControls2
    Qt6::Gui
    Qt6::OpenGL
)


# install
set(CMAKE_INSTALL_PREFIX ${PROJECT_SOURCE_DIR})
install(TARGETS xx DESTINATION bin)
install(FILES "${PROJECT_SOURCE_DIR}/downloaddialog.h" DESTINATION include)

# cpack
include (InstallRequiredSystemLibraries) # windows下有用
set(CPACK_RSC_FILE_LICENSE
    "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
include(Cpack)
