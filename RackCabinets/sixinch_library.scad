/* Eurorack Enclosure Generator 
 * Modified for purpose by @realtimekodi
 * https://github.com/Real-Time-Kodi/EuroServerRack/
 * Initially designed by KronBjorn
 * https://github.com/KronBjorn/SixInchRack
 * 
 * Creative Commons 4.0 Share Alike With Attribution -- Non-Comercial
 * http://creativecommons.org/licenses/by-nc-sa/4.0/
*/


$fn = 50*1;



//Constants, do not change !
sixinch     = 128.5*1;       //Total width of cover plate
rackhole    = 122.5*1;  //sixinch-6; //Distance between rack holes
width       = 110;   // size of box behind the cover plate
unit        = 5; // HP unit height(5.08 but we want wiggle room)
gauge       = 3*1;
gauge_box   = 2*1;
boffset     = (sixinch-width)/2;//used for setting the center

// Default Vent Params
Vent_Length    = 30;
Vent_Thickness = 2;
Vent_Frequency = 8;

//Cabinet screws in mm. They can be changed a little
screw_head        = 7.4; 
screw_head_height = 2.2;  
screw_dia         = 3.3;   
screw_hole        = 2.99; 
screw_length      = 18;
nut_4mm           = 8.1; 
slip              = 0.35;
rack_screwhole    = 3.5;//Usually m3 + 0.5 for space


module chimney() {    
for(i=[0:Vent_Frequency:80]){
    echo(i);
    translate([boffset + (width-80)/2  +i,-1,10]){
        minkowski(){
            cube([0.01,200,Vent_Length]);    
            sphere(d=Vent_Thickness,h=1);        
        }
    }
}
}



 
     
 module back_plate(u,dp,screw_top,screw_bottom,screw_side,square_hole,round_hole){
    
     difference(){
        union(){
            translate([boffset+gauge_box+slip,gauge_box+slip,gauge+dp-gauge_box]){
                cube([width-2*gauge_box-2*slip, u*unit-2*gauge_box-2*slip, gauge_box]);
            }
        }
     
     //Square holes
        for(i=[0:len(square_hole)-1]){
            x = square_hole[i][0];
            y = square_hole[i][1];
            w = square_hole[i][2];
            h = square_hole[i][3];            
            translate([x+boffset+gauge_box,y+gauge_box,dp-1]){cube([w,h,gauge+2]);}        
        } 
    
    //Round holes
    if(len(round_hole)>0){
        for(i=[0:len(round_hole)-1]){
            x = round_hole[i][0];
            y = round_hole[i][1];
            dia = round_hole[i][2];
            translate([boffset+gauge_box+x,gauge_box+y,dp-4]){  cylinder(d=dia,h=10); }
        }
    }
        
    
    //Screw holes
    if(len(screw_top)>0){
        for(i=[0:len(screw_top)-1]){
            p = screw_top[i];
            translate([p,unit*u-gauge_box-4,gauge+dp+0.1]){rotate([0,180,0]){screw();}}
            translate([sixinch-p,unit*u-gauge_box-4,gauge+dp+0.1]){rotate([0,180,0]){screw();}} 
        }
    }
    if(len(screw_bottom)>0){
        for(i=[0:len(screw_bottom)-1]){
            p = screw_bottom[i]; 
            translate([p,gauge_box+4     ,gauge+dp+0.1]){rotate([0,180,0]){screw();}}
            translate([sixinch-p,    gauge_box+4    ,gauge+dp+0.1]){rotate([0,180,0]){screw();}} 
        }
    }
    
    if(len(screw_side)>0){
        for(i=[0:len(screw_side)-1]){
            p = screw_side[i];  
            translate([sixinch-boffset-6,    unit*p    ,gauge+dp+0.1]){rotate([0,180,0]){screw();}} 
            translate([boffset+6,    unit*p    ,gauge+dp+0.1]){rotate([0,180,0]){screw();}}   
        }
    }
}
}

 
 


module peg(x,y,od,id,he){
    translate([x,y,0]){
        rotate([-90,0,0]){
            difference(){
                cylinder(r=od/2,h=he);
                translate([0,0,-0.5]){cylinder(r=id/2,h=he+1);}
            }        
        }
    }
}



module screwtrap(){  
    difference(){
        translate([0,0,5]){
            intersection(){
                scale([1,1,0.7]){
                    sphere(r=8);     
                }   
                translate([0,-0.001,-10]){  cube([20,20,20]);}
            }
        }  
        translate([2,4,5]){
            rotate([90,90,90]){
               translate([0,0,-10]){ cylinder(r=screw_dia/2,h=20,$fn=100);}
            }
        }    
    }
}





