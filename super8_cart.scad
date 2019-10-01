VERSION = "V7";

OUTSIDE_WALL = 1;
CORNER_RAD = 8;
APERATURE = 10;
GATE_WIDTH = 30;    // Y
GATE_HEIGHT = 15;   // Z
DRIVE_HOLE = 15;
CENTERING_PIN = 3.5;
CENTERING_PIN_DEPTH = 5;
SCREW_HEAD = 5.3;
SCREW_SHAFT = 3;
NUT = 3;

OUTSIDE_LENGTH = 70;    // X
OUTSIDE_WIDTH = 70;     // Y
OUTSIDE_HEIGHT = 23;    // Z
BOTTOM_HEIGHT = GATE_HEIGHT;
TOP_HEIGHT = OUTSIDE_HEIGHT - GATE_HEIGHT;
INSIDE_LENGTH = OUTSIDE_LENGTH - (OUTSIDE_WALL * 2);
INSIDE_WIDTH = OUTSIDE_WIDTH - (OUTSIDE_WALL * 2);
INSIDE_HEIGHT = OUTSIDE_HEIGHT - OUTSIDE_WALL;

$fn=100;

// renders top or bottom piece (not both!) oriented for printing
//top();
bottom();

/*
// renders the top and subtracts the bottom so screw posts fit
difference(){
top();
    translate([0,OUTSIDE_WIDTH,OUTSIDE_HEIGHT]){
        rotate([0,180,180]){
            bottom();
        }
    }
}
*/


// assembles top and bottom (for display only)
bottom();
translate([0,OUTSIDE_WIDTH,OUTSIDE_HEIGHT]){
    rotate([0,180,180]){
        top();
    }
}


module prism(l, w, h){
       polyhedron(
               points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
               faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
               );
}

module screwPost(height){
    difference(){
        cylinder(r=SCREW_HEAD/1.25,h=height);
        translate([0,0,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=OUTSIDE_WALL+2);
            cylinder(r=SCREW_SHAFT/1.75,h=height+4);
        }
    }    
}

