###########################################################
#Project ref   : soem_core ros package version soem1.3.0
# File name     : Make file
# File type     : build ros package
# Copyright     : Wandercraft, 151 bvd de l'Hopital, 75013, Paris	
#     HREF="http://www.wandercraft.eu"
# Status        : under development 
# Created       : December 04, 2014
# Author        : VU  Huy Cong
# Mails         : ﻿﻿huy-cong.vu@wandercraft.eu
# Version       : 1.0
###########################################################
EXTRA_CMAKE_FLAGS=-DENABLE_RTNET=ON
include $(shell rospack find mk)/cmake.mk

wipe: clean
	-rm -rf $(SOURCE_DIR)