module nuttrap(){
    difference(){
        linear_extrude(10){
            polygon(points=[[0,0],[8,0],[2,8],[0,8]]);
        }
        translate([2,4,5]){
            rotate([90,90,90]){
                cylinder(r=nut_4mm/2,h=20,$fn=6);
            }
        }
        translate([2,4,5]){
            rotate([90,90,90]){
               translate([0,0,-10]){ cylinder(r=screw_dia/2,h=20,$fn=100);}
            }
        }
    }
}








module cabinet (dp,u,screw_bottom_front,round_peg,screw_side_front){
    difference(){
        box(dp,u,screw_bottom_front,round_peg,screw_side_front);
               

              
        }
       
    }





module box(dp,u,screw_bottom_front,round_peg,screw_side_front){
    difference(){
        translate([boffset,0,gauge]){
            difference(){
                cube([width,u*unit,dp]);
                translate([gauge_box,gauge_box,-1]){ cube([width-gauge_box*2,u*unit,dp+2]);}                        
            }            
        }
        //CHIMNEY(Air Slots)
        chimney(); 
    }
    
    //Screw mounts on the bottom plate
    if(len(screw_bottom_front)>0){
        for(i=[0:len(screw_bottom_front)-1]){
            p = screw_bottom_front[i];
            translate([p+5,gauge_box,gauge]){rotate([0,-90,0]){screwtrap();}}
            translate([sixinch-p+5,gauge_box,gauge]){rotate([0,-90,0]){screwtrap();}}        
            translate([p-5,gauge_box,gauge+dp-gauge_box]){rotate([0,90,0]){screwtrap();}}
            translate([sixinch-p-5,gauge_box,gauge+dp-gauge_box]){rotate([0,90,0]){screwtrap();}}
       }
   }
    
   //Screw mounts on the side of cabinet
   if(len(screw_side_front)>0){
        for(i=[0:len(screw_side_front)-1]){
            p = screw_side_front[i]*unit;
                translate([boffset+gauge_box,p-5,gauge]){rotate([0,-90,-90]){screwtrap();}}
                translate([sixinch-boffset-gauge_box,p+5,gauge]){rotate([0,-90,90]){screwtrap();}}    
                translate([boffset+gauge_box,p+5,gauge+dp-gauge_box]){rotate([0,90,-90]){screwtrap();}}
                translate([sixinch-boffset-gauge_box,p-5,gauge+dp-gauge_box]){rotate([0,90,90]){screwtrap();}}    
        }
    }
    
    //Screw mounts for lid. Two on each side, three if dp>90
    translate([boffset+gauge_box,unit*u-gauge_box,gauge+10]){rotate([0,0,-90]){screwtrap();}}
    translate([boffset+gauge_box,unit*u-gauge_box,gauge+dp-10-10]){rotate([0,0,-90]){screwtrap();}}            
    translate([sixinch-boffset-gauge_box,unit*u-gauge_box,gauge+10+10]){rotate([180,0,-90]){screwtrap();}}
    translate([sixinch-boffset-gauge_box,unit*u-gauge_box,gauge+dp-10-10+10]){rotate([180,0,-90]){screwtrap();}}
    if(dp>90){
        translate([sixinch-boffset-gauge_box,unit*u-gauge_box,gauge+dp/2-5+10]){rotate([180,0,-90]){screwtrap();}}
        translate([boffset+gauge_box,unit*u-gauge_box,gauge+dp/2-5]){rotate([0,0,-90]){screwtrap();}}
    }
        
    //Lid rest bar 
    translate([boffset+gauge_box,unit*u-3-gauge_box,gauge]){
        linear_extrude(dp-gauge_box){polygon (points=[[0,0],[3,3],[0,3]]);}
    }
    translate([sixinch-boffset-gauge_box,unit*u-3-gauge_box,gauge]){
        linear_extrude(dp-gauge_box){polygon (points=[[0,0],[-3,3],[0,3]]);}
    }
        
    // Back/front rest bar
    translate([0,0,dp+gauge-2-gauge_box]){
        difference(){
            translate([boffset,0,0]){  cube([width,unit*u-gauge_box,2]);  }
            translate([boffset+gauge_box+2,gauge_box+2,-1]){  cube([width-2*gauge_box-4,unit*u,4]);  }        
        }
    }
              
