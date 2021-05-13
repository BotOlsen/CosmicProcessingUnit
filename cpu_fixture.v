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
    $display("----------IF Stage-------------\nIFAdderOutput: %h\nPCSourceMuxOutput: %h\n PCOutput: %h\nInstruction: %h\n\n", IFAdderOutput, PCSourceMuxOutput, PCOutput, Instruction);
    $display("----------ID Stage-------------\nIFID_Output: %h\nRegister0SourceMuxOutput: %h\nrd1SrcMuxOutput: %h\nrd2SrcMuxOutput: %h\nPCSrc: %b\naluBType: %b\naluSrc: %b\nzeroExtendFlag: %b\nmemRead: %b\nmemToReg: %b\nmemWrite: %b\naluControlOp: %b\nregWrite: %b\njumpBranch: %b\n\n",  IFID_Output, Register0SourceMuxOutput, rd1SrcMuxOutput, rd2SrcMuxOutput, PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memToReg, memWrite, aluControlOp, regWrite, jumpBranch);
    $display("----------EX Stage-------------\nIDEX_Output: %h\nALUSource1MuxOutput: %h\nALUSource2MuxOutput: %h\nALUOutput: %h\nALUOverflowOutput: %h\nALUBType %b\n\n",  cpu_test.IDEX.out, cpu_test.ALUSource1Mux.out, cpu_test.ALUSource2Mux.out, cpu_test.ALU.result, cpu_test.ALU.overflow, cpu_test.IDEX.out[52]);
    $display("----------M Stage-------------\nEXM_Output: %h\nDataMemoryOutput: %h\nzeroExtendedResult: %h\nDataMemoryOutputMuxResult: %h\n\n\n",  cpu_test.EXM.out, cpu_test.DataMemory.data /*DataMemoryOutput*/, /*zeroExtendedResult*/, /*DataMemoryOutputMuxResult*/);
    $display("----------WB Stage-------------\nMWB_Output: %h\nMemToRegMuxOutput: %h\n\nRegDest: %h\nWBRegW: %b\n", MWB_Output, MemToRegMuxOutput, EXM_Output[3:0], EXM_Output[57:56]);
end

initial
	$vcdpluson;


cpu cpu_test(.clk(clk), .reset_n(reset_n), 
            .PCOutput(PCOutput), .IFAdderOutput(IFAdderOutput), .Instruction(Instruction), .PCSourceMuxOutput(PCSourceMuxOutput), 
            .IFID_Output(IFID_Output), .Register0SourceMuxOutput(Register0SourceMuxOutput), .rd1SrcMuxOutput(rd1SrcMuxOutput), .rd2SrcMuxOutput(rd2SrcMuxOutput), .PCSrc(PCSrc), .aluBType(aluBType), .aluSrc(aluSrc), .zeroExtendFlag(zeroExtendFlag), .memRead(memRead), .memToReg(memToReg), .memWrite(memWrite), .aluControlOp(aluControlOp), .regWrite(regWrite), .jumpBranch(jumpBranch)
            );

initial
begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

initial
begin
    reset_n = 1'b0;
    #20 reset_n = 1'b1;
    
end

initial
begin
    #2000 $finish;
end 

endmodule