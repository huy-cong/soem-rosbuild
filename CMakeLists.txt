###########################################################
#Project ref    : soem_core ros package version soem1.2.5
# File name     : CMakeLists
# File type     : build ros package
# Copyright     : Wandercraft, 151 bvd de l'Hopital, 75013, Paris	
#     HREF="http://www.wandercraft.eu"
# Status        : under development 
# Created       : March 15, 2014
# Last Modified : April 18, 2014 
# Author        : AKTER Hemia and VU  Huy Cong
# Mails         : ﻿hemia.akter@wandercraft.eu, ﻿huy-cong.vu@wandercraft.eu
# Version       : 1.0
###########################################################
cmake_minimum_required(VERSION 2.4.6)
include($ENV{ROS_ROOT}/core/rosbuild/rosbuild.cmake)

# Set the build type.  Options are:
#  Coverage       : w/ debug symbols, w/o optimization, w/ code-coverage
#  Debug          : w/ debug symbols, w/o optimization
#  Release        : w/o debug symbols, w/ optimization
#  RelWithDebInfo : w/ debug symbols, w/ optimization
#  MinSizeRel     : w/o debug symbols, w/ optimization, stripped binaries
#set(ROS_BUILD_TYPE RelWithDebInfo)

rosbuild_init()

#set the default path for built executables to the "bin" directory
set(EXECUTABLE_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/bin)
#set the default path for built libraries to the "lib" directory
set(LIBRARY_OUTPUT_PATH ${PROJECT_SOURCE_DIR}/lib)


#common commands for building c++ executables and libraries
find_path(RTNET_INCLUDE_DIR NAMES rtnet.h PATH_SUFFIXES /rtnet/include)
option(ENABLE_RTNET "Enable RTnet over Xenomai." ON)


if(RTNET_INCLUDE_DIR AND ENABLE_RTNET)
  message("Found RTNET: ${RTNET_INCLUDE_DIR}")
  include_directories(${RTNET_INCLUDE_DIR})
  add_definitions(-D RTNET)
  add_definitions(-D HAVE_RTNET)
  # try Xenomai
  execute_process(COMMAND xeno-config --skin=posix --cflags OUTPUT_VARIABLE XENO_CFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
  execute_process(COMMAND xeno-config --skin=posix --ldflags OUTPUT_VARIABLE XENO_LDFLAGS OUTPUT_STRIP_TRAILING_WHITESPACE)
  set(CMAKE_C_FLAGS "-ffunction-sections ${CMAKE_C_FLAGS} ${XENO_CFLAGS}")
  set(CMAKE_SHARED_LINKER_FLAGS "-Wl,--gc-sections ${CMAKE_SHARED_LINKER_FLAGS} -Wl,-no-as-needed ${XENO_LDFLAGS} -lrtdm")
  set(CMAKE_EXE_LINKER_FLAGS "-Wl,--gc-sections ${CMAKE_SHARED_LINKER_FLAGS} -Wl,-no-as-needed ${XENO_LDFLAGS} -lrtdm")
endif()


rosbuild_add_library(soem_core src/soem/ethercatbase.c
                          	src/soem/ethercatcoe.c
                          	src/soem/ethercatconfig.c
                          	src/soem/ethercatfoe.c
                          	src/soem/ethercatsoe.c
                          	src/soem/ethercatmain.c
                          	src/soem/ethercatprint.c
                          	src/soem/ethercatdc.c
			  				src/oshw/linux/nicdrv.c
                          	src/oshw/linux/oshw.c
			  				src/osal/linux/osal.c)


include_directories(${PROJECT_SOURCE_DIR}/src/soem
		    ${PROJECT_SOURCE_DIR}/src/osal
                    ${PROJECT_SOURCE_DIR}/src/oshw/linux
		    ${PROJECT_SOURCE_DIR}/src/osal/linux
			)

#rosbuild_add_boost_directories()
#rosbuild_link_boost(${PROJECT_NAME} thread)

if (NOT XENO_CFLAGS)
  message("Linking for non-Xenomai environment.")
  target_link_libraries(${PROJECT_NAME} rt)
else()
  message("Linking for Xenomai environment.")
endif()


