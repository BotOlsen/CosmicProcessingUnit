/*
 * Date: 5-01-2021
 * reg0uthor: Daniel Olsen
 * Name: comparator_fixture
 */

`include "comparator.v"

module compatator_fixture;

reg [15:0] reg0;
reg [15:0] operand1;
reg [2:0] CTRL;
wire srcOutput;

initial
	$vcdpluson;

initial
	$monitor($time, "  r0 = %h    op1 = %h    CTRL = %b     PCSrc: %b ", reg0[15:0], operand1[15:0], CTRL[2:0], srcOutput);

comparator comparatorInstance(.r0(reg0) , .op1(operand1), .CTRL(CTRL), .PCSrc(srcOutput));

//reg0 inputs every 30 time units
initial
begin
	reg0 = 16'hFFF0;	
	#30 reg0 = 16'h4545;
	#30 reg0 = 16'hFF0F;
	#30 reg0 = 16'hFFF0;	
	#30 reg0 = 16'h4545;
	#30 reg0 = 16'hFF0F;
	#30 reg0 = 16'hFFF0;	
	#30 reg0 = 16'h4545;
	#30 reg0 = 16'hFF0F;

	#30 reg0 = 16'hFFF0;	
	#30 reg0 = 16'h4545;
	#30 reg0 = 16'hFF0F;
	#30 reg0 = 16'hFFF0;	
	#30 reg0 = 16'h4545;
	#30 reg0 = 16'hFF0F;


end

//operand1 inputs every 30 time units
initial
begin
	operand1 = 16'hFF00;
	#30 operand1 = 16'h4546;
	#30 operand1 = 16'hFF0F;
	#30 operand1 = 16'hFF00;	
	#30 operand1 = 16'h4546;
	#30 operand1 = 16'hCFCF;
	#30 operand1 = 16'hFF00;
    #30 operand1 = 16'h4546;
	#30 operand1 = 16'hff0f;

	#30 operand1 = 16'hFF00;	
	#30 operand1 = 16'h4546;
	#30 operand1 = 16'hCFCF;
	#30 operand1 = 16'hFF00;
    #30 operand1 = 16'h4546;
	#30 operand1 = 16'hff0f;


end

//CTRL signal change every 15 units
initial
begin
	CTRL = 3'b001;
    #90 CTRL = 3'b010;
    #90 CTRL = 3'b011;

    #90 CTRL = 3'b000;
    #90 CTRL = 3'b100;
end

//finish at 450
initial
begin
	#450 $finish;
end

endmodule