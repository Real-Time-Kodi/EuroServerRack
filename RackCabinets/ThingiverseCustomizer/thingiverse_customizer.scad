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



   //////////////////////////////////////////////////
  //  PASTE ALL OF: sixinch_library.scad IN HERE  //
 //   Thingiverse can only accept one file.      //
//////////////////////////////////////////////////


include<../sixinch_library.scad>

Part = "-"; // [a:All, b:FrontPlate, c:Cabinet, d:Lid, e:BackPlate]
Units = 6; //HP units (min 6)
Depth = 115; //depth of enclosure


go();

module go(){
    rotate([90,0,-90]){
        if(Part=="a"){
            frontplate(Units,[],[],[],[1.5,Units-2],[],[]);
            cabinet(Depth,Units,[],[],[1.5,Units-2]);
            lid(Depth,Units,[],[]);        
            back_plate(Units,Depth,[],[],[1.5,Units-2],[],[]);   
        }else if(Part=="b"){
            frontplate(Units,[],[],[],[1.5,Units-2],[],[]);
        }else if(Part=="c"){
            cabinet(Depth,Units,[],[],[1.5,Units-2]);
        }else if(Part=="d"){
           lid(Depth,Units,[],[]); 
        }else if(Part=="e"){
            back_plate(Units,Depth,[],[],[1.5,Units-2],[],[]);
        }
    }
}












