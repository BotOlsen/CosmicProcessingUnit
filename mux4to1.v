/*
 * Date : 5-02-2021
 * Author: Ramsey Alahmad
 * Name: mux4to1
 * Functional as of 6:13pm 5/13/21  
 */

module mux4to1
#(parameter SIZE = 16)
(
    input [SIZE-1:0] input1, input2, input3, input4,
    input [1:0] switch,
    output reg [SIZE-1:0] out
);


always@(*)
begin
    case(switch)
        2'b00: out = input1;
        2'b01: out = input2;
        2'b10: out = input3;
        2'b11: out = input4;
        default: out = input1;
    endcase
end
endmodule
