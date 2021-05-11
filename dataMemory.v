/*
 * Date 05-04-2021
 * Author: Ramsey Alahmad
 * Name: dataMemory
 */


module dataMemory
(
    input clk, reset_n, memoryWrite, memoryRead,
    input [7:0] address,
    input [15:0] dataWrite,
    output reg [15:0] dataRead
);


reg [7:0] memoryData [255:0];

integer i;

always@(posedge clk, negedge reset_n)
begin
    if(!reset_n) // initialization or reset 
    begin
        memoryData [0] = 8'h56;
        memoryData [1] = 8'h38;
        memoryData [2] = 8'h00;
        memoryData [3] = 8'h00;
        memoryData [4] = 8'h12;
        memoryData [5] = 8'h43;
        memoryData [6] = 8'hDE;
        memoryData [7] = 8'hBE;
        memoryData [8] = 8'hEF;
        memoryData [9] = 8'hAD;

        for(i = 10; i <= 255; i = i+1) // sets all other addresses to be 0 
            memoryData[i] <= 8'h00;
    end

    if(memoryWrite) // concatenation 
        {memoryData[address], memoryData[address+1]} <= dataWrite;
    
    if(memoryRead) // takes the concatenation and places them in data read 
        dataRead <= {memoryData[address], memoryData[address+1]};

end

endmodule
