ALL_STLS=cnc-handle.stl y-endstop-trigger.stl x-switch-spacer.stl spindle-holder.stl

all: $(ALL_STLS)

cnc-handle.stl: cnc-handle.scad
y-endstop-trigger.stl: y-endstop-trigger.scad
x-switch-spacer.stl: x-switch-spacer.scad
spindle-holder.stl : spindle-holder.scad

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

clean:
	rm -f $(ALL_STLS)
