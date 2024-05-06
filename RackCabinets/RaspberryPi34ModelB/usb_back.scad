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


  ///////////////////////////////
 // Raspberry Pi 3 Model B    //
///////////////////////////////

print_frontplate_sml = false;
print_handle_sml     = false;
print_cabinet_sml    = false;
print_lid            = false;
print_rear           = true;

if(print_frontplate_sml){ // Frontplate //
    square_hole        = [];
    round_hole         = [[65 ,7.5, 3.1],[69.5 ,7.5, 3.1]];
    round_peg          = [];   
    screw_side_front   = [3];
    screw_top          = [];
    screw_bottom_front = [];
    units              = 6; 
    frontplate(units,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front);

}

if(print_handle_sml){ // Handle // 
    units              = 6;
    lay_flat_for_print = false;   
    handle(units,lay_flat_for_print);
}

if(print_cabinet_sml){ // Cabinet //  
    w=94;
    h=70;
    screw_bottom_front = [];
    screw_side_front   = [3];
    round_peg          = [[w,h,6,2.8,4],
                          [w-49,h,6,2.8,4],
                          [w-49,h-58,6,2.8,4],
                          [w,h-58,6,2.8,4]];
    depth              = 98;
    units              = 6;
    cabinet(depth,units,screw_bottom_front,round_peg,screw_side_front);
}

if(print_lid){ // Lid // 
    depth = 98;
    units = 6;
    screw_front = [];//mm
    screw_back  = [];//mm
    lid(98,6,screw_front,screw_back);        
}

if(print_rear){  // Back plate //    
    w=4.5;
    square_hole  = [[37-w ,3, 17, 15] , [57-w ,4, 15, 16] , [75-w,4,15,16] ];
    round_hole   = [[6,5,6],[6,1,6], [24,3.5,3.5],[24,1.2,3.5]  ,[30,3.5,3.5],[30,1.2,3.5]];
    screw_top    = [];//mm
    screw_bottom = [];//mm
    screw_side   = [3];
    depth        = 98;
    units        = 6;
    back_plate(units,depth,screw_top,screw_bottom,screw_side,square_hole,round_hole);
}  



















