# Install script for directory: /home/lada/Documents/player-3.0.2/examples/libplayerc++

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
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/examples/libplayerc++" TYPE FILE FILES
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/args.h"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/camera.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/example0.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/example4.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/grip.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/clientgraphics.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/clientgraphics3d.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/laserobstacleavoid.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/ptz.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/randomwalk.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/sonarobstacleavoid.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/speech.cc"
    "/home/lada/Documents/player-3.0.2/examples/libplayerc++/wallfollow.cc"
    )
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "examples")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/examples/libplayerc++" TYPE FILE RENAME "CMakeLists.txt" FILES "/home/lada/Documents/player-3.0.2/build/examples/libplayerc++/CMakeLists.txt.example")
endif()

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "examples")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/examples/libplayerc++" TYPE FILE FILES "/home/lada/Documents/player-3.0.2/examples/libplayerc++/README")
endif()

