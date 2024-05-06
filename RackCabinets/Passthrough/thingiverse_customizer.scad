include<../sixinch_library.scad>

print_frontplate_sml = false;
print_cabinet_sml    = false;
print_lid            = false;


Vent_Length          = 22;
Vent_Frequency       = 6;
Vent_Thickness       = 3;
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
Depth                = 50; //Depth of the case min is somewhere around 98
hp                   = 4; //How many hp units you want this to be min is prob 5

if(print_frontplate_sml){ // Frontplate //
    w=boffset-gauge_box;
    square_hole        = [[25,gauge_box+2,80,hp*unit]];
    round_hole         = [];
    round_peg          = [];   
    screw_side_front   = [hp/2];
    screw_top          = [];
    screw_bottom_front = [];
    
    frontplate(hp,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front);
}

if(print_cabinet_sml){ // Cabinet //  
    w=pi_offset_x;
    h=pi_offset_y;
    screw_bottom_front = [];
    screw_side_front   = [hp/2];
    round_peg          = [];
    cabinet(Depth,hp,screw_bottom_front,round_peg,screw_side_front);
}

if(print_lid){ // Lid // 
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(Depth,hp,screw_front,screw_back);        
}