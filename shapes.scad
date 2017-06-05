use <functions.scad>

/**
 * Star shape
 * @param  {[type]} diameter Pipe diameter
 */
module star(diameter) {
    // length[0] - distance of vertice
    // length[1] - distance of intersecting edge
    length = [(2 * diameter) / 3, diameter / 3];

    // Generating points for polygon
    points = [
        for (angle = [0 : 36 : 360])
            [length[(angle/36) % 2] * cos(angle),
             length[(angle/36) % 2] * sin(angle)]
    ];

    // Render 2D star
    polygon(points);
}

/**
 * Ripped square shape
 * @param  {[type]} diameter Pipe diameter
 */
module rippedSquare(diameter) {
    side = diagonalToSide(diameter);

    // center the whole object
    translate([-side/2, -side/2])
        difference() {
            square(side);
            square(side/2);
        }
}

/**
 * Pentagon shape
 * @param  {[type]} diameter Pipe diameter
 */
module pentagon(diameter) {
    // Just a regular 'circle' with only 5 fragments
    // This could also be modified for a generic n-gon
    circle(r=pentagonRadius(diameter),$fn=5);
}
