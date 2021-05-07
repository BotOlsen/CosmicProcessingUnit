/*
 * Date: 5-07-2021
 * Author: Daniel Olsen
 * Name: comparator
 */

module comparator(
    input [15:0] r0, op1, 
    input [2:0] CTRL, 
    output reg PCSrc
);

	always @(*)
	begin
		case(CTRL)
			3'b000: PCSrc = 1'b0;   //Non branch/jump
			3'b100: PCSrc = 1'b1;   //Jump
            3'b001: begin           //BLT
                        if(op1 < r0)
                            PCSrc = 1'b1;
                        else
                            PCSrc = 1'b0;    
                    end
            3'b010: begin           //BGT
                        if(op1 > r0)
                            PCSrc = 1'b1;
                        else
                            PCSrc = 1'b0; 
                    end
            3'b011: begin           //BEQ
                        if(op1 == r0)
                            PCSrc = 1'b1;
                        else
                            PCSrc = 1'b0; 
                    end                                                    
            default: PCSrc = 1'b0;
        endcase
	end
endmodule