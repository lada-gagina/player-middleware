# Install script for directory: /home/lada/Documents/player-3.0.2/libplayercore

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

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "libraries")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib64" TYPE SHARED_LIBRARY FILES
    "/home/lada/Documents/player-3.0.2/build/libplayercore/libplayercore.so.3.0.2"
    "/home/lada/Documents/player-3.0.2/build/libplayercore/libplayercore.so.3.0"
    "/home/lada/Documents/player-3.0.2/build/libplayercore/libplayercore.so"
    )
  foreach(file
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib64/libplayercore.so.3.0.2"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib64/libplayercore.so.3.0"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib64/libplayercore.so"
      )
    if(EXISTS "${file}" AND
       NOT IS_SYMLINK "${file}")
      if(CMAKE_INSTALL_DO_STRIP)
        execute_process(COMMAND "/usr/bin/strip" "${file}")
      endif()
    endif()
  endforeach()
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "pkgconfig")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib64/pkgconfig" TYPE FILE FILES "/home/lada/Documents/player-3.0.2/build/libplayercore/playercore.pc")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/player-3.0/libplayercore" TYPE FILE FILES
    "/home/lada/Documents/player-3.0.2/libplayercore/configfile.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/device.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/devicetable.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/driver.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/drivertable.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/filewatcher.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/globals.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/message.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/playercore.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/playertime.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/plugins.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/property.h"
    "/home/lada/Documents/player-3.0.2/libplayercore/wallclocktime.h"
    )
endif()

