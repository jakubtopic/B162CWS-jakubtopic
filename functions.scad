// Auxiliary functions

/**
 * Uses black magic to calculate side of square by given diagonal
 * @param  {[type]} diagonal) Square diagonal
 * @return {[type]}           Square side
 */
function diagonalToSide(diagonal) = sqrt(pow(diagonal,2)/2);

/**
 * 'Matematické tabulky pro střední školy' rulez
 * our 'diameter' = r + ϱ
 * ϱ = r * cos 180°/5 (could also be used for a generic n-gon but it's not
 *                     needed in this project, so we stick with 5 vertices)
 * => r = diameter / (1 + cos 36°)
 *
 * @param  {[type]} diameter) Pipe diameter
 * @return {[type]}           Outter radius of the pentagon
 */
function pentagonRadius(diameter) = diameter / (1 + cos(36));

/**
 * Auxiliary function for distance of polygon vertices
 * @param  {[type]} diameter) Pipe diameter
 * @return {[type]}           Distance of vertice
 */
function poly0(diameter) = (2 * diameter) / 3;

/**
 * Auxiliary function for distance of intersecting edges
 * @param  {[type]} diameter Pipe diameter
 * @return {[type]}          Distance of intersecting edge
 */
function poly1(diameter) = diameter / 3;
