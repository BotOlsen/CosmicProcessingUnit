/*
 * Date: 05-11-2021
 * Author: Ramsey Alahmad
 * Name: Control Fixture
 * Functional as of 3:31pm 5/13/21
 */


`include "control.v"

module control_fixture;

reg [1:0] multiDiv;
reg [3:0] opcode;
wire aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, storeByte;
wire [1:0] aluControl, regWrite;
wire [2:0] jumpBranch;

initial
    $vcdpluson;

initial 
    $monitor($time, " opcode = %b multiDiv = %b, \n\t\t aluBType = %b, aluSrc = %b, zeroExtendFlag = %b, memRead = %b, memToReg = %b, memWrite = %b, \n\t\t aluControl = %b, regWrite = %b, jumpBranch = %b  storeBYte: %b\n\n", opcode, multiDiv, aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, aluControl, regWrite, jumpBranch, storeByte);
 
 control u1 (.opcode(opcode), .multiDiv(multiDiv), .aluBType(aluBType), .aluSrc(aluSrc), .zeroExtendFlag(zeroExtendFlag), .memRead(memRead), .memToReg(memToReg), .memWrite(memWrite), .aluControlOp(aluControl), .regWrite(regWrite), .jumpBranch(jumpBranch), .storeByte(storeByte));


 initial
 begin
    opcode = 4'b1111; 
    #10 multiDiv = 1'b1; // type A with multiDiv flag 
    #10 multiDiv = 1'b0; opcode = 4'b0001;
    #10 opcode = 4'b0001; 
    #10 opcode = 4'b0010; 
    #10 opcode = 4'b1010;
    #10 opcode = 4'b1011;
    #10 opcode = 4'b1100;
    #10 opcode = 4'b1101;
    #10 opcode = 4'b0101;
    #10 opcode = 4'b0100;
    #10 opcode = 4'b0110;
    #10 opcode = 4'b0111;
    #10 opcode = 4'b0000;
end

initial
    #150 $finish;
endmodule
