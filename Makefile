#!/usr/bin/make -f

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
