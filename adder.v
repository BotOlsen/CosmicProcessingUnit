/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: adder
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