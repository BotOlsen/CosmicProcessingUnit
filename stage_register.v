/*
 * Date: 4-25-2021
 * Author: Daniel Olsen
 * Name: stage_register
 */

module register #(parameter SIZE = 16) 
(
	input [SIZE-1:0] in,
	input writeEnable,  
	output reg [SIZE-1:0] out,
	input clk,
	input flush 
);

    always @ ( posedge clk, negedge flush)
    begin
        if(!flush)
            out <= {SIZE{1'b0}};
        else
        begin
            if(writeEnable)
                out <= in;
        end    
    end
endmodule