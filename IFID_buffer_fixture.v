/*
 * Date: 5-01-2021
 * Author: Daniel Olsen
 * Name: IFID_buffer_fixture
 * Functional as of 5:46pm 5/13/21
 */

`include "stage_buffer.v"
module IFID_register_fixture;

reg clk, rst, write;
reg  [15:0] IF_adderOutput;
reg [15:0] IF_instructionMemoryOutput;

// dataout[31:16] = IF_adderOutput
// dataout[15:0] = IF_instructionMemoryOutput
wire [31:0] dataout;


initial
	$vcdpluson;

initial 
	$monitor ($time, " IF Adder output = %h    Instruction Memory output = %h    w_enable %b    Buffer Output = %h    ", IF_adderOutput, IF_instructionMemoryOutput, write,  dataout);
	

stage_buffer #(.SIZE(32)) IFIDRegister (
        .in({IF_adderOutput, IF_instructionMemoryOutput}),
        .writeEnable(write),        
        .clk(clk),
        .flush(rst),
        .out(dataout)       
        );	

initial
begin
	clk = 1'b0;
	forever #10 clk = ! clk;
end

initial
begin
	rst = 1'b0;
    #8 	rst = 1'b1;	
end

initial 
begin

	IF_adderOutput = 32'h00000000; write = 1'b0; IF_instructionMemoryOutput = 16'habab;
	@(posedge clk); IF_adderOutput = 16'habab; write = 1'b0; IF_instructionMemoryOutput = 16'habab;
	@(posedge clk); IF_adderOutput = 16'hdddd; write = 1'b0; IF_instructionMemoryOutput = 16'habab;
	@(posedge clk); IF_adderOutput = 16'habab; write = 1'b1; IF_instructionMemoryOutput = 16'hab46;
	@(posedge clk); IF_adderOutput = 16'hffff; write = 1'b0; IF_instructionMemoryOutput = 16'hab78;
	@(posedge clk); IF_adderOutput = 16'habab; write = 1'b1; IF_instructionMemoryOutput = 16'ha45b;
	@(posedge clk); IF_adderOutput = 16'hdada; write = 1'b1; IF_instructionMemoryOutput = 16'h789b;
	@(posedge clk); IF_adderOutput = 16'h1278; write = 1'b1; IF_instructionMemoryOutput = 16'haba1;
	@(posedge clk); IF_adderOutput = 16'habab; write = 1'b0; IF_instructionMemoryOutput = 16'h9876;
  
    #10     $finish;

end
endmodule