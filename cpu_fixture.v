`include "cpu.v"


module cpu_fiixture;

reg clk, reset_n;
wire [15:0] PCOutput, IFAdderOutput, Instruction;


initial
	$vcdpluson;

initial
	$monitor($time, "  clk = %b    reset_n = %b    PCOutput = %h     IFAdderOutput: %h  Instruction:  %h", clk, reset_n, PCOutput, IFAdderOutput, Instruction);

cpu cpu_test(.clk(clk), .reset_n(reset_n), .PCOutput(PCOutput), .IFAdderOutput(IFAdderOutput), .Instruction(Instruction));

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