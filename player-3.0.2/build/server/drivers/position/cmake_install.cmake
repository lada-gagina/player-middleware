# Install script for directory: /home/lada/Documents/player-3.0.2/server/drivers/position

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

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/ascension/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/blobposition/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/bumpersafe/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/deadstop/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/globalize/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/goto/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/isense/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/lasersafe/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/mbicp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/microstrain/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/motionmind/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/nav200/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/nd/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/segwayrmp400/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/snd/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/roboteq/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/position/vfh/cmake_install.cmake")

endif()

