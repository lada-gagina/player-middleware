# Install script for directory: /home/lada/Documents/player-3.0.2/config

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

if(NOT CMAKE_INSTALL_COMPONENT OR "${CMAKE_INSTALL_COMPONENT}" STREQUAL "samplecfg")
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/player/config" TYPE FILE FILES
    "/home/lada/Documents/player-3.0.2/config/afsm.cfg"
    "/home/lada/Documents/player-3.0.2/config/afsm.eps"
    "/home/lada/Documents/player-3.0.2/config/amigobot.cfg"
    "/home/lada/Documents/player-3.0.2/config/amigobot_tcp.cfg"
    "/home/lada/Documents/player-3.0.2/config/amtecM5.cfg"
    "/home/lada/Documents/player-3.0.2/config/b21r_rflex_lms200.cfg"
    "/home/lada/Documents/player-3.0.2/config/cvcam.cfg"
    "/home/lada/Documents/player-3.0.2/config/dummy.cfg"
    "/home/lada/Documents/player-3.0.2/config/erratic.cfg"
    "/home/lada/Documents/player-3.0.2/config/hokuyo_aist.cfg"
    "/home/lada/Documents/player-3.0.2/config/iwspy.cfg"
    "/home/lada/Documents/player-3.0.2/config/joystick.cfg"
    "/home/lada/Documents/player-3.0.2/config/lms400.cfg"
    "/home/lada/Documents/player-3.0.2/config/magellan.cfg"
    "/home/lada/Documents/player-3.0.2/config/mapfile.cfg"
    "/home/lada/Documents/player-3.0.2/config/mbicp.cfg"
    "/home/lada/Documents/player-3.0.2/config/nomad.cfg"
    "/home/lada/Documents/player-3.0.2/config/obot.cfg"
    "/home/lada/Documents/player-3.0.2/config/passthrough.cfg"
    "/home/lada/Documents/player-3.0.2/config/phidgetIFK.cfg"
    "/home/lada/Documents/player-3.0.2/config/phidgetRFID.cfg"
    "/home/lada/Documents/player-3.0.2/config/pioneer.cfg"
    "/home/lada/Documents/player-3.0.2/config/pioneer_rs4euze.cfg"
    "/home/lada/Documents/player-3.0.2/config/pointcloud3d.cfg"
    "/home/lada/Documents/player-3.0.2/config/readlog.cfg"
    "/home/lada/Documents/player-3.0.2/config/rfid.cfg"
    "/home/lada/Documents/player-3.0.2/config/roomba.cfg"
    "/home/lada/Documents/player-3.0.2/config/searchpattern.cfg"
    "/home/lada/Documents/player-3.0.2/config/searchpattern_symbols.ps"
    "/home/lada/Documents/player-3.0.2/config/segwayrmp.cfg"
    "/home/lada/Documents/player-3.0.2/config/service_adv.cfg"
    "/home/lada/Documents/player-3.0.2/config/simple.cfg"
    "/home/lada/Documents/player-3.0.2/config/sphere.cfg"
    "/home/lada/Documents/player-3.0.2/config/umass_ATRVJr.cfg"
    "/home/lada/Documents/player-3.0.2/config/umass_ATRVMini.cfg"
    "/home/lada/Documents/player-3.0.2/config/umass_reb.cfg"
    "/home/lada/Documents/player-3.0.2/config/urglaser.cfg"
    "/home/lada/Documents/player-3.0.2/config/vfh.cfg"
    "/home/lada/Documents/player-3.0.2/config/wavefront.cfg"
    "/home/lada/Documents/player-3.0.2/config/wbr914.cfg"
    "/home/lada/Documents/player-3.0.2/config/writelog.cfg"
    "/home/lada/Documents/player-3.0.2/config/wsn.cfg"
    )
endif()

