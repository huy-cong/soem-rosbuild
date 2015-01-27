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

XENO_CONFIG=/usr/xenomai/bin/xeno-config
XENO_POSIX_CFLAGS = $(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --cflags)
XENO_POSIX_LIBS = $(shell DESTDIR=$(XENO_DESTDIR) $(XENO_CONFIG) --skin=posix --ldflags)

# Common settings
CFLAGS += -g -O0 -ffunction-sections -D XENOMAI_3
CFLAGS += $(XENO_POSIX_CFLAGS)
LDFLAGS += -Wl,--gc-sections -Wl,--no-as-needed 
LDFLAGS += $(XENO_POSIX_LIBS) 

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

