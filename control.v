/*
 * Date: 05-09-2021
 * Author: Ramsey Alahmad
 * Name: Control Unit
 * Functional as of 3:31pm 5/13/21 
 */


module control
(
    input [1:0] multiDiv,
    input [3:0] opcode,
    output reg aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, storeByte,
    output reg [1:0] aluControlOp, regWrite, 
    output reg [2:0] jumpBranch
);

always@(*)
begin
    storeByte = 1'b0;
    case(opcode)
       
        4'b1111: // type A
        begin
           aluBType = 1'b0;
           aluSrc = 1'b0;
           aluControlOp = 2'b00;
           zeroExtendFlag = 1'b0;
           memRead = 1'b0;
           memToReg = 1'b0;
           memWrite = 1'b0;
           jumpBranch = 3'b000;
            if(multiDiv[1] == 1'b1 || multiDiv[0] == 1'b1) // if type A AND appears to be multi/division
                 regWrite = 2'b11;
            else // add/sub
                regWrite = 2'b01;
        end
        
        4'b0001: // AND immediate type C
        begin
            aluBType = 1'b0;
            aluSrc = 1'b1;
            aluControlOp = 2'b01;
            regWrite = 2'b01;
            zeroExtendFlag = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 3'b000;;
        end
        
        4'b0010: // OR immediate type C
        begin
            aluBType = 1'b0;
            aluSrc = 1'b1;
            aluControlOp = 2'b11;
            regWrite = 2'b01;
            zeroExtendFlag = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 3'b000;;
        end

        4'b1010: // LBU type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b0;
            aluControlOp = 2'b10;
            regWrite = 2'b01;
            zeroExtendFlag = 1'b1;
            memRead = 1'b1;
            memToReg = 1'b1;
            memWrite = 1'b0;
            jumpBranch = 3'b000;;
        end

        4'b1011: // Store Byte type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b0;
            aluControlOp = 2'b10;
            regWrite = 2'b00;
            zeroExtendFlag = 1'b0;
            memRead = 1'b0;
            memToReg = 1'bx; // dont care (please check this)
            memWrite = 1'b1; 
            jumpBranch = 3'b000;
            storeByte = 1'b1;
        end
        
        4'b1100: // load type B 
        begin
            aluBType = 1'b1;
            aluSrc = 1'b0;
            aluControlOp = 2'b10;
            regWrite = 2'b01;
            zeroExtendFlag = 1'b0;
            memRead = 1'b1;
            memToReg = 1'b1;
            memWrite = 1'b0; 
            jumpBranch = 3'b000;;
        end

        4'b1101: // store type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b0;
            aluControlOp = 2'b10;
            regWrite = 2'b00;
            zeroExtendFlag = 1'b0;
            memRead = 1'b0;
            memToReg = 1'bx; // dont care (please check this)
            memWrite = 1'b1; 
            jumpBranch = 3'b000;;
        end

        4'b0101: // branch on less than type C
        begin
            aluBType = 1'bx; // dont care (please check this)
            aluSrc = 1'bx; // ^ 
            aluControlOp = 2'bxx; // ^ 
            regWrite = 2'b00; 
            zeroExtendFlag = 1'bx;
            memRead = 1'b0;
            memToReg = 1'bx;
            memWrite = 1'b0;
            jumpBranch = 3'b001;
        end

        4'b0100: // branch greater than type C 
        begin
            aluBType = 1'bx;
            aluSrc = 1'bx;
            aluControlOp = 2'bxx;
            regWrite = 2'b00;
            zeroExtendFlag = 1'bx;
            memRead = 1'b0;
            memToReg = 1'bx;
            memWrite = 1'b0;
            jumpBranch = 3'b010;
        end

        4'b0110: // branch equal type C
        begin
           aluBType = 1'bx;
           aluSrc = 1'bx;
           aluControlOp = 2'bxx;
           regWrite = 2'b00;
           zeroExtendFlag = 1'bx;
           memRead = 1'b0;
           memToReg = 1'bx;
           memWrite = 1'b0;
           jumpBranch = 3'b011;
        end
        
        4'b0111: // jump type D
        begin
             aluBType = 1'bx;
             aluSrc = 1'bx;
             aluControlOp = 2'bxx;
             regWrite = 2'b00;
             zeroExtendFlag = 1'bx;
             memRead = 1'b0;
             memToReg = 1'bx;
             memWrite = 1'b0;
             jumpBranch = 3'b100;
        end

        4'b0000: // halt type D
        begin
            aluBType = 1'b0;
            aluSrc = 1'b0;
            aluControlOp = 2'b00;
            regWrite = 2'b00;
            zeroExtendFlag = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 3'b000;
        end
    endcase
  end
endmodule
