/*
 * Date: 5-09-2021
 * Name: CPU
 */


`include "adder.v"
`include "programCounter.v"

module cpu(
    input clk, reset_n,
    output [15:0] PCOutput, IFAdderOutput,
    output pcWrite
);

//assign PCOutput = 0;
//assign IFAdderOutput = 0;
assign pcWrite = 1;

adder IFAdder(
    .A(PCOutput),
    .B(16'h0002),
    .sum(IFAdderOutput)
);

programCounter PC(
    .reset_n(reset_n),
    .clock(clk),
    .pcWrite(pcWrite),
    .inputAddress(IFAdderOutput),
    .outputAddress(PCOutput)
);

endmodule