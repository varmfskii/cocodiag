sz = 25.4*[4.25,.9,3];
rad=3;
$fn=30;

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
        cube([53.3,1.6,44.5],center=true);
    }
    translate([0,13-sz[1]/2,0])
    cube([51,14,85],center=true);
    translate([0,-6.9,32.25])
    cube([51,31,34],center=true);
    translate([0,-sz[1]/2+.5,39.75])
    cube([76,1,53],center=true);
    translate([0,-7.3,39.75])
    cube([72,20,47],center=true);
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
    translate([0,-sz[1]/2,55.5])
    cube([3.5*25.4+1,1,100], center=true);
    translate([0,0,sz[2]])
    cube([3.5*25.4+1,100,1], center=true);
}

