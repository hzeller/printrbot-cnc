$fn=64;
epsilon=0.01;
spindle_dia = 52.4 + 0.3;
inner_spindle_dia = 26.3 + 0.3;
mount_distance = 3 * 25.4;
hole_dia=5.2;

module rounded_corner_cube(w=1,h=1,z=1,r=0.2) {
    hull() {
	translate([-w/2 + r, -h/2 + r, 0]) cylinder(r=r,h=z);
	translate([-w/2 + r, +h/2 - r, 0]) cylinder(r=r,h=z);
	translate([+w/2 - r, +h/2 - r, 0]) cylinder(r=r,h=z);
	translate([+w/2 - r, -h/2 + r, 0]) cylinder(r=r,h=z);
    }
}

module spindle() {
    translate([0,0,-epsilon]) cylinder(r=inner_spindle_dia/2, h=10);
    translate([0,0,3]) cylinder(r=spindle_dia/2, h=150);
}

module screw_mount() {
    #cylinder(r=hole_dia/2, h=20);
    translate([0,0,5]) cylinder(r=6, h=20);
    translate([0,0,-epsilon]) cylinder(r=9/2, h=3);
}

module mounting_holes() {
    translate([-mount_distance/2, -mount_distance/2, 0]) screw_mount();
    translate([-mount_distance/2, +mount_distance/2, 0]) screw_mount();
    translate([+mount_distance/2, +mount_distance/2, 0]) screw_mount();
    translate([+mount_distance/2, -mount_distance/2, 0]) screw_mount();
}

difference() {
    union() {
	rounded_corner_cube(90, 90, 5, 5);
	cylinder(r=spindle_dia/2 + 1, h=40);
	hull() {
	    cylinder(r=spindle_dia/3, h=25);
	    translate([-(90/2 - 10), -(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
	}
	hull() {
	    cylinder(r=spindle_dia/3, h=25);
	    translate([-(90/2 - 10), +(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
	}
	hull() {
	    cylinder(r=spindle_dia/3, h=25);
	    translate([+(90/2 - 10), +(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
	}
	hull() {
	    cylinder(r=spindle_dia/3, h=25);
	    translate([+(90/2 - 10), -(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
	}
    }
    mounting_holes();
    spindle();
    for (a=[0:10:180]) {
	rotate([0,0,a]) translate([0, 0, 50 + 21]) cube([100,1,100], center=true);
    }
}
