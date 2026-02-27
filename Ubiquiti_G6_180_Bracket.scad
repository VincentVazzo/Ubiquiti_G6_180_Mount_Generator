/* Parameterized Camera Soffit Mount - 2D for Laser Cutting */

/* [Base Dimensions] */

// Overall length of the mounting physical plate (mm)
plate_length = 230; // [100:1:500]

/* [Hole Configuration] */

// Automatically center the holes on the physical plate?
center_holes = true; 

// If not centered, distance from the LEFT gutter edge to the holes (mm)
distance_from_edge = 50; // [10:1:200]

/* [Soffit Gutter Zone] */

// Width of the restricted zone on BOTH ends tucking into the soffit (Set to 0 to disable)
gutter_width = 30; // [0:1:150]

/* [Debug] */

// Show a red highlight over the gutter zones to verify clearances? (Turn off before export)
show_gutter_debug = false; 

/* [Hidden] */
// --- Everything below this line is hidden from the Control Panel ---

// Radius of the outside corners (mm)
corner_radius = 7; // [0:0.5:20]

// Diameter of the mounting holes (mm)
hole_diameter = 4; // [2:0.1:10]

// Width of the mounting plate (mm)
plate_width = 100; // [50:1:200]

// Fixed Component Dimensions
hole_top_offset = 14.625;    
hole_bottom_offset = 15.375; 
slot_width = 33;
slot_height = 20;

// Rendering Resolution
$fn = 64; 

// --- Calculated Variables ---
hole_x_pos = center_holes ? 0 : (-plate_length / 2) + gutter_width + distance_from_edge;

// --- Main 2D Model ---

union() {
    difference() {
        rounded_rect(plate_length, plate_width, corner_radius);
        
        translate([hole_x_pos, 0]) {
            translate([0, (plate_width / 2) - hole_top_offset]) circle(d = hole_diameter);
            translate([0, -(plate_width / 2) + hole_bottom_offset]) circle(d = hole_diameter);
            pill_slot(slot_width, slot_height);
        }
    }
    
    // Debug Gutter Overlays (Left and Right)
    if (show_gutter_debug && gutter_width > 0) {
        color("red", 0.3) {
            // Left Gutter
            translate([-plate_length / 2, -plate_width / 2]) 
                square([gutter_width, plate_width]);
                
            // Right Gutter
            translate([(plate_length / 2) - gutter_width, -plate_width / 2]) 
                square([gutter_width, plate_width]);
        }
    }
}

// --- Helper Modules ---
module rounded_rect(w, h, r) {
    hull() {
        translate([-w/2 + r, -h/2 + r]) circle(r=r);
        translate([w/2 - r, -h/2 + r]) circle(r=r);
        translate([-w/2 + r, h/2 - r]) circle(r=r);
        translate([w/2 - r, h/2 - r]) circle(r=r);
    }
}

module pill_slot(w, h) {
    r = h / 2;
    straight_w = w - h; 
    hull() {
        translate([-straight_w/2, 0]) circle(r=r);
        translate([straight_w/2, 0]) circle(r=r);
    }
}
