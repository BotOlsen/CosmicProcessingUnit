/*
 * Date: 5-09-2021
 * Name: CPU
 */


`include "adder.v"
`include "programCounter.v"
`include "instructionMemory.v"
`include "stage_buffer.v"

module cpu(
    input clk, reset_n,
    output [15:0] PCOutput, IFAdderOutput, Instruction, 
    output [31:0] IFID_Output //bits [31:16] IFAdderOutput, bits[15:0] Instruction Output

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

stage_buffer #(.SIZE(32)) IFID (
        .in({IFAdderOutput, Instruction}),
        .writeEnable(1'b1),        
        .clk(clk),
        .flush(reset_n),
        .out(IFID_Output)       
        );



endmodule