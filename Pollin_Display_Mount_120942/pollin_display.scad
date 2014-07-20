$fn=50;

disp_l = 165.75;
disp_h = 105.39;
disp_w = 2.8;
disp_ribbon_w = 19.5;
disp_ribbon_offset = 78.06-(disp_ribbon_w/2);
disp_frame_s = 9;
disp_frame_nwe = 3.5;

pcb_w = 128.8;
pcb_h = 85.5;
pcb_space_above = 15;
pcb_space_below = 5;

pcb_drillhole_ll = [4.4, 4.7, 0];
pcb_drillhole_ul = [4.4, pcb_h-4.7, 0];

pcb_drillhole_lr = [pcb_w-4.4, 4.7, 0];
pcb_drillhole_ur = [pcb_w-4.4, pcb_h-4.7, 0];

pcb_display_offset = [28, 26, 0]; // guesswork and sloppy measurements

base_extra_w = 10;
plate_width = 3;
spacer_r = 4;

// base plate
module baseplate() {
cube([base_extra_w + disp_l + base_extra_w, base_extra_w + disp_h + base_extra_w, plate_width]);
}

module hollow_spacer(r1=spacer_r, r2=2, h=plate_width+pcb_space_above) {
	difference() {
	cylinder(r=r1, h=h);
	translate([0,0,-1]) cylinder(r=r2, h=h+2);
	}
}

module display () {
	cube([disp_l, disp_w, disp_h]);
}

// baseplate plus spacer for PCB
baseplate();
translate(pcb_display_offset) {
	translate(pcb_drillhole_ul) hollow_spacer();
	translate(pcb_drillhole_ur) hollow_spacer();
	translate(pcb_drillhole_ll) hollow_spacer();
	translate(pcb_drillhole_lr) hollow_spacer();
}

// display mount
difference() {
	union() {
		translate([base_extra_w/2+disp_frame_nwe, base_extra_w/2 + disp_w/2 , 0]) cylinder(r=base_extra_w/2,h=disp_h/2);
		translate([disp_l+base_extra_w*1.5-disp_frame_nwe, base_extra_w/2 + disp_w/2 , 0]) cylinder(r=base_extra_w/2,h=disp_h/2);
	}
	translate([base_extra_w, base_extra_w/2, 25]) display();
}

// controller mount
translate([base_extra_w + disp_l/2-40, 0, plate_width-0.01]) cube([80, 8, 15]);