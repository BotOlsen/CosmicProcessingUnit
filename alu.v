/*
 * Date: 5-01-2021
 * Author: Daniel Olsen
 * Name: alu
 */

module alu(
    input [15:0] A, B, input [2:0] CTRL, output reg [15:0] result, overflow
);

	always @(*)
	begin
			
		overflow = 16'b0;
		case(CTRL)
			3'b000: result = A + B;
			3'b001: result = A - B;
			3'b010: {overflow, result} = A * B;
            3'b011: begin
                        result = A / B;
                        overflow = A % B;
                    end
            3'b100: result = A & B;
            3'b101: result = A | B;
            default: begin
                        result = 16'b0;
                        overflow = 16'b0;
                     end
        endcase
	end
endmodule