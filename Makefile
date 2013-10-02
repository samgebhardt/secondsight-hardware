# Makefile for creating the aetherAR viewer

STLS=\
	 visor-A.stl\
	 visor-B.stl\
	 visor-C.stl\
	 visor-assembled.stl

SOURCES=\
	visor.scad\
	visor_body.scad\
	visor_elastic_mount.scad\
	visor_optics_mount.scad \
	lenses.scad

# This is system-specific
OPENSCAD=/usr/local/bin/openscad
SLIC3R=~/3rdparty_sandbox/MM/Slic3r/bin/slic3r

all: $(STLS)

# Create STL files from OpenSCAD files
%.stl: %.scad
	$(OPENSCAD) -o $@ $<

# Create STL files from OpenSCAD files
%.gcode: %.stl config.ini
	$(SLIC3R) --load config.ini -o $@ $<

visor.stl: $(SOURCES) Makefile

visor-A.stl: $(SOURCES) Makefile
	$(OPENSCAD) -D 'variant="A"' -D 'part="both"' -o $@ $<

visor-B.stl: $(SOURCES) Makefile
	$(OPENSCAD) -D 'variant="B"' -D 'part="both"' -o $@ $<

visor-C.stl: $(SOURCES) Makefile
	$(OPENSCAD) -D 'variant="C"' -D 'part="both"' -o $@ $<

visor-assembled.stl: $(SOURCES) Makefile
	$(OPENSCAD) -D 'variant="A"' -D 'part="assembled"' -o $@ $<

test.stl: $(SOURCES) Makefile
	$(OPENSCAD) -D 'variant="test"' -o $@ $<

.PHONY: clean
.SECONDARY:

clobber:
	rm *.stl *.gcode
