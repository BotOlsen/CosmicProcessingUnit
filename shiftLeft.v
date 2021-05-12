/*
 * Date: 5-12-2021
 * Author: Daniel Olsen
 * Name: shiftLeft
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