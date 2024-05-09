/* PDU Eurorack Enclosure Generator 
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

LED_Offset           = 7;
Vent_Length          = 22;
Vent_Frequency       = 6;
Vent_Thickness       = 3;
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
Depth                = 50; //Depth of the case min is somewhere around 98
hp                   = 4; //How many hp units you want this to be min is prob 5

if(print_frontplate_sml){ // Frontplate //
    w=boffset-gauge_box;
    square_hole        = [[24.5, LED_Offset+8.5, 6, 11],
                          [39.5, LED_Offset+8.5, 6, 11],
                          [54.5, LED_Offset+8.5, 6, 11],
                          [69.5, LED_Offset+8.5, 6, 11],
                          [84.5, LED_Offset+8.5, 6, 11],
                          [99.5, LED_Offset+8.5, 6, 11],
                          ];
    round_hole         = [[27.5, LED_Offset+6.25,0.75],[27.5,LED_Offset+21.25,0.75],
                          [42.5, LED_Offset+6.25,0.75],[42.5,LED_Offset+21.25,0.75],
                          [57.5, LED_Offset+6.25,0.75],[57.5,LED_Offset+21.25,0.75],
                          [72.5, LED_Offset+6.25,0.75],[72.5,LED_Offset+21.25,0.75],
                          [87.5, LED_Offset+6.25,0.75],[87.5,LED_Offset+21.25,0.75],
                          [102.5, LED_Offset+6.25,0.75],[102.5,LED_Offset+21.25,0.75],
                          [w+20,LED_Offset,5],
                          [w+35,LED_Offset,5],
                          [w+50,LED_Offset,5],
                          [w+65,LED_Offset,5],
                          [w+80,LED_Offset,5],
                          [w+95,LED_Offset,5]];
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
    round_peg          = [[84,Depth-19,6,standoff_hole_size,6],
                          [64,Depth-10,6,standoff_hole_size,6],
                          [24,Depth-10,6,standoff_hole_size,6]
                          ];
    cabinet(Depth,hp,screw_bottom_front,round_peg,screw_side_front);
}

if(print_lid){ // Lid // 
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(Depth,hp,screw_front,screw_back);        
}

if(print_rear){  // Back plate //    
    square_hole  = [
        [26.5,0,35,5],//wire hole
        [72,0,24,9.5],//molex
    ];
    round_hole   = [];
    screw_top    = [];//mm
    screw_bottom = [];//mm
    screw_side   = [hp/2];
    back_plate(hp,Depth,screw_top,screw_bottom,screw_side,square_hole,round_hole);
}  