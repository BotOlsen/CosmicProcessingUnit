/*
 * Date: 05-09-2021
 * Author: Ramsey Alahmad
 * Name: Hazard Detection Unit
 *
 */


module hazardDetection
#(parameter SIZE = 16)
(
    input memoryRead, // comes from execution stage 
    input [3:0] opcode,
    input [SIZE-1:0] loadOp1, loadOp2, // these registers come from the decode stage 
    input [SIZE-1:0] loadRead, // comes from the decode/execution stage 
    output reg stall, // sends to the or gate which has 2 inputs. the stall, and the flush which comes from the control unit 
    output reg fetchWrite, // sent towards IF/ID buffer pipeline 
    output reg pcWrite // send towards program counter 
);

wire compareLW1, compareLW2, compareTotal;

assign compareLW1 = loadOp1 == loadRead; 
assign compareLW2 = loadOp2 == loadRead;
assign compareTotal = compareLW1 || compareLW2;

always@(*)
begin
    if(opcode == 4'b1010 || opcode == 4'b1100)
    begin
        if(memoryRead && compareTotal)
        begin
            stall = 1'b1;
            fetchWrite = 1'b1;
            pcWrite = 1'b1;
        end
        else
        begin
            stall = 1'b0;
            fetchWrite = 1'b0;
            pcWrite = 1'b0;
        end
    end
    else if(opcode == 4'b0101 || opcode == 4'b0100 || opcode == 4'b0110)
    begin
        stall = 1'b1;
        fetchWrite = 1'b0;
        pcWrite = 1'b0;
    end
end
endmodule
