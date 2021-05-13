/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: adder
 * Functional as of 3:15pm 5/13/21
 */

module adder 
(
    input [15:0] A, B, 
    output reg [15:0] sum
);
    always @(*)
    begin
        sum = A + B;
    end
endmodule