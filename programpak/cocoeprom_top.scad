sz = 25.4*[4.25,.9,3];
rad=2;
$fn=30;

module post(p) {
    translate(p) {
        rotate([-90,0,0]) {
            cylinder(16.5,2,2);
            cylinder(18.5,1.5,1.5);
            translate([0,0,18.5])
            cylinder(1,1.5,1);
        }
    }
}

difference() {
    union() {
        translate([-35.75,0,-30.75])
        cube([71.5,5,46.5]);
        translate([-37.5,0,-33.5])
        cube([75,.5,52]);
        post([-22.75,0,8.5]);
        post([22.75,0,8.5]);
    }
    translate([0,-1,18.5])
    rotate([-90,0,0])
    cylinder(10,5,5);
}