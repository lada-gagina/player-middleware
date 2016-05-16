CMAKE_MINIMUM_REQUIRED (VERSION 2.4 FATAL_ERROR)
PROJECT (player-driver-example)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")


# Include this CMake module to get most of the settings needed to build
SET (CMAKE_MODULE_PATH "/home/lada/Downloads/player-arm/share/cmake/Modules")
INCLUDE (UsePlayerPlugin)
INCLUDE_DIRECTORIES(/opt/trik-sdk/sysroots/arm926ejste-oe-linux-gnueabi/usr/include/qtopia/
                    /home/lada/Documents/trikRuntime/trikControl/include/
                    /home/lada/Documents/trikRuntime/trikKernel/include/)

LINK_DIRECTORIES(/opt/trik-sdk/sysroots/arm926ejste-oe-linux-gnueabi//usr/lib/
                 /home/lada/Documents/trikRuntime/bin/arm-release/)

PLAYER_ADD_PLUGIN_DRIVER (trikmotors SOURCES trikMotors.cc)

TARGET_LINK_LIBRARIES(trikmotors QtCoreE trikControl)
