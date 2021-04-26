/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: zero_extend
 */

module zero_extend 
(
    input [7:0] lowerByteDataMemoryOutput,
    output reg [15:0] zeroExtendedResult
);

    always @(*)
    begin
        zeroExtendedResult = {8'b0, lowerByteDataMemoryOutput};
    end
endmodule

 
