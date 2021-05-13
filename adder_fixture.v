/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: adder_fixture
 * Functional as of 3:15pm 5/13/21
 */

`include "adder.v"

module adder_fixture;

reg [15:0] op1;
reg [15:0] op2;
wire [15:0] R;

initial
	$vcdpluson;

initial
	$monitor($time, "  A = %h B = %h     A + B = %h  ", op1[15:0], op2[15:0], R[15:0]);

adder adderInstance(.A(op1), .B(op2), .sum(R));

//Op1 inputs change every 15 time units
initial
begin
	op1 = 16'h0021;
	#15 op1 = 16'h7676;
	#15 op1 = 16'h1234;
end

//Op2 inputs change every 15 time units
initial
begin
	op2 = 16'hF0FF;
	#15 op2 = 16'h0321;
	#15 op2 = 16'h6998;
end

//finish at 210
initial
begin
	#60 $finish;
end

endmodule
