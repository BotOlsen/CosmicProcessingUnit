/*
 * Date: 05-12-2021
 * Author: Ramsey Alahmad
 * Name: Hazard Detection Fixture
 */

`include "hazardDetection.v"

module hazardDetection_fixture;
reg [3:0] opcode;
reg memoryRead;
reg [15:0] loadOp1, loadOp2;
reg [15:0] loadRead;
wire stall, fetchWrite, pcWrite;

initial 
    $vcdpluson;

initial
    $monitor($time, " opcode = %b, \n\t\t memoryRead = %b, loadOp1 = %h, loadOp2 = %h, loadRead = %h, \n\t\t stall = %b, fetchWrite = %b, pcWrite = %b", opcode, memoryRead, loadOp1, loadOp2, loadRead, stall, fetchWrite, pcWrite);

initial
begin
    /* attempt to test for memory read assertion */
    opcode = 4'b1010; // load byte unsigned 
    memoryRead = 1'b1; // read from memory 
    loadOp1 = 4'b0000;
    loadOp2 = 4'b0001;
    loadRead = 4'b0001; 


    /* branch less than */
    #10
    opcode = 4'b0101;
    memoryRead = 1'b0;
    loadOp1 = 4'b0011;
    loadOp2 = 4'b0001;
    loadRead = 4'b0001;
end

initial
begin
    #40 $finish;
end

endmodule
