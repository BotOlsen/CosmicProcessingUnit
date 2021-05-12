/*
 * Date: 5-09-2021
 * Name: CPU
 */


`include "adder.v"
`include "programCounter.v"

`define WORD_SIZE 16

module cpu(
    input clk, reset_n,
    output [15:0] IFAdderOutput, PCOutput
);

    //Instruction Fetch
    //wire [15:0] PCOutput;
    //output [15:0] InstructionMemoryOutput;
    //wire [15:0] IFadderOutput;
    

    assign PCOutput = {`WORD_SIZE{1'b0}};
    assign IFAdderOutput = {`WORD_SIZE{1'b0}};

    adder IFadder(
        .A(PCOutput), 
        .B(16'h0002), 
        .sum(IFadderOutput)
        );

    programCounter ProgramCounter(
        .reset(reset_n),
        .clock(clk),
        .pcWrite(1'b1),
        .inputAddress(IFAdderOutput),
        .outputAddress(PCOutput)
    );

    

endmodule