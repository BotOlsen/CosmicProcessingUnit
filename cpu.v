/*
 * Date: 5-09-2021
 * Name: CPU
 */


`include "adder.v"
`include "programCounter.v"
`include "instructionMemory.v"

module cpu(
    input clk, reset_n,
    output [15:0] PCOutput, IFAdderOutput, Instruction

);

//assign PCOutput = 0;
//assign IFAdderOutput = 0;


adder IFAdder(
    .A(PCOutput),
    .B(16'h0002),
    .sum(IFAdderOutput)
);

programCounter PC(
    .reset_n(reset_n),
    .clock(clk),
    .pcWrite(1'b1),
    .inputAddress(IFAdderOutput),
    .outputAddress(PCOutput)
);

instructionMemory IM(
    .clk(clk),
    .reset_n(reset_n),
    .address(PCOutput),
    .data(Instruction)
);

endmodule