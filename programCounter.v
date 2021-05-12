/*
 * Date: 4-25-2021
 * Author: Ramsey Alahmad
 * Name: programCounter
 */

module programCounter
#(parameter SIZE = 16)
(
    input reset, clock, pcWrite,
    input[SIZE-1:0] inputAddress,
    output reg[SIZE-1:0] outputAddress
);

reg[SIZE-1:0] reserveAddress;
always@(posedge clock, negedge reset)
begin
    if(!reset)
    begin
        reserveAddress <= 0;
        outputAddress <= 0;
    end
    else
    begin
        if(pcWrite)
            outputAddress <= reserveAddress;
        else
        begin
            outputAddress <= inputAddress;
            reserveAddress <= inputAddress;
       end
    end       
end
endmodule
