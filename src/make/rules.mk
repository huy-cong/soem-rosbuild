#******************************************************************************
#                *          ***                    ***
#              ***          ***                    ***
# ***  ****  **********     ***        *****       ***  ****          *****
# *********  **********     ***      *********     ************     *********
# ****         ***          ***              ***   ***       ****   ***
# ***          ***  ******  ***      ***********   ***        ****   *****
# ***          ***  ******  ***    *************   ***        ****      *****
# ***          ****         ****   ***       ***   ***       ****          ***
# ***           *******      ***** **************  *************    *********
# ***             *****        ***   *******   **  **  ******         *****
#                           t h e  r e a l t i m e  t a r g e t  e x p e r t s
#
# http://www.rt-labs.com
# Copyright (C) 2006. rt-labs AB, Sweden. All rights reserved.
#------------------------------------------------------------------------------
# $Id: rules.mk 414 2012-12-03 10:48:42Z rtlaka $
#------------------------------------------------------------------------------

# Compiler specific settings
include $(PRJ_ROOT)/make/compilers/$(CROSS_GCC)-gcc.mk

# Include paths
DEFAULT_INC_PATH += $(PRJ_ROOT)/osal
DEFAULT_INC_PATH += $(PRJ_ROOT)/osal/$(BSP)
DEFAULT_INC_PATH += $(PRJ_ROOT)/oshw/$(BSP)
DEFAULT_INC_PATH += $(PRJ_ROOT)/soem

INC_PATH = $(DEFAULT_INC_PATH) $(CC_INC_PATH) $(EXTRA_INCLUDES)
INC_PATHS = $(patsubst %,-I"%",$(INC_PATH))

# Library paths
LD_PATH += $(LIBDIR)
LD_PATH += $(EXTRA_LD_PATHS)

LD_PATHS = $(patsubst %,-L%,$(LD_PATH))

# Dependency generation
CFLAGS += -MMD -MP -MF"$(@:%.o=%.d)" -MT"$(@:%.o=%.d)"

# Common settings
CFLAGS += -g -O0 -ffunction-sections -D RTNET -I/usr/xenomai/include -D_GNU_SOURCE -D_REENTRANT -D__XENO__ -I/usr/xenomai/include/posix
LDFLAGS += -Wl,--gc-sections -Wl,--no-as-needed -lnative -Wl,@/usr/xenomai/lib/posix.wrappers -L/usr/xenomai/lib -lrtdm -lpthread_rt -lxenomai -lpthread -lrt

# Command-line overrides
CFLAGS   += $(EXTRA_CFLAGS)
CPPFLAGS += $(EXTRA_CPPFLAGS)
LDFLAGS  += $(EXTRA_LDFLAGS)


SILENT=@

# Rules

.SUFFIXES:

$(OBJDIR)/%.o: %.S
	@echo --- Assembling $<
	$(SILENT)$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

$(OBJDIR)/%.o: %.c
	@echo --- Compiling $<
	$(SILENT)$(CC) $(CFLAGS) $(INC_PATHS) -c $< -o $@

$(OBJDIR)/%.o: %.cpp
	@echo --- Compiling $<
	$(SILENT)$(CC) $(CFLAGS) $(CPPFLAGS) $(INC_PATHS) -c $< -o $@

