# Install script for directory: /home/lada/Documents/player-3.0.2/server/drivers/mixed

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
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/botrics/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/clodbuster/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/cmucam2/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/epuck/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/erratic/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/evolution/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/garcia/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/irobot/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/khepera/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/mricp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/nomad/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/p2os/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/phidgetIFK/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/reb/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/rmp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/rflex/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/robotino/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/sr3000/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/swissranger/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/mixed/wbr/cmake_install.cmake")

endif()

