/*
 * Date: 5-01-2021
 * Author: Daniel Olsen
 * Name: stage_buffer
 */

module stage_buffer #(parameter SIZE = 16) 
(
	input [SIZE-1:0] in,
	input writeEnable,  
	output reg [SIZE-1:0] out,
	input clk, flush 
);

    always @ ( posedge clk, negedge flush)
    begin
        if(!flush)
        begin
            out <= {SIZE{1'b0}};
        end
        else if(writeEnable)
                out <= in;    
    end
endmodule