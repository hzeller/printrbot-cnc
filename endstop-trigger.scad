// This endstop trigger acts as trigger for the switches but also
// as mechanical endstop for the carriage to hit (thus not put the load on
// the switch).

$fn=48;
epsilon=0.02;

// TODO: these values are entirely out of thin air. Actually measure
// them on the device.
screw_distance=1.5 * 25.4;
screw_dia=8.3;
screw_head_dia=14;
screw_recess=4.5;

block_length=screw_distance + screw_head_dia+1;
block_thick=23;  // good to go up enough to iht
block_width=38;   // as wide as the aluminum profile.
block_round_radius=8.1;

rail_thick=3.5;    // The rail in the aluminum extrusion we're sitting in.
rail_wide=8.0;

switch_block_extension=4.4; // how far it extends to engage switch
switch_block_offset=1;    // offset from center

module screw() {
    translate([0,0,-screw_recess]) cylinder(r=screw_head_dia/2, h=screw_recess+10);
    translate([0,0,-30]) cylinder(r=screw_dia/2,h=30);
}

module half_sphere(r=1) {
    difference() {
	sphere(r=r);
	translate([0,0,-r/2]) cube([2*r+epsilon,2*r+epsilon,r+epsilon], center=true);
    }
}

module block(switch_left=true,switch_block_width=block_width/2-switch_block_offset,big_length=block_length/2,small_width=block_width/3) {
    hull() {
	translate([0,-block_width/2,0]) cube([5, block_width, block_thick]);
	translate([block_length-5, 3, 0]) half_sphere(r=block_round_radius);
	translate([block_length-5, -3, 0]) half_sphere(r=block_round_radius);
    }
    
    if (switch_left) {
	translate([-switch_block_extension,switch_block_offset,0]) cube([switch_block_extension+5, switch_block_width, block_thick]);
    } else {
	translate([-switch_block_extension,-switch_block_width-switch_block_offset,0]) cube([switch_block_extension+5, switch_block_width, block_thick]);
    }

    // rail
    translate([0,-rail_wide/2,-rail_thick]) cube([block_length, rail_wide, rail_thick+epsilon]);
}

module endstop_trigger(left_switch=true) {
    difference() {
	block(left_switch);
	translate([(block_length-screw_distance)/2,0,block_thick]) screw();
	translate([(block_length-screw_distance)/2+screw_distance,0,block_thick/2]) screw();
    }
}

// Upright might be more sturdy as we are less pronce to layer delamination
// in the direction  of force (but screw-hole printing is a bit more
// overhang prone).
module print_upright() {
    rotate([0,-90,0]) {
	endstop_trigger(left_switch=true);
	translate([0,block_width+2,0]) endstop_trigger(left_switch=false);
    }
}

print_upright();

