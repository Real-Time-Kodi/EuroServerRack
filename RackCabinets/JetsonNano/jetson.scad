include<../sixinch_library.scad>

print_frontplate_sml = false;
print_cabinet_sml    = false;
print_lid            = false;
print_rear           = true;


offset_x             = 0;
offset_y             = 0;
offset_z             = 4;

Vent_Length          = 85;
Vent_Frequency       = 6;
Vent_Thickness       = 3;

Depth                = 105; //Depth of the case min is somewhere around 98
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
hp                   = 6; //How many hp units you want this to be min is prob 5

if(print_frontplate_sml){ // Frontplate //
    w=offset_x+boffset+gauge_box;
    h=offset_z+1.5;//(standoff height plus board thickness)
    square_hole        = [
        [w+4.5,h,8,3],//micro usb
        [w+15,h,17,14],//ethernet
        [w+33.25,h,16,17],//usb
        [w+50.25,h,16,17],//usb
        [w+69,h,15.5,7],//HDMI
        [w+67,h+11,20,9],//DP
        [w+90,h,9.5,11.5],//Barrel
    ];
    round_hole         = [];
    round_peg          = [];   
    screw_side_front   = [hp/2];
    screw_top          = [];
    screw_bottom_front = [];
    difference() {
        frontplate(hp,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front);
        translate([w+67,h,2])       cube([20,19,1]);//extra space for DP/HDMI
        translate([w,offset_z,2])   cube([104,2,1]);//PCB too deep
    }
}

if(print_cabinet_sml){ // Cabinet //  
    w=offset_x;
    h=offset_y;
    screw_bottom_front = [];
    screw_side_front   = [hp/2];
    round_peg          = [
      [w+10,h+16,6,standoff_hole_size,offset_z],
      [w+96,h+16,6,standoff_hole_size,offset_z],
      [w+10,h+74,6,standoff_hole_size,offset_z],
      [w+96,h+74,6,standoff_hole_size,offset_z],
    ];
    cabinet(Depth,hp,screw_bottom_front,round_peg,screw_side_front);
}

if(print_lid){ // Lid // 
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(Depth,hp,screw_front,screw_back);        
}

if(print_rear){  // Back plate //    
    square_hole  = [[73,0,24,9.5]];
    round_hole   = [];
    screw_top    = [];//mm
    screw_bottom = [];//mm
    screw_side   = [hp/2];
    difference() {
        back_plate(hp,Depth,screw_top,screw_bottom,screw_side,square_hole,round_hole);
        //Cut out for the molex
        translate([boffset+73+14,gauge_box+4.75,Depth+1]) cube([28,9.5,2], center=true);
    }
}  