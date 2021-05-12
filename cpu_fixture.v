`include "cpu.v"


module cpu_fiixture;

reg clk, reset_n;
wire [15:0] PCOutput, IFAdderOutput;

initial
	$vcdpluson;

initial
	$monitor($time, "  clk = %b    reset_n = %b    PCOutput = %h     IFAdderOutput: %h  ", clk, reset_n, PCOutput, IFAdderOutput);

cpu cpu_test(.clk(clk), .reset_n(reset_n), .PCOutput(PCOutput), .IFAdderOutput(IFAdderOutput));

initial
begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

initial
begin
    reset_n = 1'b1;
    #10 reset_n = 1'b0;
end

initial
begin
    #100 $finish;
end 

endmodule