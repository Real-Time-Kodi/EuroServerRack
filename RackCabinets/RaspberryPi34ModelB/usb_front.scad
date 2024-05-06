/* Raspberry Pi Eurorack Enclosure Generator 
 * Modified for purpose by @realtimekodi
 * https://github.com/Real-Time-Kodi/EuroServerRack/
 * Initially designed by KronBjorn
 * https://github.com/KronBjorn/SixInchRack
 * 
 * Creative Commons 4.0 Share Alike With Attribution -- Non-Comercial
 * http://creativecommons.org/licenses/by-nc-sa/4.0/
*/
include<../sixinch_library.scad>

print_frontplate_sml = false;
print_cabinet_sml    = false;
print_lid            = false;
print_rear           = true;


Vent_Length          = 65;
Vent_Frequency       = 6;
Vent_Thickness       = 3;

Pi_Version           = "-"; // [3:B+2B+3B+, 4:4B]
Front_plate_holes    = "-"; // [2:2, 4:4]
Depth                = 98; //Depth of the case min is somewhere around 98
pi_offset_x          = 12;//minimum probably 10, 12 if using hats
pi_offset_y          = 24.5;//exactly where you want to be for front ports(24.5)
pi_offset_z          = 4;//minimum probably 4
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
hp                   = 6; //How many hp units you want this to be min is prob 5

if(print_frontplate_sml){ // Frontplate //
    w=boffset+pi_offset_x-gauge_box;
    square_hole_3        = [ [37+w,pi_offset_z+0.5,17,15] , [20+w,pi_offset_z+1.5,15,16] , [2+w,pi_offset_z+1.5,15,16]];//3b+
    square_hole_4    = [ [2+w,pi_offset_z+0.5,17,15] , [22+w,pi_offset_z+1.5,15,16] , [40+w,pi_offset_z+1.5,15,16]];
    
    round_hole         = [];
    round_peg          = [];   
    screw_side_front   = [3];
    screw_top          = [];
    screw_bottom_front = [];
    
    square_hole = Pi_Version == "3" ? square_hole_3 : square_hole_4;
    
    frontplate(hp,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front);
}

if(print_cabinet_sml){ // Cabinet //  
    w=pi_offset_x;
    h=pi_offset_y;
    screw_bottom_front = [];
    screw_side_front   = [3];
    round_peg          = [[w,h,6,standoff_hole_size,pi_offset_z],
                          [w+49,h,6,standoff_hole_size,pi_offset_z],
                          [w+49,h+58,6,standoff_hole_size,pi_offset_z],
                          [w,h+58,6,standoff_hole_size,pi_offset_z]];
    difference(){
        cabinet(Depth,hp,screw_bottom_front,round_peg,screw_side_front);
        //sd card access
        translate([w+boffset+gauge_box+24,0,h+58+gauge+7]) cube(size = [16,9,19], center=true);
    }

}

if(print_lid){ // Lid // 
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(Depth,hp,screw_front,screw_back);        
}

if(print_rear){  // Back plate //    
    square_hole  = [[73,0,24,9.5]];
    round_hole   = [[65,1,6],[65,5,6]];
    screw_top    = [];//mm
    screw_bottom = [];//mm
    screw_side   = [3];
    difference() {
        back_plate(hp,Depth,screw_top,screw_bottom,screw_side,square_hole,round_hole);
        //Cut out for the molex
        translate([boffset+73+14,gauge_box+4.75,Depth+1]) cube([28,9.5,2], center=true);
    }
}  