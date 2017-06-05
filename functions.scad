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