module bottom(){
    difference(){
        
        // outside box
        hull(){
            // first corner
            translate([CORNER_RAD,CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
            }
            // second corner
            translate([OUTSIDE_LENGTH - CORNER_RAD,CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
            }
            // third corner
            translate([OUTSIDE_LENGTH - CORNER_RAD,OUTSIDE_WIDTH - CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
            }
            // forth corner
            translate([CORNER_RAD,OUTSIDE_WIDTH - CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
            }
        }

        // inside box (cutout)
        translate([OUTSIDE_WALL,OUTSIDE_WALL,OUTSIDE_WALL]){
            hull(){
                // first corner
                translate([CORNER_RAD,CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
                }
                // second corner
                translate([INSIDE_LENGTH - CORNER_RAD,CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
                }
                // third corner
                translate([INSIDE_LENGTH - CORNER_RAD,INSIDE_WIDTH - CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
                }
                // forth corner
                translate([CORNER_RAD,INSIDE_WIDTH - CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=BOTTOM_HEIGHT);
                }
            }
        }
        
        // screw holes
        translate([SCREW_HEAD,SCREW_HEAD,-1]){
            cylinder(r=(SCREW_HEAD/1.75)+1,h=TOP_HEIGHT);
        }
        translate([OUTSIDE_LENGTH - SCREW_HEAD,SCREW_HEAD,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        translate([OUTSIDE_LENGTH - SCREW_HEAD,OUTSIDE_WIDTH - SCREW_HEAD,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        translate([SCREW_HEAD,OUTSIDE_WIDTH - SCREW_HEAD,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        
        // TODO: screw post clearance
        
        // gate opening
        translate([(OUTSIDE_LENGTH+OUTSIDE_WALL-OUTSIDE_WALL)-4,(OUTSIDE_WIDTH-GATE_WIDTH)-16,OUTSIDE_WALL]){
           cube([(OUTSIDE_WALL+4), GATE_WIDTH, GATE_HEIGHT]);
        }

        // take-up drive hole
        translate([(OUTSIDE_LENGTH/2)-4,OUTSIDE_WIDTH/2,-1]){
            cylinder(r=DRIVE_HOLE/2,h=OUTSIDE_WALL+2);
        }
  
        // version
        translate([(INSIDE_WIDTH/2)-10, INSIDE_WIDTH-OUTSIDE_WALL-15, OUTSIDE_WALL/2]){
            linear_extrude(height=OUTSIDE_WALL){
                text(VERSION);
            }
        }
    }
    
    // screw posts
    translate([SCREW_HEAD,SCREW_HEAD,0]){
        screwPost(BOTTOM_HEIGHT-2);
    }
    translate([OUTSIDE_LENGTH - SCREW_HEAD,SCREW_HEAD,0]){
         screwPost(BOTTOM_HEIGHT-2);
    }
    translate([OUTSIDE_LENGTH - SCREW_HEAD,OUTSIDE_WIDTH - SCREW_HEAD,0]){
         screwPost(BOTTOM_HEIGHT-2);
    }
    translate([SCREW_HEAD,OUTSIDE_WIDTH - SCREW_HEAD,0]){
        screwPost(BOTTOM_HEIGHT-2);
    }
    /*
    // camera module mount
    difference(){
        translate([(OUTSIDE_LENGTH/2),(OUTSIDE_WIDTH/2)-(25/2)+5,0]){
            cube([3,20,OUTSIDE_HEIGHT]);
        }
        translate([(OUTSIDE_LENGTH/2)-5,OUTSIDE_WIDTH/2,-1]){
            cylinder(r=DRIVE_HOLE/2,h=OUTSIDE_HEIGHT+2);
        }
    }
    */
}

module top(){
    difference(){
        
        // outside box
        hull(){
            // first corner
            translate([CORNER_RAD,CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
            }
            // second corner
            translate([OUTSIDE_LENGTH - CORNER_RAD,CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
            }
            // third corner
            translate([OUTSIDE_LENGTH - CORNER_RAD,OUTSIDE_WIDTH - CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
            }
            // forth corner
            translate([CORNER_RAD,OUTSIDE_WIDTH - CORNER_RAD,0]){
                cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
            }
        }

        // inside box (cutout)
        translate([OUTSIDE_WALL,OUTSIDE_WALL,OUTSIDE_WALL]){
            hull(){
                // first corner
                translate([CORNER_RAD,CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
                }
                // second corner
                translate([INSIDE_LENGTH - CORNER_RAD,CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
                }
                // third corner
                translate([INSIDE_LENGTH - CORNER_RAD,INSIDE_WIDTH - CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
                }
                // forth corner
                translate([CORNER_RAD,INSIDE_WIDTH - CORNER_RAD,0]){
                    cylinder(r=CORNER_RAD,h=TOP_HEIGHT);
                }
            }
        }
        
        // screw holes
        translate([SCREW_HEAD,SCREW_HEAD,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        translate([OUTSIDE_LENGTH - (SCREW_HEAD),SCREW_HEAD,-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        translate([OUTSIDE_LENGTH - (SCREW_HEAD),OUTSIDE_WIDTH - (SCREW_HEAD),-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        translate([SCREW_HEAD,OUTSIDE_WIDTH - (SCREW_HEAD),-1]){
            cylinder(r=SCREW_HEAD/1.75,h=TOP_HEIGHT);
        }
        
        // centering pin opening
        translate([OUTSIDE_WIDTH-CENTERING_PIN_DEPTH,(OUTSIDE_LENGTH/2)-(CENTERING_PIN/2),-1]){
            cube([CENTERING_PIN_DEPTH+OUTSIDE_WALL,CENTERING_PIN,TOP_HEIGHT+2]);
        }
        
        // version
        translate([(INSIDE_WIDTH/2)-10, INSIDE_WIDTH-OUTSIDE_WALL-15, OUTSIDE_WALL/2]){
            linear_extrude(height=OUTSIDE_WALL){
                text(VERSION);
            }
        }     
    }
  
    // screw posts
    translate([SCREW_HEAD,SCREW_HEAD,0]){
        screwPost(TOP_HEIGHT+2);
    }
    translate([OUTSIDE_LENGTH - (SCREW_HEAD),SCREW_HEAD,0]){
         screwPost(TOP_HEIGHT+2);
    }
    translate([OUTSIDE_LENGTH - (SCREW_HEAD),OUTSIDE_WIDTH - (SCREW_HEAD),0]){
         screwPost(TOP_HEIGHT+2);
    }
    translate([SCREW_HEAD,OUTSIDE_WIDTH - (SCREW_HEAD),0]){
        screwPost(TOP_HEIGHT+2);
    }
        
    // centering pin holder(?)
    translate([OUTSIDE_LENGTH-(CENTERING_PIN*2),(OUTSIDE_WIDTH/2)-CENTERING_PIN,0]){
        difference(){
            cube([CENTERING_PIN*2,CENTERING_PIN*2,TOP_HEIGHT]);
            translate([CENTERING_PIN_DEPTH/2,CENTERING_PIN/2,-1]){
                cube([CENTERING_PIN_DEPTH+OUTSIDE_WALL,CENTERING_PIN,TOP_HEIGHT+2]);
            }
        }
    }
}