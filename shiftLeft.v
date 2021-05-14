/*
 * Date: 5-12-2021
 * Author: Daniel Olsen
 * Name: shiftLeft
 * Functional as of 5:57pm 5/13/21 
 */

module shiftLeft 
(
    input [15:0] beforeShift, 
    output reg [15:0] afterShift
);

    always @(*)
    begin
        afterShift = {beforeShift[13:0], 2'b00};
    end
endmodule