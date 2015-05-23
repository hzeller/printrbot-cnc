// (CC-BY-SA) h.zeller@acm.org
// The x-switch is missing the rail, so there needs to be a little spacer
// underneath.

$fn=24;
epsilon=0.02;

module spacer(thick=5,hole_dist=3/8*25.4,hole_dia=3,hole_offset=2) {
    difference() {
	translate([0,0,thick/2]) cube([20,9, thick], center=true);
	translate([-hole_dist/2,hole_offset,-epsilon]) cylinder(r=hole_dia/2, h=thick+2*epsilon);
	translate([hole_dist/2,hole_offset,-epsilon]) cylinder(r=hole_dia/2, h=thick+2*epsilon);
    }
}

spacer();
translate([0,10,0]) spacer();