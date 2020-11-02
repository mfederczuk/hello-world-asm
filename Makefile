#!/usr/bin/make -f

SHELL ?= /bin/sh
AS ?= as
LD ?= ld

TARGET = hello_world
SOURCES = hello_world.s
override OBJECTS := $(foreach __source,$(SOURCES),$(__source:%.s=%.o))

.SUFFIXES:

all: $(TARGET)
.PHONY: all

$(OBJECTS): %.o: %.s
	$(AS) $< -o $@

$(TARGET): $(OBJECTS)
	$(LD) $^ -o $@

clean:
	rm -f $(TARGET) $(OBJECTS)
