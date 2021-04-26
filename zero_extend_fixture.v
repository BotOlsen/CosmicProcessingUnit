/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: zero_extend_fixture
 */

 `include "zero_extend.v"

 module zero_extend_fixture;

 reg [7:0] dataMemoryOutput;
 wire [15:0] extendedResult;

initial
	$vcdpluson;

initial
	$monitor($time, "  dataMemoryOutput = %h  extendedResult = %h  ", dataMemoryOutput[7:0], extendedResult[15:0]);

zero_extend zero_extendInstance(.lowerByteDataMemoryOutput(dataMemoryOutput), .zeroExtendedResult(extendedResult));

//dataMemoryOutput inputs change every 15 time units
initial
begin
	dataMemoryOutput = 16'hF0FF;
	#15 dataMemoryOutput = 8'h21;
	#15 dataMemoryOutput = 8'h98;
end

//finish at 60
initial
begin
	#60 $finish;
end

endmodule
    