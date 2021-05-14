/*
 * Date: 5-09-2021
 * Name: CPU
 */


`include "adder.v"
`include "programCounter.v"
`include "instructionMemory.v"
`include "stage_buffer.v"
`include "register.v"
`include "comparator.v"
`include "mux4to1.v"
`include "mux2to1.v"
`include "sign_extend.v"
`include "shiftLeft.v"
`include "control.v"
`include "alu.v"
`include "alu_control.v"
`include "dataMemory.v"
`include "zero_extend.v"
`include "forwardingUnit.v"
`include "hazardDetection.v"

module cpu(
    input clk, reset_n 
);


wire PCSrc, aluBType, aluSrc, zeroExtendFlag, memRead, memWrite, memToReg, storeByte, stall, pcWrite, IFIDFlush;
wire [1:0] aluControlOp, regWrite; 
wire [1:0] Op1Fwd, Op2Fwd, R0Fwd;
wire [2:0] jumpBranch, aluOp;
wire [9:0] SignalFlushMuxOutput;
wire [15:0] PCOutput, IFAdderOutput, Instruction, rd1Read, rd2Read, reg0Read, signExtendedImmediate, ShiftResult, IDAdderOutput, MemToRegMuxOutput, PCSourceMuxOutput; 
wire [15:0] ALUSource1MuxOutput, ALUSource2MuxOutput, exReg0, ALUOverflowOutput, ALUOutput, DataMemoryOutput, zeroExtendedResult, rd1SrcMuxOutput, rd2SrcMuxOutput; 
wire [15:0] DataMemoryOutputMuxResult, Register0SourceMuxOutput, ID_zeroExtendedConstant, SignOrZeroExtendMuxOutput;
wire [31:0] IFID_Output; /*[31:16] IFAdderOutput, [15:0] Instruction Output*/
wire [66:0] IDEX_Output; /*[3:0] Function Code, [19:4] signExtendedImmediate, [35:20] rd2SrcMuxOutput, [51:36]rd1SrcMuxOutput, [52] ALUBType, [53] ALUSrc, [55:54] ALUControlOp}
                                [56] MemRead, [57] MemWrite, [58] zeroExtendFlag, [59] memToReg, [60:61] RegWrite, [65:62] EXRegDst, [66] storeByte*/
wire [58:0] EXM_Output; /*[3:0] MRegDest, [19:4] DataToWrite, [35:20] ALUOverflowOutput, [51:36] ALUOutput, [52] MemRead, [53] MemWrite, [54] zeroExtendFlag, [55] memToReg, [57:56] RegWrite, [58] storeByte*/
wire [54:0] MWB_Output; /* [3:0] WBRegDest, [19:4] ALUOverflowOutput, [35:20] DataMemoryOutputMuxResult, [51:36] ALUOutput, [52] memToReg, [54:53]RegWrite*/

assign EXALUBType = IDEX.out[52];

        
stage_buffer #(.SIZE(32)) IFID (
        .in({IFAdder.sum, Instruction}),
        .writeEnable(1'b1),             
        .clk(clk),
        .flush(reset_n),
        .out(IFID_Output)       
        );

/*[3:0] MRegDest, [19:4] DataToWrite, [35:20] ALUOverflowOutput, [51:36] ALUOutput, [52] MemRead, [53] MemWrite, [54] zeroExtendFlag, [55] memToReg, [57:56] RegWrite*/
stage_buffer #(.SIZE(59)) EXM (
        .in({ IDEX.out[66], IDEX.out[61:60], IDEX.out[59], IDEX.out[58], IDEX.out[57], IDEX.out[56], ALUOutput, ALUOverflowOutput, IDEX.out[51:36], IDEX.out[65:62]}),
        .writeEnable(1'b1),             
        .clk(clk),
        .flush(reset_n),
        .out(EXM_Output)       
        );      

stage_buffer #(.SIZE(55)) MWB (
        .in({ EXM.out[57:56], EXM.out[55], EXM.out[51:36]/*EXM.out[51:36]*/, DataMemoryOutputMuxResult, EXM.out[35:20], EXM.out[3:0]}),
        .writeEnable(1'b1),             
        .clk(clk),
        .flush(reset_n),
        .out(MWB_Output)       
        );

/*[3:0] Function Code, [19:4] signExtendedImmediate, [35:20] rd2SrcMuxOutput, [51:36]rd1SrcMuxOutput, [52] ALUBType, [53] ALUSrc, [55:54] ALUControlOp}
                                [56] MemRead, [57] MemWrite, [58] zeroExtendFlag, [59] memToReg, [61:60] RegWrite, [65:62]EXRegDest*/
stage_buffer #(.SIZE(67)) IDEX (
        .in({ storeByte, IFID.out[11:8], SignalFlushMuxOutput, rd1SrcMuxOutput, rd2SrcMuxOutput, SignOrZeroExtendMuxOutput, IFID.out[3:0]}),
        .writeEnable(1'b1),             
        .clk(clk),
        .flush(reset_n),
        .out(IDEX_Output)       
        );        

//Instantiation of IF Stage
adder IFAdder(
    .A(PCOutput),
    .B(16'h0002),
    .sum(IFAdderOutput)
);

/////////////////Forwarding UNit HERE//////////////////////////////////
forwardingUnit forwardingUnit(
        .exW(IDEX.out[61:60]),
        .mW(EXM.out[57:56]),
        .wbW(MWB.out[54:53]),
        .exRegDest(IDEX.out[65:62]),
        .mRegDest(EXM.out[3:0]),
        .wbRegDest(MWB.out[3:0]),
        .idreg1(IFID.out[11:8]),
        .idreg2(IFID.out[7:4]),
        .Op1Fwd(Op1Fwd),
        .Op2Fwd(Op2Fwd),
        .R0Fwd(R0Fwd)
);
///////////////////////////////////////////////////////////////////////




/////////////////Hazard Detection Unit Here////////////////////////////
/*
hazardDetection #(.SIZE(4)) (
        .memoryRead(IDEX.out[56]),
        .opcode(IFID.out[15:12]),
        .loadOp1(IFID.out[11:8]),
        .loadOp2(IFID.out[7:3]),
        loadRead(IDEX.out[65:52]),
        .stall(stall),
        .fetchWrite(IFIDFlush),
        .pcWrite(pcWrite)
);
*/
///////////////////////////////////////////////////////////////////////


mux2to1 PCSourceMux (
        .switch(PCSrc),                      
        .input1(IFAdderOutput),
        .input2(IDAdderOutput),
        .out(PCSourceMuxOutput)
);

programCounter PC(
    .reset_n(reset_n),
    .clock(clk),
    .pcWrite(1'b1), //pcWrite),                          //Actual value added later

    .inputAddress(PCSourceMuxOutput),
    .outputAddress(PCOutput)
);

instructionMemory IM(
    .clk(clk),
    .reset_n(reset_n),
    .address(PCOutput),
    .data(Instruction)
);

//Instantiation of ID Stage
register RegisterFile(
        .clk(clk), 
        .reset_n(reset_n), 
        .registerRead1(IFID.out[11:8]),
        .registerRead2(IFID.out[7:4]),
        .regWriteLocal(MWB.out[3:0]),                   //New
        .registerWrite(MWB.out[54:53]),                 //New
        .dataWrite(MemToRegMuxOutput),                     //New 
        .r0Write(MWB.out[19:4]),                        //New
        .dataRead1(rd1Read),
        .dataRead2(rd2Read), 
        .r0Read(reg0Read)
        );

mux4to1 Register0SourceMux(
        .switch(R0Fwd),                             //output of OFrwarding UNnit (R0Fwd)
        .input1(reg0Read),
        .input2(ALUOverflowOutput),  
        .input3(EXM.out[35:20]),                        //M Stage R OUTPUT
        .input4(MWB.out[19:4]),                         //WB STAGE R OUTPUT
        .out(Register0SourceMuxOutput)
);

mux4to1 rd1SourceMux(
        .switch(Op1Fwd),                            //output of OFrwarding UNnit (Op1Fwd)
        .input1(rd1Read),
        .input2(ALUOutput), 
        .input3(EXM.out[51:36]),                       //M Stage ALU OUTPUT
        .input4(MemToRegMuxOutput),                 //WB STAGE ALU OUTPUT
        .out(rd1SrcMuxOutput)
);

mux4to1 rd2SourceMux(
        .switch(Op2Fwd),                            //output of OFrwarding UNnit (Op2Fwd)
        .input1(rd2Read),
        .input2(ALUOutput),                        //EX STAGE ALU OUTPUT
        .input3(EXM.out[51:36]),                       //M Stage ALU OUTPUT
        .input4(MemToRegMuxOutput),                 //WB STAGE ALU OUTPUT
        .out(rd2SrcMuxOutput)
);

comparator Comparator(
    .r0(rd1SourceMux.out),
    .op1(rd1SourceMux.out),
    .CTRL(jumpBranch),
    .PCSrc(PCSrc)
);

mux2to1 SignOrZeroExtendMux(
        .switch(aluBType || jumpBranch[0] || jumpBranch[1] || jumpBranch[2]),
        .input1(ID_zeroExtendedConstant),
        .input2(signExtendedImmediate),
        .out(SignOrZeroExtendMuxOutput)
);

zero_extend ID_ZeroExtend(
        .lowerByteInput(IFID.out[7:0]),
        .zeroExtendedResult(ID_zeroExtendedConstant)
);

sign_extend SignExtend(
    .instruction(IFID.out[15:0]),
    .signExtendedImmediate(signExtendedImmediate)
);

shiftLeft ShiftLeft(
    .beforeShift(signExtendedImmediate),
    .afterShift(ShiftResult)
);

adder IDAdder (
    .A(IFID.out[31:16]),
    .B(ShiftResult),
    .sum(IDAdderOutput)
);

control ControlUnit(
    .multiDiv(IFID.out[3:2]),
    .opcode(IFID.out[15:12]),
    .aluBType(aluBType),
    .aluSrc(aluSrc),
    .zeroExtendFlag(zeroExtendFlag),
    .memRead(memRead),
    .memToReg(memToReg),
    .memWrite(memWrite),
    .aluControlOp(aluControlOp),
    .regWrite(regWrite),
    .jumpBranch(jumpBranch),
    .storeByte(storeByte)
);

mux2to1 #(.SIZE(10)) SignalFlushMux (
        .switch(1'b0),//stall),                      
        .input1({regWrite, memToReg, zeroExtendFlag, memWrite, memRead, aluControlOp, aluSrc, aluBType}),
        .input2(10'b0),
        .out(SignalFlushMuxOutput)
);

//Instantiation of EX Stage
mux2to1 ALUSource1Mux (
        .switch(EXALUBType),                      
        .input1(IDEX.out[51:36]),
        .input2(IDEX.out[19:4]),
        .out(ALUSource1MuxOutput)
);
 
mux2to1 ALUSource2Mux (
        .switch(IDEX.out[53]),                      
        .input1(IDEX.out[35:20]),
        .input2(IDEX.out[19:4]),
        .out(ALUSource2MuxOutput)
);

alu_control ALUControlUnit(
        .aluControlOp(IDEX.out[55:54]),
        .functionCode(IDEX.out[3:0]),
        .aluOp(aluOp)
);

alu ALU(
    .A(ALUSource1MuxOutput),
    .B(ALUSource2MuxOutput),
    .CTRL(aluOp),
    .result(ALUOutput),
    .overflow(ALUOverflowOutput)
);

//Instantiation of M Stage
dataMemory DataMemory(
        .clk(clk),
        .reset_n(reset_n),
        .sb(EXM.out[58]),
        .memoryWrite(EXM.out[53]),
        .memoryRead(EXM.out[52]),
        .address(EXM.out[51:36]),
        .dataWrite(EXM.out[19:4]),
        .dataRead(DataMemoryOutput)
);

zero_extend ZeroExtend(
        .lowerByteInput(DataMemoryOutput[7:0]),
        .zeroExtendedResult(zeroExtendedResult)
);

mux2to1 DataMemoryOutputMux(
        .switch(EXM.out[54]),                      
        .input1(DataMemoryOutput),
        .input2(zeroExtendedResult),
        .out(DataMemoryOutputMuxResult)
);



//Instantiation of WB Stage
mux2to1 MemToRegMux(
        .switch(MWB.out[52]),                      
        .input1(MWB.out[51:36]),
        .input2(MWB.out[35:20]),
        .out(MemToRegMuxOutput)
);


endmodule
