# Makefile for devel purpose. For release packaging just use meson

ifeq ($(shell id -u), 0)
	SUDO :=
else
	SUDO := sudo
endif

.PHONY: setup install compile test

setup:
	$(SUDO) xargs apm s install -y < ./build-aux/altlinux/build-deps || true
	meson setup --wipe _build -Dnightly=true --prefix=/usr

compile:
	meson compile -C _build

install: compile
	meson install -C _build
	$(SUDO) systemctl reload polkit.service
	$(SUDO) systemctl daemon-reload

test:
	meson test -C _build
