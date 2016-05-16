# Install script for directory: /home/lada/Documents/player-3.0.2

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

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "headers")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/player-3.0" TYPE FILE FILES "/home/lada/Documents/player-3.0.2/build/playerconfig.h")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/lada/Documents/player-3.0.2/build/libplayercommon/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayerinterface/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/client_libs/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayercore/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/config/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayerwkb/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayerjpeg/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayertcp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/libplayersd/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/rtk2/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/examples/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/utils/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/doc/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/cmake/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/replace/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/home/lada/Documents/player-3.0.2/build/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
