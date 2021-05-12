/*
 * Date: 4-25-2021
 * Author: Ramsey Alahmad
 * Name: programCounter
 */

module programCounter
#(parameter SIZE = 16)
(
    input reset_n, clock, pcWrite,
    input[SIZE-1:0] inputAddress,
    output reg[SIZE-1:0] outputAddress
);

//reg[SIZE-1:0] reserveAddress;
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
