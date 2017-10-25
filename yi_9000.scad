$fn = 100;

// dimensions
radius = 46 / 2;
thickness = 3;
yi_height = 16;
yi_base_thickness = 12;
yi_base_radius = 59 / 2;

// hal height
border_height = 5;
height = yi_base_thickness + border_height; // inset size
length = 190;
width = 75;
border = 4;
speaker_height = 40;
camera_height = length - speaker_height - border * 3;
hole_spacing = 3;
panel_thickness = 2;
panel_inset = 1;

module camera() {
    translate([0, 0, yi_base_thickness / 2]) {
        cylinder(yi_base_thickness, yi_base_radius, yi_base_radius, true);
        translate([0, 0, (yi_height + yi_base_thickness) / 2]) cylinder(yi_height, radius, radius, true);
        
    }
    translate([40, 0, 4]) {
        cube([24, 12, 8], true);
        translate([110, 0, -4]) {
            rotate([0, 90, 0]) {
                translate([-3, 0, 0]) {
                    cylinder(200, 3, 3, true);
                }
                cube([6, 6, 200], true);
            }
        }
    }
}

module camera_large() {
    translate([0, 0, yi_base_thickness / 2]) {
        cylinder(yi_base_thickness, yi_base_radius, yi_base_radius, true);
        translate([0, 0, (yi_height + yi_base_thickness) / 2]) cylinder(yi_height, radius + 2, radius + 2, true);
        
    }
    translate([40, 0, 4]) {
        cube([24, 12, 8], true);
        translate([110, 0, -4]) {
            rotate([0, 90, 0]) {
                translate([-3, 0, 0]) {
                    cylinder(200, 3, 3, true);
                }
                cube([6, 6, 200], true);
            }
        }
    }
}

module case() {
    difference() {
        translate([0, 0, height / 2]) cube([length, width, height], true);

        translate([(length + speaker_height) / 2 - border - speaker_height, 0, height - border_height / 4 ]) {
            cube([speaker_height, width - 2 * border, border_height], true);
        }
            translate([-(length / 2) + camera_height / 2 + border, 0, height - border_height / 4]) cube([camera_height, width - 2 * border, border_height], true);
    }
    translate([15, 0, 1]) cylinder(15, radius + 13, radius + 4);

    translate([-75, 0, height -7]) {
        difference() {
        cube([20, width - border * 4, 10], true);
        cube([17, width - border * 4 - 2, 10], true);
        
            
        }
    }
}

module frame() {
    difference() {
        translate([0, 0, height / 2]) cube([length, width, height], true);

        // speaker cutout
        translate([(length + speaker_height) / 2 - border - speaker_height, 0, height - border_height / 4 ]) {
            cube([speaker_height, width - 2 * border, border_height * 20], true);
        }
        
        // speaker insert
        translate([(length + speaker_height) / 2 - border - speaker_height, 0, height / 2 - border_height / 2]) {
            cube([speaker_height + 2, width - 2 * border + 2, height], true);
        }
        
        // main panel cutout
        translate([-(length / 2) + camera_height / 2 + border, 0, height - border_height / 4]) cube([camera_height, width - 2 * border, border_height * 20], true);
        
        // main panel insert
        translate([-(length / 2) + camera_height / 2 + border, 0, height / 2 - border_height]) {
            cube([camera_height + 2, width - 2 * border + 2, height], true);
        }
        
        translate([15, 0, 0]) camera();
    }
    
    
    
    // support nubs
    /*
    translate([-25, width / 2 - 3, height - 1 - border_height - 2]) cube([2, 2, 2], true);
    translate([-25, -(width / 2 - 3), height - 1 - border_height - 2]) cube([2, 2, 2], true);
    translate([-length / 2 + 3, 0, height - 1 - border_height - 2]) cube([2, 2, 2], true);
    translate([48, 0, height - 1 - border_height - 2]) cube([2, 2, 2], true);
    translate([70, width / 2 - 3, height - 5.5]) cube([2, 2, 2], true);
    translate([70, -(width / 2 - 3), height - 5.5]) cube([2, 2, 2], true);
    */
    
    // frame
    translate([-length / 2 + 10, 0, 1]) {
        difference() {
            cube([16, 10, 2], true);
            hull() {
                translate([2, 0, 0]) cylinder(10, 1.5, 1.5, true);
                translate([-3, 0, 0]) cylinder(10, 1.5, 1.5, true);
            }
            translate([2, 0, 0]) cylinder(10, 3.5, 3.5, true);
        }
    }
    
    
}


module grill() {
    difference() {
        cube([speaker_height + 2, width - 2 * border + 2, 2]);

        translate([hole_spacing, hole_spacing, 0]) {
            for (x = [0: floor((width - border * 2) / hole_spacing) - 1]) {
                for (y = [0: floor(speaker_height / hole_spacing) - 1]) {
                    translate([y * hole_spacing, x * hole_spacing, 0]) {
                        cylinder(10, 1, 1);
                    }
                }
            }
        } 
    }
}








difference() {
    //case();
    //translate([15, 0, 0]) camera();
}

module main_black() {
    difference() {
        union() {
            color("blue", 50) translate([-22, 0, height - border_height]) cube([camera_height + 2, width - 2 * border + 2, 4], true);
            
             translate([12, 0, 2]) {
                 difference() {
                    cylinder(15, radius + 13, radius + 4);
                    cube([100, 100, 18], true);
                 }
                 
             }
            
        }
        
        frame();                                            
            

        color("red") translate([12, 0, 0]) camera();
    }       

    color("green") {
        translate([-75, 0, height - 2.5]) {
            difference() {
            cube([20, width - border * 4, 2], true);
            cube([17, width - border * 4 - 3, 11], true);       
            }
        }
    }
}

module ring() {
    difference() {
        union() {
            difference() {
                translate([15, 0, 1]) cylinder(15, radius + 13, radius + 4);
                translate([0, 0, 6]) cube([200, 200, 12], true);
                
            }
            translate([15, 0, 11]) cylinder(2, radius + 2, radius + 2, true);
        }
        translate([15, 0, 11]) cylinder(20, radius, radius, true);
    }
}


main_black();
//frame();
//grill();
