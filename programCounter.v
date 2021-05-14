/*
 * Date: 4-25-2021
 * Author: Ramsey Alahmad
 * Name: programCounter
 * Functional as of 6:10pm 5/13/21  
 */

module programCounter
#(parameter SIZE = 16)
(
    input reset_n, clock, pcWrite,
    input[SIZE-1:0] inputAddress,
    output reg[SIZE-1:0] outputAddress
);

    always@(posedge clock, negedge reset_n)
    begin
        if(!reset_n)
        begin
            outputAddress <= 0;
        end
        else
        begin
            if(pcWrite)
                outputAddress <= inputAddress;   
        end       
    end
endmodule
