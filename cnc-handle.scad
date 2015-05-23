// (CC-BY-SA) h.zeller@acm.org
// Handle for the printrbot CNC, which helps not cutting your fingers while
// carrying :)
// Upright printing is the best, even if we need a little support material.
// That way, the filament is right accross the part that needs to be strong.

$fn=96;

handle_width=90;   // At the top. The lower part is longer by 2*lower_radius
handle_height=38;  // not much bigger, otherwise it does not fit in the cutout.

// Cut that fits around the metal handle.
extra_space=0.05;  // Extra space in the slot for printing. Choose for tight fit.
metal_thick=3/16 * 25.4 + extra_space;  // 3/16 in newer, 1/4 in early machines.

// Lower rand upper parts of the handle.
upper_radius=metal_thick + 0.5; // Make sure not end in entirely sharp edge.
lower_radius=12;                // Good size for fingers.

// Size and place of the 'finger doughnuts'
finger_thickness=35;
finger_step=24;        // space between fingers.
finger_offset=(handle_width - 3*finger_step)/2;
    
module raw_handle() {
    difference() {
	hull() {
	    cylinder(r=lower_radius, h=handle_width);
	    sphere(r=lower_radius);
	    translate([0,0,handle_width]) sphere(r=lower_radius);
	    translate([handle_height-upper_radius-lower_radius,0,0]) cylinder(r=upper_radius, h=handle_width);
	}
	// Cutout to slide into the metal.
	translate([-6,-metal_thick/2,-lower_radius]) cube([handle_height,metal_thick,handle_width+2*lower_radius]);
    }
}

module finger_doughnut() {
    difference() {
	rotate_extrude() translate([lower_radius+finger_thickness/2, 0, 0]) circle(r=finger_thickness/2);
	translate([0,-50,-50]) cube([100,100,100]);  // cut of one half
    }
}

module handle(cut_depth=4) {   // dut-depth so that we don't get into metal yet.
    difference() {
	raw_handle();
	for (i=[0:3]) {
	    translate([cut_depth,0,i*finger_step+finger_offset]) finger_doughnut();
	}
    }
}

// Let's have two of these, upright. Needs good support material for it to stand
// up, but should yield the strongest handle for this task.
handle();
translate([handle_height/2+2,upper_radius+lower_radius+4,0]) rotate([0,0,180]) handle();