/*
 * Date: 5-01-2021
 * Author: Daniel Olsen
 * Name: alu
 */

module alu(input [15:0] A, B, input [2:0] CTRL, output reg [15:0] result, overflow);

reg [31:0] temp;

	always @(*)
	begin
			
		
		case(CTRL)
			3'b000: result = A + B;
			3'b001: result = A - B;
			3'b010: temp = A * B;
                    result = temp[15:0];
                    overflow = temp[31:16];
            3'b011: result = A / B;
                    overflow = A % B;
            3'b100: result = A & B;
            3'b101: result = A | B;
            default: result = 16'b0;
                     overflow = 16'b0;
		endcase
	end
endmodule