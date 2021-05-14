`include "cpu.v"


module cpu_fiixture;

    reg clk, reset_n;
    // wire PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memWrite, memToReg;
    // wire [1:0] aluControlOp, regWrite;
    // wire [2:0] jumpBranch, aluOp;
    // wire [9:0] SignalFlushMuxOutput;
    // wire [15:0] PCOutput, IFAdderOutput, Instruction, rd1Read, rd2Read, reg0Read, signExtendedImmediate, ShiftResult, IDAdderOutput, MemToRegMuxOutput, PCSourceMuxOutput, ALUSource1MuxOutput, ALUSource2MuxOutput, exReg0, ALUOverflowOutput, ALUOutput, DataMemoryOutput, zeroExtendedResult, rd1SrcMuxOutput, rd2SrcMuxOutput, DataMemoryOutputMuxResult, Register0SourceMuxOutput;
    // wire [31:0] IFID_Output; 
    // wire [65:0] IDEX_Output; 
    // wire [57:0] EXM_Output;
    // wire [54:0] MWB_Output;


always@(negedge clk)
begin
    $display($time, " Time   --------------------------------------------------------------------------------------------------------------------");
    $display("----------IF Stage-------------\nIFAdderOutput: %h\nPCSourceMuxOutput: %h\n PCOutput: %h\nInstruction: %h\n\n", cpu_test.IFAdder.sum, cpu_test.PCSourceMux.out, cpu_test.PC.outputAddress, cpu_test.IM.data);
    $display("----------ID Stage-------------\nIFID_Output: %h\nRegister0SourceMuxOutput: %h\nrd1SrcMuxOutput: %h\nrd2SrcMuxOutput: %h\nID_ZeroExtendedConstant: %h\nSignExtendedConstant: %h\nSignOrZeroExtendMuxOutput: %h\nPCSrc: %b\naluBType: %b\naluSrc: %b\nzeroExtendFlag: %b\nmemRead: %b\nmemToReg: %b\nmemWrite: %b\naluControlOp: %b\nregWrite: %b\njumpBranch: %b\n\n",  cpu_test.IFID.out, cpu_test.Register0SourceMux.out, cpu_test.rd1SourceMux.out, cpu_test.rd2SourceMux.out, cpu_test.ID_ZeroExtend.zeroExtendedResult, cpu_test.SignExtend.signExtendedImmediate, cpu_test.SignOrZeroExtendMux.out, cpu_test.Comparator.PCSrc, cpu_test.SignalFlushMux.out[0], cpu_test.SignalFlushMux.out[1], cpu_test.SignalFlushMux.out[6], cpu_test.SignalFlushMux.out[4]/*memRead*/, cpu_test.SignalFlushMux.out[7]/*memToReg*/, cpu_test.SignalFlushMux.out[5]/*memWrite*/, cpu_test.SignalFlushMux.out[3:2]/*aluControlOp*/, cpu_test.SignalFlushMux.out[9:8]/*regWrite*/, cpu_test.ControlUnit.jumpBranch/*jumpBranch*/);
    $display("----------EX Stage-------------\nIDEX_Output: %h\nALUSource1MuxOutput: %h\nALUSource2MuxOutput: %h\nALUOutput: %h\nALUOverflowOutput: %h\nALUBType: %b\nALUSrc: %b\nALUOp: %b\n\n",  cpu_test.IDEX.out, cpu_test.ALUSource1Mux.out, cpu_test.ALUSource2Mux.out, cpu_test.ALU.result, cpu_test.ALU.overflow, cpu_test.IDEX.out[52], cpu_test.IDEX.out[53], cpu_test.ALU.CTRL); 
    $display("----------M Stage-------------\nEXM_Output: %h\nDataMemoryOutput: %h\nzeroExtendedResult: %h\nDataMemoryOutputMuxResult: %h\nData to Store(lower 8 bits if SB): %h\n\n\n",  cpu_test.EXM.out, cpu_test.DataMemory.dataRead , cpu_test.ZeroExtend.zeroExtendedResult , cpu_test.DataMemoryOutputMux.out, cpu_test.EXM.out[19:4] );
    $display("----------WB Stage-------------\nMWB_Output: %h\nMemToRegMuxOutput: %h\n\nRegDest: %h\nWBRegW: %b\n", cpu_test.MWB.out, cpu_test.MemToRegMux.out, cpu_test.MWB.out[3:0], cpu_test.MWB.out[54:53]);
end

initial
	$vcdpluson;


cpu cpu_test(.clk(clk), 
            .reset_n(reset_n)
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
    #660 $finish;
end 

endmodule
