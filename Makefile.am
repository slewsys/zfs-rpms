# Makefile.am: Automake template for bash-dot-files.
#
# Process this file with automake to create Makefile.in
#
BUILD_DIR := $(dir $(realpath $(lastword $(MAKEFILE_LIST))))
ZFS_BUILD_ROOT ?= $(BUILD_DIR)

bin_SCRIPTS = zfs-rpms

AM_DEFAULT_SOURCE_EXT = .in

.PHONY: all rpms clean-local


all: rpms

help:
	@echo "Usage: make [PRS=xxx,...] [ZFS_BUILD_ROOT=$(ZFS_BUILD_ROOT)]"
	@echo "       make install [ZFS_BUILD_ROOT=$(ZFS_BUILD_ROOT)]"

rpms: zfs-rpms
	@ZFS_BUILD_ROOT=$(ZFS_BUILD_ROOT);				\
	ZFS_BRANCH=$(ZFS_BRANCH);					\
	ZFS_TAG=$(ZFS_TAG);						\
	set -o pipefail;                                                \
	$(BUILD_DIR)zfs-rpms						\
	    $${ZFS_BUILD_ROOT:+-C "$${ZFS_BUILD_ROOT}"}			\
	    $${ZFS_BRANCH:+-b "$${ZFS_BRANCH}"}				\
	    $${ZFS_TAG:+-t "$${ZFS_TAG}"}				\
	    $${PRS:+-p "$${PRS}"}					\
	    $${FORCE+-f}						\
	    $${VERBOSE+-v}						\
	    -sc

install-exec-local:
	@ZFS_BUILD_ROOT=$(ZFS_BUILD_ROOT);				\
	ZFS_BRANCH=$(ZFS_BRANCH);					\
	ZFS_TAG=$(ZFS_TAG);						\
	set -o pipefail;                                                \
	$(BUILD_DIR)zfs-rpms						\
	    $${ZFS_BUILD_ROOT:+-C "$${ZFS_BUILD_ROOT}"}			\
	    $${ZFS_BRANCH:+-b "$${ZFS_BRANCH}"}				\
	    $${ZFS_TAG:+-t "$${ZFS_TAG}"}				\
	    $${FORCE+-f}						\
	    $${VERBOSE+-v}						\
	    -i

zfs-rpms: zfs-rpms.in

clean-local:
	$(RM_CMD) -rf $(bin_SCRIPTS)
