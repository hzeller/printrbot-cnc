cnc-handle.stl: cnc-handle.scad

%.stl: %.scad
	openscad -o $@ -d $@.deps $<

clean:
	rm -f cnc-handle.stl
