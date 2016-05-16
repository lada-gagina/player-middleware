# Install script for directory: /home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/lada/Downloads/player-arm")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "examples")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/examples/plugins/opaquedriver" TYPE FILE RENAME "CMakeLists.txt" FILES "/home/lada/Documents/player-3.0.2/build/examples/plugins/opaquedriver/CMakeLists.txt.example")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "examples")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/examples/plugins/opaquedriver" TYPE FILE FILES
    "/home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver/opaquedriver.cc"
    "/home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver/opaque.cfg"
    "/home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver/opaque.c"
    "/home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver/sharedstruct.h"
    "/home/lada/Documents/player-3.0.2/examples/plugins/opaquedriver/README"
    )
endif()

