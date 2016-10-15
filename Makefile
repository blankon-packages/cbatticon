# Makefile for GNU ed - The GNU line editor
# Copyright (C) 2006, 2007, 2008, 2009, 2010, 2011, 2012
# Antonio Diaz Diaz.
# This file was generated automatically by configure. Do not edit.
#
# This Makefile is free software: you have unlimited permission
# to copy, distribute and modify it.

pkgname = cbatticon
pkgversion = 1.4.0
progname = cbatticon
VPATH = .
prefix = /usr
exec_prefix = $(prefix)
bindir = $(exec_prefix)/bin
datadir = $(prefix)/share
mandir = ${prefix}/share/man
sysconfdir = /etc
program_prefix = 
CC = gcc
CPPFLAGS = 
CFLAGS = -Wall -W -O2
LDFLAGS = 
##
## to set by the user
##
# verbosity, 0 for off, 1 for on (default off)
V = 0
# whether to link against gtk+3 or gtk+2 (default gtk+2)
WITH_GTK3 = 1
# libnotify support, 0 for off, 1 for on (default on)
WITH_NOTIFY = 1

ifeq ($(V),0)
VERBOSE=@
else
VERBOSE=
endif

# programs
CC ?= gcc
PKG_CONFIG ?= pkg-config
RM = rm -f
INSTALL = install
INSTALL_BIN = $(INSTALL) -m755
INSTALL_DATA = $(INSTALL) -m644

# flags and libs
ifeq ($(WITH_NOTIFY),1)
CPPFLAGS += -DWITH_NOTIFY
endif

CFLAGS ?= -O2
CFLAGS += -Wall -Wno-format -std=c99
CFLAGS += $(shell $(PKG_CONFIG) --cflags $(PKG_DEPS))

ifeq ($(WITH_GTK3), 1)
PKG_DEPS = gtk+-3.0
else
PKG_DEPS += glib-2.0
endif
ifeq ($(WITH_NOTIFY),1)
PKG_DEPS += libnotify
endif
LIBS += $(shell $(PKG_CONFIG) --libs $(PKG_DEPS)) -lm

# variables
PACKAGE_NAME = cbatticon
VERSION = $(shell grep CBATTICON_VERSION_NUMBER cbatticon.c | awk '{print $$3}')
PREFIX ?= /usr
BINDIR = $(PREFIX)/bin
DATADIR = /etc/xdg/autostart

BIN = $(PACKAGE_NAME)
SOURCEFILES := $(wildcard *.c)
OBJECTS := $(patsubst %.c,%.o,$(SOURCEFILES))

$(BIN): $(OBJECTS)
	@echo -e '\033[1;31mLinking CC executable $@\033[0m'
	$(VERBOSE) $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LIBS)

$(OBJECTS): $(SOURCEFILES)
	@echo -e '\033[0;32mBuilding CC object $@\033[0m'
	$(VERBOSE) $(CC) -c $(CFLAGS) $(CPPFLAGS) -o $@ $<

install: $(BIN)
	@echo -e '\033[1;33mInstalling $(PACKAGE_NAME)\033[0m'
	$(VERBOSE) $(INSTALL) -d "$(DESTDIR)$(BINDIR)"
	$(VERBOSE) $(INSTALL_BIN) $(BIN) "$(DESTDIR)$(BINDIR)"/
	$(VERBOSE) $(INSTALL_BIN) cbatticon.launch "$(DESTDIR)$(BINDIR)"/
	$(VERBOSE) $(INSTALL) -d "$(DESTDIR)$(DATADIR)"
	$(VERBOSE) $(INSTALL_DATA) cbatticon.desktop "$(DESTDIR)$(DATADIR)"/

uninstall:
	@echo -e '\033[1;33mUninstalling $(PACKAGE_NAME)\033[0m'
	$(VERBOSE) $(RM) "$(DESTDIR)$(BINDIR)"/$(BIN)
	$(VERBOSE) $(RM) "$(DESTDIR)$(DATADIR)"/cbatticon.desktop

clean :
	@echo -e '\033[1;33mCleaning up source directory\033[0m'
	$(VERBOSE) $(RM) $(BIN) $(OBJECTS)

.PHONY: install uninstall clean
