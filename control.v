/*
 * Date: 05-09-2021
 * Author: Ramsey Alahmad
 * Name: Control Unit
 */


module control
(
    input multiDiv,
    input [3:0] opcode,
    output reg aluBType, aluSrc, signChange, memRead, memToReg, memWrite,
    output reg [1:0] aluControl, regWrite, jumpBranch
);

always@(*)
begin
    case(opcode)
       
        4'b1111: // type A
        begin
           aluBType = 1'b0;
           aluSrc = 1'b0;
           aluControl = 2'b00;
           signChange = 1'b0;
           memRead = 1'b0;
           memToReg = 1'b0;
           memWrite = 1'b0;
           jumpBranch = 2'b00;
            if(multiDiv) // if type A AND appears to be multi/division
                 regWrite = 2'b11;
            else // add/sub
                regWrite = 2'b01;
        end
        
        4'b0001: // AND immediate type C
        begin
            aluBType = 1'b0;
            aluSrc = 1'b1;
            aluControl = 2'b01;
            regWrite = 2'b01;
            signChange = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 2'b00;
        end
        
        4'b0010: // OR immediate type C
        begin
            aluBType = 1'b0;
            aluSrc = 1'b1;
            aluControl = 2'b01;
            regWrite = 2'b01;
            signChange = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 2'b00;
        end

        4'b1010: // LBU type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b1;
            aluControl = 2'b10;
            regWrite = 2'b00;
            signChange = 1'b1;
            memRead = 1'b1;
            memToReg = 1'b1;
            memWrite = 1'b0;
            jumpBranch = 2'b00;
        end

        4'b1011: // Store Byte type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b1;
            aluControl = 2'b10;
            regWrite = 2'b01;
            signChange = 1'b0;
            memRead = 1'b0;
            memToReg = 1'bx; // dont care (please check this)
            memWrite = 1'b1; 
            jumpBranch = 2'b00;
        end
        
        4'b1100: // load type B 
        begin
            aluBType = 1'b1;
            aluSrc = 1'b1;
            aluControl = 2'b10;
            regWrite = 2'b00;
            signChange = 1'b0;
            memRead = 1'b1;
            memToReg = 1'b1;
            memWrite = 1'b0; 
            jumpBranch = 2'b00;
        end

        4'b1101: // store type B
        begin
            aluBType = 1'b1;
            aluSrc = 1'b1;
            aluControl = 2'b10;
            regWrite = 2'b01;
            signChange = 1'b0;
            memRead = 1'b0;
            memToReg = 1'bx; // dont care (please check this)
            memWrite = 1'b1; 
            jumpBranch = 2'b00;
        end

        4'b0101: // branch on less than type C
        begin
            aluBType = 1'bx; // dont care (please check this)
            aluSrc = 1'bx; // ^ 
            aluControl = 2'bxx; // ^ 
            regWrite = 2'b00; 
            signChange = 1'bx;
            memRead = 1'b0;
            memToReg = 1'bx;
            memWrite = 1'b0;
            jumpBranch = 2'b01;
        end

        4'b0100: // branch greater than type C 
        begin
            aluBType = 1'bx;
            aluSrc = 1'bx;
            aluControl = 2'bxx;
            regWrite = 2'b00;
            signChange = 1'bx;
            memRead = 1'b0;
            memToReg = 1'bx;
            memWrite = 1'b0;
            jumpBranch = 2'b01;
        end

        4'b0110: // branch equal type C
        begin
           aluBType = 1'bx;
           aluSrc = 1'bx;
           aluControl = 2'bxx;
           regWrite = 2'b00;
           signChange = 1'bx;
           memRead = 1'b0;
           memToReg = 1'bx;
           memWrite = 1'b0;
           jumpBranch = 2'b01;
        end
        
        4'b0111: // jump type D
        begin
             aluBType = 1'bx;
             aluSrc = 1'bx;
             aluControl = 2'bxx;
             regWrite = 2'b00;
             signChange = 1'bx;
             memRead = 1'b0;
             memToReg = 1'bx;
             memWrite = 1'b0;
             jumpBranch = 2'b11;
        end

        4'b0000: // halt type D
        begin
            aluBType = 1'b0;
            aluSrc = 1'b0;
            aluControl = 2'b00;
            regWrite = 2'b00;
            signChange = 1'b0;
            memRead = 1'b0;
            memToReg = 1'b0;
            memWrite = 1'b0;
            jumpBranch = 2'b00;
        end
    endcase
  end
endmodule