# EuroServerRack

This is a project based on KronBjorn's [6 Inch Rack](https://github.com/KronBjorn/SixInchRack).  
It takes their design and removes the handles, and scales it to 128mm wide to fit in a eurorack.
The standard 1u was changed to be 5mm to match up with the eurorack standard's HP rack units. Ears and screwholes were scaled to use m3 for just about everything and cheaply available #6x1/2" screws(3mm x 10mm) for assembly.
It is inteded that you use a flexATX power supply and poke female 4 pin molex out of the back of each enclosure. In the future there will be an option for using barrel connectors added to all of the customizers.

For pictures have a look here:
 - [Printables Collection](https://www.printables.com/@Beefdip_176978/collections/1432728)]
 - [Power Supply Control Module](https://www.printables.com/model/871111-atx-power-supply-control-module-for-eurorack)
 - [FlexATX Mounting Plate](https://www.printables.com/model/871077-flex-atx-power-supply-eurorack-mount)


The project is a scaled down version of the familiar 19" rack standard, with the following size:
 - 1U(HP) is 5mm
 - The front plate is 128.5mm wide
 - The mounting holes are 122.5 mm center-to-center
 - The inside distance between the two vertical profiles is 110 mm
 - The ears protrude 9.25mm
 - The screw holes are sized for M3 cap screws

## I want to print a mount for a specific component
You can get info and STLs for specific components here:
 - [Printables Collection](https://www.printables.com/@Beefdip_176978/collections/1432728)]
 - [3u Eurorack Enclosure](https://www.printables.com/model/871019-3u-eurorack)
 - [Power Supply Control Module](https://www.printables.com/model/871111-atx-power-supply-control-module-for-eurorack)
 - [FlexATX Mounting Plate](https://www.printables.com/model/871077-flex-atx-power-supply-eurorack-mount)
 - [Hotswap Bay](https://www.printables.com/model/871097-eurorack-hotswap-bay)
 - [Fan Mounts and Ductwork](https://www.printables.com/model/871048-eurorack-fan-and-ductwork)

## I want to make a new cabinet for my favourite module
Start by inspecting this file for inspiration _RackCabinets/RaspberryPi34ModelB/usb_front.scad_, and take a look at the how to section below.

1. Create a new file that includes _sixinch_library.scad_
2. Customize all the parts needed for your cabinet
3. Create a new folder with you project, and anything else needed like print descriptions
4. If you like, create a Printables build with pictures and your stl, and add a link in this file

## Quick How To
A cabinet consist of five parts:
- Front plate
- Back plate
- Cabinet
- Lid
- Handles

In a new file, include _sixinch_library.scad_. For each of the parts, there is module in the library where you can specify the most commonly used features like round and square holes, and pegs for supporting PCB's etc.  
The deafult modules obviously does not support everything you need, but should give you a good start for further customization. Feel free to add functionality to the library.
