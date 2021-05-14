/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: zero_extend
 * Functional as of 5:41pm 5/13/21  
 */

module zero_extend 
(
    input [7:0] lowerByteInput,
    output reg [15:0] zeroExtendedResult
);

    always @(*)
    begin
        zeroExtendedResult = {8'b0, lowerByteInput};
    end
endmodule

 
