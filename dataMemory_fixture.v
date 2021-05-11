/*
 * Date: 05-04-2021
 * Author: Ramsey Alahmad
 * Name: Data Memory Fixture
 */


`include "dataMemory.v"

module dataMemory_fixture;

    reg clk, reset_n, memoryWrite, memoryRead;
    reg [7:0] address;
    reg [15:0] dataWrite;
    wire [15:0] dataRead;

    initial
        $vcdpluson;

    initial
        $monitor($time, "clk = %b, reset_n = %b, \n\t\t memoryWrite = %b memoryRead = %b, \n\t\t address = %h dataWrite = %h dataRead = %h", clk, reset_n, memoryWrite, memoryRead, address, dataWrite, dataRead);


    initial begin // reset and read from memory 
        reset_n = 1'b0;
        memoryRead = 1'b1;
        address = 16'h0002;

        #20 // write into memory 
        reset_n = 1'b1;
        memoryRead = 1'b0;
        memoryWrite = 1'b1;
        address = 16'h0008;
        dataWrite = 16'hAAAA;

        #20 // read from memory 
        memoryRead = 1'b1;
        memoryWrite = 1'b0;
        address = 16'h0000;

    end

    initial
    begin
        clk = 1'b0;
        #10 forever clk = ~clk;
    end

    initial
    begin
       #150 $finish;
    end

endmodule
