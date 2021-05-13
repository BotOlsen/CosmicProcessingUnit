/*
 * Date: 5-02-2021
 * Author: Daniel Olsen
 * Name: alu_control_fixture
 * Functional as of 3:36pm 5/13/21 
 */

`include "alu_control.v"

module alu_control_fixture;

reg [1:0] AluControlOp;
reg [3:0] FunctionCode;

wire [2:0] ALUOp;

initial
	$vcdpluson;

initial
	$monitor($time, "  AluControlOp = %b    FunctionCode = %b    ALUOp = %b  ", AluControlOp[1:0], FunctionCode[3:0], ALUOp[2:0]);

alu_control alu_control_instance(.aluControlOp(AluControlOp), .functionCode(FunctionCode), .aluOp(ALUOp));

initial
begin
	AluControlOp = 2'b00;
    FunctionCode = 4'b0001;
    #10     FunctionCode = 4'b0010;
    #10     FunctionCode = 4'b0100;
    #10     FunctionCode = 4'b1000;
    #10     AluControlOp = 2'b01;
            FunctionCode = 4'b0101;
    #10     AluControlOp = 2'b11;
            FunctionCode = 4'b0100;
    #10     AluControlOp = 2'b10;
            FunctionCode = 4'b0001;            
end

//finish at 70
initial
begin
	#70 $finish;
end

endmodule