// -*- mode: scad; c-basic-offset: 2; indent-tabs-mode: nil; -*-
$fn=128;
epsilon=0.01;
spindle_dia = 52.35 + 0.2;
inner_spindle_dia = 26.3 + 0.2;

wall_thickness=2;
support_height=70;
stabilizer_height=50;

transition_start=40;
transition_height=12;

// Screw holes
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
  translate([0,0,6]) cylinder(r=spindle_dia/2, h=150);
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

module spindle_holder() {
  difference() {
    union() {
      rounded_corner_cube(90, 90, 5, 5);
      // Bottom part
      cylinder(r=spindle_dia/2 + wall_thickness, h=transition_start);

      // Transition
      translate([0, 0, transition_start - epsilon])
        cylinder(r=spindle_dia/2 + wall_thickness, h=transition_height+2*epsilon, $fn=12);

      // Top part
      translate([0, 0, transition_start + transition_height])
        cylinder(r=spindle_dia/2 + wall_thickness, h=support_height - transition_start - transition_height);
      hull() {
        cylinder(r=spindle_dia/3, h=stabilizer_height);
        translate([-(90/2 - 10), -(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
      }
      hull() {
        cylinder(r=spindle_dia/3, h=stabilizer_height);
        translate([-(90/2 - 10), +(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
      }
      hull() {
        cylinder(r=spindle_dia/3, h=stabilizer_height);
        translate([+(90/2 - 10), +(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
      }
      hull() {
        cylinder(r=spindle_dia/3, h=stabilizer_height);
        translate([+(90/2 - 10), -(90/2 - 10), 0]) rounded_corner_cube(20, 20, 5, 5);
      }
    }

    translate([0,0, transition_start - epsilon])
      cylinder(r=spindle_dia/2+0.9, h=transition_height + 2*epsilon, $fn=12);
    mounting_holes();
    #spindle();
    // Only a small guide for the saw to grip
    for (a=[0:30:180]) {
      rotate([0,0,a])
        translate([0, 0,support_height + 50 - 1])
        cube([100,1,100], center=true);
    }
  }
}


module mini_test() {
  intersection() {
    spindle_holder();
    cylinder(r=spindle_dia/2 + wall_thickness + 1,h=20);
  }
}

spindle_holder();
