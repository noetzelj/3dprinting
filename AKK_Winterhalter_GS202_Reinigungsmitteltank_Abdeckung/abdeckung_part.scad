//dx = 103;
dx = 96;
dy = 33;
dwidth = 2;
dcornerrad=4;
hx = 73;
hy = 28;
hwidth = 2.4;
hrad = 5;
offhx = 9;
offhy = 2.5;

$fn=64;

module seitenteil_gerade(h=6, wbot=3.2, wtop=1.8) {
    rotate([90,0,90]) linear_extrude(height = 1) {
        polygon( points = [
            [0, 0], [wbot, 0], [wtop, h], [0, h]
            ], paths = [
            [0,1,2,3]]);
    }
}

module seitenteil_ecke(h=6, wbot=3.2, wtop=1.8, rad=6) {
    intersection() {
        translate([rad,rad,0]) rotate_extrude() {
            polygon( points = [
                [rad-wbot,0], [rad,0], [rad,h], [rad-wtop,h]
                ], paths = [
                [0,1,2,3]]);
        }
        cube([rad,rad,h]);
    }
}

module innenteil(h=6, wbot=3.2, wtop=1.8, rad=hrad, slit=1) {
    translate([offhx, offhy, dwidth]) {
        for(r=[0:1]) {
            translate([r*(hx), r*(hy)]) rotate([0,0,r*180]) {
                // unten links
                seitenteil_ecke(h=h, wbot=wbot, wtop=wtop, rad=rad);
                // unten
                translate([rad+slit,0,0]) scale([hx-2*rad-2*slit,1,1]) seitenteil_gerade();
                // unten rechts
                translate([hx,0,0]) rotate([0,0,90]) seitenteil_ecke(h=h, wbot=wbot, wtop=wtop, rad=rad);
                // links
                #translate([0,hy-rad-slit,0]) rotate([0,0,-90]) scale([hy-2*rad-2*slit,1,1]) seitenteil_gerade();
            }
        }
    }
}

module abdeckung() {
    // Deckel
    union() {
        difference(){
            hull() {
                translate([dcornerrad,dcornerrad,0]) cylinder(r=dcornerrad, h=dwidth);
                translate([dcornerrad,dy-dcornerrad,0]) cylinder(r=dcornerrad, h=dwidth);
                translate([dx-dcornerrad,dcornerrad,0]) cylinder(r=dcornerrad, h=dwidth);
                translate([dx-dcornerrad,dy-dcornerrad,0]) cylinder(r=dcornerrad, h=dwidth);
            }
            translate([dx/3,dy/2,0]) cylinder(r=2, h=40, center=true);
            translate([0,dy/2,dwidth]) scale([offhx-dwidth,dy/2-dcornerrad,1]) sphere(r=1, center=true);
            translate([dx,dy/2,dwidth]) scale([offhx-dwidth,dy/2-dcornerrad,1]) sphere(r=1, center=true);
        }
        translate([0,0,-0.01]) innenteil(wbot=4, wtop=2);
    }
}

//innenteil();
abdeckung();
//translate([0,45,0]) abdeckung();