// GregFrost Prusa Mendel  
// Solid State Relay Cover
// Used to cover high voltage contacts of SSR
// GNU GPL v2
// Greg Frost
// gregfrost1@bigpond.com
// http://github.com/GregFrost/PrusaMendel

include <configuration.scad>

thickness=3;
clearance=0.5;

ssr_width=45.5+2*clearance;
ssr_height=23.5+2*clearance;
ssr_length=59.5;
ssr_base_length=62.2;
ssr_base_height=2.6;

ssr_hole_dia=9.5-clearance;
ssr_hole_inset=10.5-clearance;
ssr_base_hole_height=5;
ssr_end_length=15.5;

detail=1;
ssr_screw_inset=3.5;
ssr_nut_height=3;
ssr_nut_depth=2;
ssr_screw_head_depth=2;
ssr_screw_head_diameter=7;

ssr_wire_diameter=3;
ssr_cable_diameter=7.2;
ssr_cable_height=3;
ssr_strain_thickness=5;
ssr_strain_width=3;

ssr_terminal_separation=28;

ssr_cover();

module ssr_cover()
{
	difference ()
	{
		cube([ssr_height+2*thickness,ssr_width+2*thickness,
			ssr_end_length+thickness+ssr_cable_diameter]);

		translate([ssr_height+thickness-ssr_cable_height-ssr_cable_diameter/2,-1,
			ssr_screw_inset+m3_diameter+2+thickness+ssr_cable_diameter])
		cube([ssr_cable_height+2*thickness+2,ssr_width+2*thickness+2,
			ssr_end_length+thickness+ssr_cable_diameter]);

		translate([thickness+ssr_height,thickness,thickness+ssr_cable_diameter])
		rotate([0,-90,0])
		ssr ();

	}
}

module ssr()
{
	translate([m3_diameter/2+(ssr_length-ssr_base_length)/2+ssr_screw_inset,ssr_width/2,0])
	{
		translate([0,0,-thickness-1])	
		cylinder(r=m3_diameter/2,h=ssr_height+2*thickness+2);
		translate([0,0,ssr_height+thickness+ssr_nut_height/2-ssr_nut_depth])
		cylinder(r=m3_nut_diameter/2,h=ssr_nut_height,$fn=6,center=true);

		translate([0,0,-thickness-1])
		cylinder(r=ssr_screw_head_diameter/2,h=ssr_screw_head_depth+1);
	}

	translate([-ssr_cable_diameter/2,-thickness-1,ssr_cable_diameter/2+ssr_cable_height])
	rotate([-90,0,0])
	difference()
	{
		union()
		{
			cylinder(r=ssr_cable_diameter/2,h=ssr_width+2*thickness+2);
			translate([0,-ssr_cable_diameter/2,0])
			cube([ssr_cable_diameter/2+ssr_end_length+1,ssr_cable_diameter,
				ssr_width+2*thickness+2]);
		}
		for (i=[-1,1])
		translate([-ssr_strain_thickness,0,
			ssr_width/2+i*(ssr_width/2-ssr_strain_width)+thickness+1])
		cube([ssr_cable_diameter,ssr_cable_diameter+2,ssr_strain_width],center=true);
	}

	for (i=[-1,1])
	translate([-ssr_cable_diameter/2,ssr_width/2+i*ssr_terminal_separation/2,
			ssr_cable_height+ssr_cable_diameter/2])
	{
		cylinder(r=ssr_cable_diameter/2,
			h=ssr_height-ssr_cable_height-ssr_cable_diameter/2);
		translate([0,-ssr_cable_diameter/2,0])
		cube([ssr_cable_diameter,ssr_cable_diameter,
			ssr_height-ssr_cable_height-ssr_cable_diameter/2]);
	}

	difference()
	{
		union ()
		{
			cube([ssr_length,ssr_width,ssr_height]);
			translate([(ssr_length-ssr_base_length)/2,0,0])
			cube([ssr_base_length,ssr_width,ssr_base_height]);

			translate([(ssr_length-ssr_base_length)/2,ssr_width/2-ssr_hole_dia/2,0])
			cube([ssr_hole_inset,ssr_hole_dia,ssr_base_hole_height]);
		}
		translate([ssr_end_length,detail,ssr_height-detail])
		cube([ssr_length-2*ssr_end_length,ssr_width-2*detail,detail+1]);

		translate([0,0,ssr_base_hole_height])
		{
			translate([ssr_hole_inset-ssr_hole_dia/2,ssr_width/2,0])
			cylinder(r=ssr_hole_dia/2,h=ssr_height+1);
			translate([-1,ssr_width/2-ssr_hole_dia/2,0])
			cube([ssr_hole_inset-ssr_hole_dia/2+1,ssr_hole_dia,ssr_height+1]);
		}
	}
}