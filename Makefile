all: cnc-handle.stl endstop-trigger.stl

cnc-handle.stl: cnc-handle.scad
endstop-trigger.stl: endstop-trigger.scad

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

clean:
	rm -f cnc-handle.stl
