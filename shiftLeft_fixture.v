/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: shiftLeft_fixture
 * Functional as of 5:57pm 5/13/21 
 */

`include "shiftLeft.v"

module shiftLeft_fixture;

reg [15:0] beforeShift;
wire [15:0] afterShift;

initial
	$vcdpluson;

initial
	$monitor($time, "  Before = %b      After = %b  ", beforeShift, afterShift);

shiftLeft shiftLeftInstance(.beforeShift(beforeShift), .afterShift(afterShift));

//Op1 inputs change every 15 time units
initial
begin
	beforeShift = 16'h0021;
	#15 beforeShift = 16'h7676;
	#15 beforeShift = 16'h1234;
end

//finish at 210
initial
begin
	#60 $finish;
end

endmodule