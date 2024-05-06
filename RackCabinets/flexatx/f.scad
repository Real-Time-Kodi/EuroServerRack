include<../sixinch_library.scad>

print_frontplate_sml = true;

Depth                = 98; //Depth of the case min is somewhere around 98
standoff_hole_size   = 2.3;//2.3 for m2.5, 2.8 for m3
hp                   = 9; //Might get away with 8
offset_y             =2.5;
gauge_box=1;

if(print_frontplate_sml){ // Frontplate //
    w=boffset+2-1;//the 2 is a magic number, sorry
    square_hole        = [
        [w+55,offset_y+1,25,31.5],//IEC
        [w+45,offset_y+14,7.3,13],//Voltage switch
        [w+79,offset_y+16.5,9,7]];//IEC Hole
    round_hole         = [
        [w+4.4,offset_y+4,4],//mount
        [w+4.4,offset_y+36,4],//mount
        [w+66.3,offset_y+37,4],//mount
        [w+77.1,offset_y+36,4],//mount
        [w+22,offset_y+20,37],//fan
        [w+88,offset_y+20,7]];//iec
    round_peg          = [];   
    screw_side_front   = [];
    screw_top          = [];
    screw_bottom_front = [];
    
    frontplate(hp,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front);
}