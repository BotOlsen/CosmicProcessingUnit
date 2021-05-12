/*
 * Date 05-05-2021
 * Author: Ramsey Alahmad
 * Name: Instruction Memory
 */


module instructionMemory
(
    input clk, reset_n, //inputAddress,
    input [7:0] address,
    //input [15:0] value,
    output reg [15:0] data
);

reg [7:0] memory [0:255];
reg [15:0] memoryValue;
integer index;

always@(posedge clk, negedge reset_n)
begin    
    if(!reset_n)
    begin
        memory [0] <= 8'h21; // ADD
        memory [1] <= 8'hFE;
        memory [2] <= 8'h22; // SUB
        memory [3] <= 8'hFB;
        memory [4] <= 8'h58; // Or Immediate 
        memory [5] <= 8'h23; 
        memory [6] <= 8'h9A; // And immediate
        memory [7] <= 8'h14; 
        memory [8] <= 8'h62; // MUL 
        memory [9] <= 8'hF5; 
        memory [10] <= 8'h68; // DIV
        memory [11] <= 8'hF1; 
        memory [12] <= 8'h9A; // SW
        memory [13] <= 8'hD5; 
        memory [14] <= 8'h02; // Or immediate (ORi R8, 2) (please check this one) 
        memory [15] <= 8'h28; 
        memory [16] <= 8'h9A; // LW
        memory [17] <= 8'hCE;
        memory [18] <= 8'h02; // SUB
        memory [19] <= 8'hF0;
        memory [20] <= 8'h21; // ADD
        memory [21] <= 8'hF1;
        memory [22] <= 8'h22; // SUB
        memory [23] <= 8'hF1; 
        memory [24] <= 8'h02; // And immediate (ANDi R8, 2) (please check this one) 
        memory [25] <= 8'h18;
        memory [26] <= 8'h94; // LBU
        memory [27] <= 8'hA6;
        memory [28] <= 8'h96; // SB
        memory [29] <= 8'hB6;
        memory [30] <= 8'h96; // LW
        memory [31] <= 8'hC6; 
        memory [32] <= 8'hD2; // SUB
        memory [33] <= 8'hF7; 
        memory [34] <= 8'h04; // BEQ
        memory [35] <= 8'h67;
        memory [36] <= 8'h11; // ADD
        memory [37] <= 8'hFB;
        memory [38] <= 8'h05; // BLT
        memory [39] <= 8'h57; 
        memory [40] <= 8'h21; // ADD
        memory [41] <= 8'hFB; 
        memory [42] <= 8'h02; // BGT 
        memory [43] <= 8'h47;
        memory [44] <= 8'h11; // ADD
        memory [45] <= 8'hF1;
        memory [46] <= 8'h11; // ADD
        memory [47] <= 8'hF1;
        memory [48] <= 8'h90; // LW
        memory [49] <= 8'hC8;
        memory [50] <= 8'h81; // ADD
        memory [51] <= 8'hF8; 
        memory [52] <= 8'h92; // SW
        memory [53] <= 8'hD8;
        memory [54] <= 8'h92; // LW
        memory [55] <= 8'hCA;
        memory [56] <= 8'hC1; // ADD
        memory [57] <= 8'hFC;
        memory [58] <= 8'hD2; // SUB
        memory [59] <= 8'hFD;
        memory [60] <= 8'hD1; // ADD
        memory [61] <= 8'hFC;
        memory [62] <= 4'h0; // HALT
        for(index = 63; index <= 255; index = index +1)
        begin
            memory [index] <= 8'h0;
        end
    end          
end

always@(*)
begin
    data = {memory[address+1], memory[address]};
end



endmodule 
