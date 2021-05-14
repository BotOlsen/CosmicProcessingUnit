/*
 * Date: 05-10-2021
 * Author: Ramsey Alahmad
 * Name: Instruction Memory
 * Functional as of 6:15pm 5/13/21 
 *
 */

`include "instructionMemory.v"

module instructionMemory_fixture;

reg clk, reset_n;
reg [7:0] address;
wire [15:0] data;

initial
    $vcdpluson;

initial
    $monitor($time, " clk = %b, reset_n = %b, \n\t\t address = %h, data =%h", clk, reset_n, address,  data);


instructionMemory u1(.clk(clk), .reset_n(reset_n), .address(address), .data(data));



initial
begin
    clk = 1'b0;
    forever #10 clk =~ clk;
end

initial
begin
    reset_n = 1'b0; // reset / initialization
    address = 0;
    
    #30 address = 2;  reset_n = 1'b1; // data input
    #10 address = 4;
    #10 address = 6;
    #10 address = 8;
    #10 address = 10;
    #10 address = 12;
    #10 reset_n = 1'b0;
    #10 address = 2;
    #10 address = 4;
    #10 address = 6;
    #10 address = 8;
    #10 address = 10;
    #10 address = 12; 
end
    

initial
    #170 $finish;
endmodule
