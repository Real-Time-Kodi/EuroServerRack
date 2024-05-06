include<../sixinch_library.scad>

print_frontplate_sml = false;
print_cabinet_sml    = false;
print_lid            = false;
print_rear           = true;


Vent_Length          = 22;
Vent_Frequency       = 6;
Vent_Thickness       = 3;
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
Depth                = 50; //Depth of the case min is somewhere around 98
hp                   = 4; //How many hp units you want this to be min is prob 5

if(print_frontplate_sml){ // Frontplate //
    w=boffset-gauge_box;
    square_hole        = [];
    round_hole         = [[w+20,hp*2.5,5],[w+35,hp*2.5,5],[w+50,hp*2.5,5],[w+65,hp*2.5,5],
        [w+85,hp*2.5,6.5]];
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
    round_peg          = [[84,Depth-19,6,standoff_hole_size,6]];
    cabinet(Depth,hp,screw_bottom_front,round_peg,screw_side_front);
}

if(print_lid){ // Lid // 
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(Depth,hp,screw_front,screw_back);        
}

if(print_rear){  // Back plate //    
    square_hole  = [
        [10,2.5,56,10],//24
        [72,0,22,9],//molex
    ];
    round_hole   = [];
    screw_top    = [];//mm
    screw_bottom = [];//mm
    screw_side   = [hp/2];
    back_plate(hp,Depth,screw_top,screw_bottom,screw_side,square_hole,round_hole);
}  