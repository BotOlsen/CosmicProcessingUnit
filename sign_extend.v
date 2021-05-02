/*
 * Date: 5-02-2021
 * Author: Daniel Olsen
 * Name: sign_extend
 */

module sign_extend 
(
    input [15:0] instruction,
    output reg [15:0] signExtendedImmediate
);

    always @(*)
    begin

        casex (instruction[15:12])
            4'b1XXX: if(instruction[3] == 1'b0)
                        signExtendedImmediate = {12'h000, instruction[3:0]};
                     else
                        signExtendedImmediate = {12'hFFF, instruction[3:0]};
            4'b0111: if(instruction[11] == 1'b0)
                        signExtendedImmediate = {4'h0, instruction[11:0]};
                     else
                        signExtendedImmediate = {4'hF, instruction[11:0]};
            4'b0XXX: if(instruction[7] == 1'b0)
                        signExtendedImmediate = {8'h00, instruction[7:0]};
                     else
                        signExtendedImmediate = {8'hFF, instruction[7:0]};
            default: signExtendedImmediate = {16'b0};               
        
        endcase



    end
endmodule