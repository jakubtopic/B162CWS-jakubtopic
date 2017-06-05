use <shapes.scad>
use <functions.scad>

/**
 * This module generates 2D profile of a given pipe
 * @param  {[type]}  shape      Pipe shape
 * @param  {[type]}  diameter   Pipe diameter
 * @param  {[type]}  wall_thick Wall thickness
 * @param  {Boolean} filling    Defines whether to fill the pipe or not
 */
module tubeProfile(shape, diameter, wall_thick, filling = false) {
    // To fill, or not to fill, that is the question!
    if(filling)
        offset(delta=wall_thick)
            object(shape, diameter);
    else
        difference() {
            offset(delta=wall_thick)
                object(shape, diameter);
            object(shape, diameter);
        }

    /**
     * Shape generator submodule
     * @param  {[type]} shape    Pipe shape
     * @param  {[type]} diameter Pipe diameter
     */
    module object(shape, diameter) {
        rotate(-90) // Y axis is no facing to bottom side

        // Missing the switch statement :'(
        if (shape == "Star")
            star(diameter);

        else if (shape == "RippedSquare")
            rippedSquare(diameter);

        else if (shape == "Pentagon")
            pentagon(diameter);

        else if (shape == "Circle")
            circle(d=diameter);

        else if (shape == "Square")
            square(diagonalToSide(diameter), center=true);
    }
}

/**
 * Customized linear_extrude wrapper
 * @param  {[type}  shape    Pipe shape
 * @param  {[type]}  length   Pipe length
 * @param  {[type]}  diameter Pipe diameter
 * @param  {[type]}  angle    The angle between the pipe and the plane
 * @param  {Boolean} cover    Determines whether to generate regular pipe
 *                            or a top cover of the pipe
 */
module extrude(shape, length, diameter, angle, cover = false) {
    // extrude 2D tube profile to 3D pipe
    if(!cover || angle == 0)
        linear_extrude(height = length)
            children(0);

    // If the pipe is tilted stretch the pipe to Z axis
    if(angle != 0) {
        // calculate overlap depending on pipe shape and diameter
        overlap =
            (shape == "Star" ? (angle > 0 ? diameter / 3 : (2 * diameter) / 3) :
             shape == "Circle" ? diameter / 2 :
             shape == "Pentagon" ? (angle > 0 ? pentagonRadius(diameter) :
                pentagonRadius(diameter) * cos(36)) :
                diagonalToSide(diameter) / 2)
            * tan(abs(angle));

        // Gernerate a top cover of the pipe?
        if(cover) {
            translate([0,0,overlap])
                linear_extrude(height = length)
                    children(0);
        } else {
            rotate([0,180,0])
                linear_extrude(height = overlap)
                    children(0);
        }
    }
}

/**
 * Module that enables generating junctions for any number of pipes
 * @param  {Array}  pipes      Array with pipes definition
 * @param  {Number} wall_thick Wall thickness
 */
module splitter(pipes=[[]], wall_thick=2.5) {
    /*
     * Firstly I thought it would be easiest if I generate filled tubes and then
     * subtract the filling but it behaved very strangely. In the end I generate
     * tubes without filling and remove the filling once again.
     */
    difference() {
        // Iterate through all pipes (any amount) and render each one
        iterator(pipes, wall_thick);

        // Remove center of the pipe. It's kinda duplicate but it's the best
        // solution that actually was working.
        iterator(pipes, wall_thick, false);
    }

    module iterator(pipes, wall_thick, type = true) {
        for (i = [0 : len(pipes)-1]) {
            pipe = pipes[i];
            if(type) {
                rotate([pipe[3] - 90, 0, (360/len(pipes)) * i]) {
                    // Render the pipe itself
                    extrude(pipe[0], pipe[1], pipe[2], pipe[3])
                        tubeProfile(pipe[0], pipe[2], wall_thick);

                    // Render a top cover of the pipe
                    rotate([0,180,0])
                        extrude(pipe[0], wall_thick, pipe[2], pipe[3], true)
                            tubeProfile(pipe[0], pipe[2], wall_thick, true);
                }
            } else {
                rotate([pipe[3] - 90, 0,(360/len(pipes)) * i])
                    extrude(pipe[0], pipe[1], pipe[2], pipe[3])
                        tubeProfile(pipe[0], pipe[2], 0, true);
            }
        }
    }
}
