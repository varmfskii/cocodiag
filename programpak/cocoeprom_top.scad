sz = 25.4*[4.25,.9,3];
rad=2;
$fn=30;

module post(p) {
    translate(p) {
        rotate([-90,0,0]) {
            cylinder(15,2.5,2.5);
            cylinder(17.5,1.5,1.5);
            translate([0,0,17.5])
                cylinder(1,1.5,1);
        }
        translate([0,5,0])
            cube([5,10,10],center=true);
    }
}

difference() {
    union() {
        translate([-25.25,0,-16.75])
        cube([50.5,5,33.5]);
        translate([-27,0,-18.5])
        cube([54,.9,37]);
        post([-22.75,0,8.5]);
        post([22.75,0,8.5]);
    }
    translate([0,-1,18.5])
    rotate([-90,0,0])
    cylinder(10,5,5);
}