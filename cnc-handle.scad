$fn=96;
epsilon=0.02;
handle_width=80;
handle_height=30;
metal_thick=4.8;
upper_radius=5;
lower_radius=10;

finger_thickness=35;
finger_step=23;
finger_offset=(handle_width - 3*finger_step)/2;
    
module raw_handle() {
    difference() {
	hull() {
	    cylinder(r=lower_radius, h=handle_width);
	    sphere(r=lower_radius);
	    translate([0,0,handle_width]) sphere(r=lower_radius);
	    translate([handle_height-upper_radius-lower_radius,0,0]) cylinder(r=upper_radius, h=handle_width);
	}
	translate([-6,-metal_thick/2,-lower_radius]) cube([handle_height,metal_thick,handle_width+2*lower_radius]);
    }
}

module finger_doughnut() {
    difference() {
	rotate_extrude() translate([lower_radius+finger_thickness/2, 0, 0]) circle(r=finger_thickness/2);
	translate([0,-50,-50]) cube([100,100,100]);  // cut of one half
    }
}

module handle() {
    difference() {
	raw_handle();
	for (i=[0:3]) {
	    translate([3,0,i*finger_step+finger_offset]) finger_doughnut();
	}
    }
}


// Let's have two of these, upright. Needs good support material for it to stand
// up, but should yield the strongest handle for this task.
handle();
translate([handle_height/2,upper_radius+lower_radius+2,0]) rotate([0,0,180]) handle();