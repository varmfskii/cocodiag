sz = 25.4*[4.25,.9,3];
label = 3.625*25.4;
rad=2;
$fn=30;
module screw(loc) {
    translate(loc-[0,1.6,0])
    rotate([90,0,0])
    {
        cylinder(3.2,1.5,1.5,center=true);
        cylinder(3.2,3.2,0,center=true);
    }
}

difference() {
    translate([0,0,sz[2]/2])
    minkowski() {
        sphere(rad);
        cube(sz-2*[rad,rad,rad],center=true);
    }
    translate([-42,0,-1])
    cube([84,12.5,16]);
    translate([0,16.75-sz[1]/2,27.25])
    minkowski() {
        sphere(.3);
        cube([53.8,1.5,44.5],center=true);
    }
    translate([0,12.75-sz[1]/2,0])
    cube([51,13.5,85],center=true);
    translate([0,-6.9,32.25])
    cube([51,32,34],center=true);
    translate([0,-sz[1]/2,32.25])
    cube([55,4,38],center=true);
    translate([sz[0]/2,0,sz[2]-17])
    cube([4,25,12.7], center=true);
    translate([sz[0]/2+1,0,sz[2]-23.35])
    rotate([0,45,0])
    cube([4,25,4], center=true);
    translate([sz[0]/2+1,0,sz[2]-10.65])
    rotate([0,45,0])
    cube([4,25,4], center=true);
    translate([-sz[0]/2,0,sz[2]-17])
    cube([4,25,12.7], center=true);
    translate([-sz[0]/2-1,0,sz[2]-23.35])
    rotate([0,45,0])
    cube([4,25,4], center=true);
    translate([-sz[0]/2-1,0,sz[2]-10.65])
    rotate([0,45,0])
    cube([4,25,4], center=true);
    translate([0,-sz[1]/2,1.8075*25.4+5])
    cube([label,2,label],center=true);
    translate([0,0,sz[2]])
    cube([label,sz[1],2],center=true);
    translate([0,sz[1]/2-7.25,10])
    cube([51,10,20],center=true);
    screw([22.75,sz[1]/2,22.5]);
    screw([-22.75,sz[1]/2,22.5]);
}
