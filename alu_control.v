/*
 * Date: 5-02-2021
 * Author: Daniel Olsen
 * Name: alu_control
 */

module alu_control(
    input [1:0] aluControlOp, 
    input [3:0] functionCode, 
    output reg [2:0] aluOp
);

reg [31:0] temp;

	always @(*)
	begin
		
        if(aluControlOp == 2'b00) begin
            case(functionCode)
                4'b0001: aluOp = 000;
			    4'b0010: aluOp = 001;
			    4'b0100: aluOp = 010;
                4'b1000: aluOp = 011;
                default: aluOp = 3'b0;
            endcase
        end else begin
            case(aluControlOp)
                2'b01: aluOp = 100;
                2'b10: aluOp = 000;
                2'b11: aluOp = 101;
            endcase
        end
	end
endmodule