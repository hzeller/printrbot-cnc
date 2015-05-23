all: cnc-handle.stl y-endstop-trigger.stl x-switch-spacer.stl

cnc-handle.stl: cnc-handle.scad
y-endstop-trigger.stl: y-endstop-trigger.scad
x-switch-spacer.stl: x-switch-spacer.scad

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

clean:
	rm -f cnc-handle.stl