    //PEGS Relative to inside corner
    translate([boffset+gauge_box,0,gauge]){ 
        if(len(round_peg)>0){
            for(i=[0:len(round_peg)-1]){
                x = round_peg[i][0];
                y = round_peg[i][1];
                od = round_peg[i][2];
                id = round_peg[i][3];  
                he = round_peg[i][4];      
                translate([x,0,y]){peg(0,0,od,id,he); }
             }        
        }
    }    
}


module lid(dp,u,screw_front,screw_back){    

    difference(){
    union(){ 
        if(len(screw_front)>0){
            for(i=[0:len(screw_front)-1]){                                
                p = screw_front[i];                
                translate([p-5,unit*u-gauge_box,gauge]){rotate([0,-90,180]){screwtrap();}}
                translate([sixinch-p-5,unit*u-gauge_box,gauge]){rotate([0,-90,180]){screwtrap();}}
            }
        }        
        if(len(screw_back)>0){
            for(i=[0:len(screw_back)-1]){                                
                p = screw_back[i];                                
                translate([p+5,unit*u-gauge_box,gauge+dp-gauge_box]){rotate([0,90,180]){screwtrap();}}
                translate([sixinch-p+5,unit*u-gauge_box,gauge+dp-gauge_box]){rotate([0,90,180]){screwtrap();}} 
            }
        }

        //lid
        translate([boffset+gauge_box+slip,u*unit-gauge_box,gauge]){
            cube([width-gauge_box*2-slip*2,gauge_box,dp]);
        }    
        //back rest
        translate([sixinch/2-40,u*unit-gauge_box-2,gauge+dp-2-gauge_box]){
            cube([80,2,2]);
        }
    }        

    //Negative
    translate([boffset+gauge_box+4,unit*u+0.01  ,gauge+10+5]){rotate([90,0,0]){screw();}}
    translate([boffset+gauge_box+4,unit*u+0.01  ,gauge+dp-10-10+5]){rotate([90,0,0]){screw();}}    
    translate([sixinch-boffset-gauge_box-4,unit*u+0.01   ,gauge+10+10-5]){rotate([90,0,0]){screw();}}
    translate([sixinch-boffset-gauge_box-4,unit*u +0.01  ,gauge+dp-10-10+10-5]){rotate([90,0,0]){screw();}}
    if(dp>90){
        translate([sixinch-boffset-gauge_box-4,unit*u+0.01   ,gauge+dp/2-5+10-5]){rotate([90,0,0]){screw();}}    
        translate([boffset+gauge_box+4,unit*u+0.01   ,gauge+dp/2-5+5]){rotate([90,0,0]){screw();}}
    }
     chimney();

    
}        
}




module screw(){
    cylinder(r1=screw_head/2, r2=screw_dia/2, h=screw_head_height);
    cylinder(r=screw_dia/2, h=40);    
    translate([0,0,-0.99]){cylinder(r=screw_head/2, h=1);}    
}


module frontholes(u,screw_top,screw_bottom_front,screw_side_front){
    if(len(screw_bottom_front)>0){ 
    for(i=[0:len(screw_bottom_front)-1]){
        p = screw_bottom_front[i];
        translate([p,gauge_box+4,-0.01]){screw();}
        translate([sixinch-p,gauge_box+4,-0.01]){screw();}
    } 
    }    
    if(len(screw_side_front)>0){   //Side holes
        for(i=[0:len(screw_side_front)-1]){
            p = screw_side_front[i]*unit;
            translate([boffset+gauge_box+4,p,-0.01]){screw();}
            translate([sixinch-boffset-gauge_box-4,p,-0.01]){screw();}    
        } 
    }   
    if(len(screw_top)>0){   
    for(i=[0:len(screw_top)-1]){
        p = screw_top[i];
        translate([p,unit*u-gauge_box-4,-0.01]){screw();}
        translate([sixinch-p,unit*u-gauge_box-4,-0.01]){screw();}    
    }
    }
}  
module insideprofile(l){
    difference(){
        union(){
            translate([7.6,10,0]){cube([4.8,10,l]);}
            translate([0,7.6,0]){cube([20,4.8,l]);}  
            
            translate([6.5,10-2.1,0]){cube([7   ,10,l]);}
            translate([2.1,6.5,0]){cube([15.8,7   ,l]);}  
        }
        translate([4,4,-1]){
            cube([12,12,l+2]);
        }
    } 
    translate([20,20,0]){
        rotate([0,-90,0]){
            linear_extrude(20){
                polygon (points=[[0,0],[l,0],[0,l]]);
            }
        }
    }    
}



