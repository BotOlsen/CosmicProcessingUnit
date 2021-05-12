`include "cpu.v"


module cpu_fiixture;

reg clk, reset_n;
wire [15:0] PCOutput, IFAdderOutput, Instruction, rd1Read, rd2Read, reg0Read;
wire [31:0] IFID_Output;


initial
	$vcdpluson;

/*initial
begin
    $display("IF OUTPUTS---------------------------------------------------------------------------------------------------------------------------------------------");
	$monitor($time, "  clk = %b    reset_n = %b    PCOutput = %h     IFAdderOutput: %h  Instruction:  %h   IFID_Output: %h", clk, reset_n, PCOutput, IFAdderOutput, Instruction, IFID_Output);
end*/

initial
begin
    $display("ID OUTPUTS---------------------------------------------------------------------------------------------------------------------------------------------");
	$monitor($time, "  IFID_Output: %h\trd1Read: %h\trd2Read: %h\treg0Read: %h", IFID_Output, rd1Read, rd2Read, reg0Read);
end


cpu cpu_test(.clk(clk), .reset_n(reset_n), .PCOutput(PCOutput), .IFAdderOutput(IFAdderOutput), .Instruction(Instruction), .IFID_Output(IFID_Output), .rd1Read(rd1Read), .rd2Read(rd2Read), .reg0Read(reg0Read));

initial
begin
    clk = 1'b0;
    forever #20 clk = ~clk;
end

initial
begin
    reset_n = 1'b0;
    #20 reset_n = 1'b1;
    
end

initial
begin
    #180 $finish;
end 

endmodule