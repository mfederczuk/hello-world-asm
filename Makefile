#!/usr/bin/make -f
# A Hello World program in Assembly.
# Copyright (C) 2022  Michael Federczuk
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.

SHELL = /bin/sh

AS ?= as
LD ?= ld

override source_paths := $(wildcard *.s)
override object_paths := $(source_paths:%.s=build/obj/%.o)
override artifact_name := hello_world
override artifact_path := build/bin/artifacts/$(artifact_name)


.SUFFIXES:


all: $(artifact_name)
.PHONY: all


$(object_paths): build/obj/%.o: %.s
	@mkdir -p $(@D)
	$(strip $(AS) $(ASFLAGS) $< -o $@)

$(artifact_path): $(object_paths)
	@mkdir -p $(@D)
	$(strip $(LD) $(LDFLAGS) $^ -o $@)

$(artifact_name): $(artifact_path)
	ln -sf -- $< $@


clean:
	rm -rfv -- $(artifact_name) build
.PHONY: clean
