/*
 * Date: 05-11-2021
 * Author: Ramsey Alahmad
 * Name: Program Counter Fixture
 * Functional as of 6:10pm 5/13/21 
 */

`include "programCounter.v";

module programCounter_fixtutre;
reg reset_n, clock, pcWrite;
reg [15:0] inputAddress;
wire [15:0] outputAddress;

initial
    $vcdpluson;

initial
    $monitor($time, " reset_n = %b, pcWrite = %b,\n\t\t inputAddress = %h, outputAddress = %h\n\n", reset_n, pcWrite, inputAddress, outputAddress);
 
programCounter u1 (.reset_n(reset_n), .clock(clock), .pcWrite(pcWrite), .inputAddress(inputAddress), .outputAddress(outputAddress));


initial
begin
    clock = 1'b0;
    forever #5 clock = ~clock;
end

initial
begin
    reset_n = 1'b0;
    pcWrite = 1'b0;

    #10 reset_n = 1'b1; pcWrite = 1'b1; inputAddress = 16'hAAAA;
    #10 pcWrite = 1'b1; inputAddress = 16'hBBBB;
    #10 pcWrite = 1'b1; inputAddress = 16'hCCCC;
    #10 reset_n = 1'b0; inputAddress = 16'hDDDD; pcWrite = 1'b0;
end

initial
begin
    #70 $finish;
end
endmodule
