# Install script for directory: /home/lada/Documents/player-3.0.2/server/drivers/camera

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
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/v4l/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/v4l2/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/1394/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/camfilter/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/compress/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/cvcam/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/gstreamer/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/imageseq/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/imgcmp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/imgsave/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/sphere/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/uvc/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/yarp/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/unicap/cmake_install.cmake")
  include("/home/lada/Documents/player-3.0.2/build/server/drivers/camera/videocanny/cmake_install.cmake")

endif()

