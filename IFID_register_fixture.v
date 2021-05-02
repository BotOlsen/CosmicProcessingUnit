`include "stage_buffer.v"
module IFED_register_fixture;

reg clk, rst, write;
reg  [15:0] adderIn;
reg [15:0] instructionIn;
wire [31:0] dataout;


initial
	$vcdpluson;

initial 
	$monitor ($time, " adder input = %h Instruction Memory input = %h w_enable %b Dataout = %h", adderIn, instructionIn, write,  dataout);
	

register #(.SIZE(32)) IFIDRegister (
        .in({adderIn, instructionIn}),
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

	adderIn = 32'h00000000; write = 1'b0; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'habab; write = 1'b0; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'hdddd; write = 1'b0; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'habab; write = 1'b1; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'hffff; write = 1'b0; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'habab; write = 1'b1; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'hdada; write = 1'b1; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'h1278; write = 1'b1; instructionIn = 16'habab;
	@(posedge clk); adderIn = 16'habab; write = 1'b0; instructionIn = 16'habab;
  
    #10     $finish;

end
endmodule