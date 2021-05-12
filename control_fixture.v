/*
 * Date: 05-11-2021
 * Author: Ramsey Alahmad
 * Name: Control Fixture
 *
 */


`include "control.v"

module control_fixture;

reg multiDiv;
reg [3:0] opcode;
wire aluBType, aluSrc, signExtendFlag, memRead, memToReg, memWrite;
wire [1:0] aluControl, regWrite, jumpBranch;

initial
    $vcdpluson;

initial 
    $monitor($time, " opcode = %b multiDiv = %b, \n\t\t aluBType = %b, aluSrc = %b, signExtendFlag = %b, memRead = %b, memToReg = %b, memWrite = %b, \n\t\t aluControl = %b, regWrite = %b, jumpBranch = %b ", opcode, multiDiv, aluBType, aluSrc, signExtendFlag, memRead, memToReg, memWrite, aluControl, regWrite, jumpBranch);
 
 control u1 (.opcode(opcode), .multiDiv(multiDiv), .aluBType(aluBType), .aluSrc(aluSrc), .signExtendFlag(signExtendFlag), .memRead(memRead), .memToReg(memToReg), .memWrite(memWrite), .aluControl(aluControl), .regWrite(regWrite), .jumpBranch(jumpBranch));


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