module rightbottomplate(t){
    difference(){
        bottomplate(t);
        translate([-1,-1,-1]){
            cube([(sixinch+20)/2+1,sixinch+20+2,t+2]);
        }
    }
}

module leftbottomplate(t){
    difference(){
        bottomplate(t);
        translate([(sixinch+20)/2,-1,-1]){
            cube([(sixinch+20)/2+1,sixinch+20+2,t+2]);
        }
       # translate([10,10,-1]){cylinder(r=2.5,h=base+2);}
        translate([10,sixinch+20-10,-1]){cylinder(r=2.5,h=base+2);}
    
        
        translate([(sixinch+20)/2-20,-1,2.1]){cube([40,sixinch+20+2,2]);}
        
        }
    
    translate([0,0,base]){insideprofile(10);}
    rotate([0,0,180]){translate([-20,-sixinch-20,base]){insideprofile(10);}}   
}


module bottomplate(t){
translate([1,1,0]){
    minkowski(){
        cube([sixinch+boffset-2,sixinch+boffset-2,t-1]);
        cylinder(r=1,h=1);
    }
}
}




module frontplate(u,square_hole,round_hole,round_peg,screw_side_front,screw_top,screw_bottom_front){

    difference(){
        baseplate(u);
        
                   
        
        //Square holes
        if(len(square_hole)>0){
        for(i=[0:len(square_hole)-1]){
            x = square_hole[i][0];
            y = square_hole[i][1];
            w = square_hole[i][2];
            h = square_hole[i][3];            
            translate([x,y,-1]){cube([w,h,gauge+2]);}        
        } 
        }
        
       //Round holes
        if(len(round_hole)>0){
        for(i=[0:len(round_hole)-1]){
            x = round_hole[i][0];
            y = round_hole[i][1];
            d = round_hole[i][2];                       
            translate([x,y,-1]){cylinder(r=d/2,gauge+1);}        
        }   
    }

        //Cabinet holes
        frontholes(u,screw_top,screw_bottom_front,screw_side_front);
        
    } 

    //chassis support
    /*
    translate([20+gauge_box,gauge_box,gauge]){
        difference(){
            cube([115-gauge_box*2,u*unit-2*gauge_box,3]);
            translate([gauge_box,gauge_box,-1]){ cube([115-gauge_box*4,u*unit-gauge_box*4,5]);}
        }
    } */

    //Support pegs
    if(len(round_peg)>0){
        for(i=[0:len(round_peg)-1]){
            x = round_peg[i][0];
            y = round_peg[i][1];
            od = round_peg[i][2];
            id = round_peg[i][3];  
            he = round_peg[i][4];  
            translate([x,y,gauge]){
                difference(){
                 #   cylinder(r=od/2,h=he);
                 #   cylinder(r=id/2,h=he+1);
                }        
            }
    
        }
    }
    
    //cabinet support bars
    translate([0,0,gauge]){
        translate([boffset+width*0.25,gauge_box,0]){  cube([width*0.5,1,1.5]);  }
        translate([boffset+width*0.25,unit*u-1-gauge_box,0]){  cube([width*0.5,1,1.5]);  }           
    }
    
    
    
    }








module baseplate(u,handle){
    difference(){
    union(){
        translate([1.25,1.25,1.25]){
            minkowski(){
                cube([sixinch-2.5,unit*u-2.5,gauge-2.5]);
                sphere(r=1.25);
            }
        }
    }
    //Rack mount holes
    sd=rack_screwhole/2;
    translate([sixinch/2-rackhole/2,unit,-gauge/2])                 {cylinder(r=sd,gauge*2);}
    translate([sixinch/2+rackhole/2,unit,-gauge/2])         {cylinder(r=sd,gauge*2);}
    translate([sixinch/2-rackhole/2,u*unit-(unit),-gauge/2])        {cylinder(r=sd,gauge*2);}
    translate([sixinch/2+rackhole/2,u*unit-(unit),-gauge/2]){cylinder(r=sd,gauge*2);}
    if(u>=12){
        translate([sixinch/2-rackhole/2,(u*unit)/2,-gauge/2])         {cylinder(r=sd,gauge*2);}
        translate([sixinch/2+rackhole/2,(u*unit)/2,-gauge/2]) {cylinder(r=sd,gauge*2);}
    }  
}    
}