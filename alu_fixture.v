/*
 * Date: 5-01-2021
 * Author: Daniel Olsen
 * Name: alu_fixture
 */

`include "alu.v"

module alu_fixture;

reg [15:0] A;
reg [15:0] B;
reg [2:0] CTRL;
wire [15:0] R;
wire [15:0] overflow;

initial
	$vcdpluson;

initial
	$monitor($time, "  A = %h    B = %h    Result = %h     CTRL: %b    Overflow = %h", A[15:0], B[15:0], R[15:0], CTRL[2:0], overflow[15:0]);

alu aluInstance(.A(A) , .B(B), .CTRL(CTRL), .result(R), .overflow(overflow));

//A inputs every 30 time units
initial
begin
	A = 16'hF021;
	#30 A = 16'h7676;
	#30 A = 16'h6234;
	#30 A = 16'hFFFF;	
	#30 A = 16'h4545;
	#30 A = 16'hFFFF;
	#30 A = 16'h0002;
    #30 A = 16'h7676;
	#30 A = 16'h6234;
	#30 A = 16'hFFFF;	
	#30 A = 16'h4545;
end

//B inputs every 30 time units
initial
begin
	B = 16'h000FFFFF;
	#30 B = 16'h4321;
	#30 B = 16'h6998;
	#30 B = 16'hB0B0;	
	#30 B = 16'h4588;
	#30 B = 16'hCFCF;
	#30 B = 16'h3444;
    #30 B = 16'h4321;
	#30 B = 16'h6998;
	#30 B = 16'hB0B0;	
	#30 B = 16'h4588;
end

//CTRL signal change every 15 units
initial
begin
	CTRL = 3'b000;
	#15 CTRL = 3'b001;
	#15 CTRL = 3'b000;
	#15 CTRL = 3'b001;
	#15 CTRL = 3'b000;
	#15 CTRL = 3'b001;
	#15 CTRL = 3'b010;
	#15 CTRL = 3'b011;
	#15 CTRL = 3'b010;
	#15 CTRL = 3'b011;
	#15 CTRL = 3'b010;
	#15 CTRL = 3'b011;
	#15 CTRL = 3'b010;
	#15 CTRL = 3'b011;
    #15 CTRL = 3'b100;
	#15 CTRL = 3'b101;
	#15 CTRL = 3'b100;
	#15 CTRL = 3'b101;
	#15 CTRL = 3'b110;
	#15 CTRL = 3'b110;
	#15 CTRL = 3'b110;
	#15 CTRL = 3'b110;

end

//finish at 210
initial
begin
	#330 $finish;
end

endmodule