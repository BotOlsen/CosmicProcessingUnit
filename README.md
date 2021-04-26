# VerilogCPU
The goal of this project is to design and simulate a CPU with a custom ISA. The instruction set architecture being implemented is below as follows:

Function                      Syntax                OpCode      Op1         Op2           Function Code      Type       Operation
--------                      ------                ------      ---         ---           -------------      -----      ---------
Signed Addition               add op1, op2          1111        reg         reg           0001               A          op1 = op1 + op2

Signed Subtraction            sub op1, op2          1111        reg         reg           0010               A          op1 = op1 - op2

Signed Multiplication         mul op1, op2          1111        reg         reg           0100               A          op1 = op1 * op2
                                                                                                                        op1: Product (lower half)
                                                                                                                        R0:  Product (upper half)
                                                                                                                        
Signed Division               div op1, op2          1111        reg         reg           1000               A          op1: 16-bit quotient
                                                                                                                        R0: 16-bit remainder
                                                                                                                        
AND immediate                 andi op1, op2         0001        reg         Immediate     N/A                C          op1 = op1 & {8’b0, constant}

OR immediate                  or op1, op2           0010        reg         Immediate     N/A                C          op1 = op1 | {8’b0, constant}

Load Byte Unsigned            lbu op1, immd(op2)    1010        reg         reg           N/A                B          op1 = {8’b0, Mem [ immd + op2] } 
                                                                                                                        (sign extend  immd)

Store Byte                    sb op1, immd(op2)     1011        reg         reg           N/A                B          Mem [immd + op2](7:0) = op1(7:0)
                                                                                                                        (sign extend immd)

Load                          lw op1, immd(op2)     1100        reg         reg           N/A                B          op1 = Mem [ immd + op2]
                                                                                                                        (sign extend  immd)

Store                         sw op1, immd(op2)     1101        reg         reg           N/A                B          Mem [immd + op2] = op1
                                                                                                                        (sign extend immd)

Branch on Less Than           blt op1, op2          0101        reg         Immediate     N/A                C          if (op1 < R0) then PC = PC + op2
                                                                                                                        (sign extend op2 & shift left)

Branch on Greater Than        bgt op1, op2          0100        reg         Immediate     N/A                C          if ( op1 > R0 ) then PC = PC + op2
                                                                                                                        (sign extend op2 & shift left)

Branch on Equal               beq op1, op2          0110        reg         Immediate     N/A                C          if (op1 == R0) then PC = PC + op2
                                                                                                                        (sign extend op2 & shift left)

Jump                          jmp op1               0111        offset      ---           N/A                D          pc = pc + op1
                                                                                                                        (sign extend op1& shift left)

Halt                          Halt                  0000        ---         ---           N/A                D          halt program execution


Instruction Formats:
  Type A: 4-bit opcode, 4-bit operand 1, 4-bit operand 2, 4-bit funct code
  Type B: 4-bit opcode, 4-bit operand 1, 4-bit  operand 2, 4-bit offset
  Type C: 4-bit opcode, 4-bit operand 1, 8-bit offset/constant
  Type D: 4-bit opcode, 12-bit  offset in jump -- unused in halt
