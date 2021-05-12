`include "cpu.v"


module cpu_fiixture;

    reg clk, reset_n;
    wire PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memWrite, memToReg;
    wire [1:0] aluControlOp, regWrite;
    wire [2:0] jumpBranch, aluOp;
    wire [9:0] SignalFlushMuxOutput;
    wire [15:0] PCOutput, IFAdderOutput, Instruction, rd1Read, rd2Read, reg0Read, signExtendedImmediate, ShiftResult, IDAdderOutput, MemToRegMuxOutput, PCSourceMuxOutput, ALUSource1MuxOutput, ALUSource2MuxOutput, exReg0, ALUOverflowOutput, ALUOutput, DataMemoryOutput, zeroExtendedResult, rd1SrcMuxOutput, rd2SrcMuxOutput, DataMemoryOutputMuxResult, Register0SourceMuxOutput;
    wire [31:0] IFID_Output; 
    wire [65:0] IDEX_Output; 
    wire [57:0] EXM_Output;
    wire [54:0] MWB_Output;


always@(negedge clk)
begin
    $display($time, " Time   -------------------------------------------------------------------------------------------------------------------");
    $display("----------IF Stage-------------\nIFAdderOutput: %h\tPCSourceMuxOutput: %h\t PCOutput: %h\tInstruction: %h\n\n", IFAdderOutput, PCSourceMuxOutput, PCOutput, Instruction);
    $display("----------ID Stage-------------\nIFID_Output: %h\tRegister0SourceMuxOutput: %h\t rd1SrcMuxOutput: %h\trd2SrcMuxOutput: %h\tPCSrc: %b\taluBType: %b\taluSrc: %b\tzeroExtendFlag: %b\tmemRead: %b\tmemToReg: %b\tmemWrite: %b\taluControlOp: %b\tregWrite: %b\tjumpBranch: %b\n\n",  IFID_Output, Register0SourceMuxOutput, rd1SrcMuxOutput, rd2SrcMuxOutput, PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, aluControlOp, regWrite, jumpBranch);
    //$display("----------EX Stage-------------\nIFID_Output: %h\tRegister0SourceMuxOutput: %h\t rd1SrcMuxOutput: %h\trd2SrcMuxOutput: %h\tPCSrc: %b\taluBType: %b\taluSrc: %b\tzeroExtendFlag: %b\tmemRead: %b\tmemToReg: %b\tmemWrite: %b\taluControlOp: %b\tregWrite: %b\tjumpBranch: %b\n\n",  IFID_Output, Register0SourceMuxOutput, rd1SrcMuxOutput, rd2SrcMuxOutput, PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, aluControlOp, regWrite, jumpBranch);
end

initial
	$vcdpluson;

/*initial
begin
    $display("IF OUTPUTS---------------------------------------------------------------------------------------------------------------------------------------------");
	$monitor($time, "  clk = %b    reset_n = %b    PCOutput = %h     IFAdderOutput: %h  Instruction:  %h   IFID_Output: %h", clk, reset_n, PCOutput, IFAdderOutput, Instruction, IFID_Output);
end*/

// initial
// begin
// 	$monitor($time, " ----------IF Stage-------------\nIFAdderOutput: %h\tPCSourceMuxOutput: %h\t PCOutput: %h\tInstruction: %h\n\n",
//     "----------ID Stage-------------\nIFID_Output: %h\tRegister0SourceMuxOutput: %h\t rd1SrcMuxOutput: %h\trd2SrcMuxOutput: %h\tPCSrc: %b\taluBType: %b\taluSrc: %b\tzeroExtendFlag: %b\tmemRead: %b\tmemToReg: %b\tmemWrite: %b\taluControlOp: %b\tregWrite: %b\tjumpBranch: %b\n\n", 
//     IFAdderOutput, PCSourceMuxOutput, PCOutput, Instruction, 
//     IFID_Output, Register0SourceMuxOutput, rd1SrcMuxOutput, rd2SrcMuxOutput, PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, aluControlOp, regWrite, jumpBranch);
// end


cpu cpu_test(.clk(clk), .reset_n(reset_n), 
            .PCOutput(PCOutput), .IFAdderOutput(IFAdderOutput), .Instruction(Instruction), .PCSourceMuxOutput(PCSourceMuxOutput), 
            .IFID_Output(IFID_Output), .Register0SourceMuxOutput(Register0SourceMuxOutput), .rd1SrcMuxOutput(rd1SrcMuxOutput), .rd2SrcMuxOutput(rd2SrcMuxOutput), .PCSrc(PCSrc), .aluBType(aluBType), .aluSrc(aluSrc), .zeroExtendFlag(zeroExtendFlag), .memRead(memRead), .memToReg(memToReg), .memWrite(memWrite), .aluControlOp(aluControlOp), .regWrite(regWrite), .jumpBranch(jumpBranch)
            );

initial
begin
    clk = 1'b0;
    forever #20 clk = ~clk;
end

initial
begin
    reset_n = 1'b0;
    #20 reset_n = 1'b1;
    
end

initial
begin
    #180 $finish;
end 

endmodule