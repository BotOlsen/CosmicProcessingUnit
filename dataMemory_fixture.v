/*
 * Date: 05-04-2021
 * Author: Ramsey Alahmad
 * Name: Data Memory Fixture
 */

/*
 * Date: 05-13-2021
 * Author: Ramsey Alahmad
 * Name: Data Memory Fixture
 */


`include "dataMemory.v"

module dataMemory_fixture;
reg clk, reset_n, memoryWrite, memoryRead, sb;
reg [15:0] address;
reg [15:0] dataWrite;
wire [15:0] dataRead;

initial
    $vcdpluson;

initial
    $monitor($time, " reset_n = %b, \n\t\t memoryWrite = %b, memoryRead = %b, sb = %b, \n\t\t address = %h, dataWrite = %h, dataRead = %h", reset_n, memoryWrite, memoryRead, sb, address, dataWrite, dataRead);

dataMemory u1(.sb(sb), .clk(clk), .reset_n(reset_n), .memoryWrite(memoryWrite), .memoryRead(memoryRead), .address(address), .dataWrite(dataWrite), .dataRead(dataRead));


initial
begin
    clk = 1'b0;
   forever #10  clk = ~clk;
end


initial
begin

    sb = 1'b0;
    reset_n = 1'b0;
   
    #20 // write into memory
    reset_n = 1'b1;
    memoryRead = 1'b0;
    memoryWrite = 1'b1;
    address = 16'hFFFA;
    dataWrite = 16'h0045;

    #20 // read from memory
    memoryRead = 1'b1;
    memoryWrite = 1'b0;
    address = 16'h0000;
    dataWrite = 16'hFFFF;
    sb = 1'b0;

    #20 // read from memory
    memoryRead = 1'b1;
    memoryWrite = 1'b0;
    address = 16'hFFFA;
    dataWrite = 16'hFFFF;
    sb = 1'b0;
end

initial
begin
    #100 $finish;
end
endmodule
