/*
 * Date: 5-02-2021
 * Author: Ramsey Alahmad
 * Name: mux4to1_fixture
 * About: Testbench for 4 to 1 multiplexor
 * Functional as of 6:13pm 5/13/21  
 */

`include "mux4to1.v"

module mux4to1_fixture;

reg [15:0] input1, input2, input3, input4;
reg [1:0] switch;
wire [15:0] out;

initial // for waveforms
    $vcdpluson;

initial // for text display 
    $monitor($time, " Switch = %b Input1 = %h Input2 = %h Input3 = %h Input4 = %h Output = %h", switch, input1[15:0], input2[15:0], input3[15:0], input4[15:0], out[15:0]);


mux4to1 u1 (.switch(switch), .input1(input1), .input2(input2), .input3(input3), .input4(input4), .out(out));

// simulation

initial begin
    switch = 2'b00; input1 = 16'h1111; input2 = 16'h2222; input3 = 16'h3333; input4 = 16'h4444;
    #10 switch = 2'b01; input1 = 16'hAAAA; input2 = 16'hBBBB; input3 = 16'hCCCC; input4 = 16'hDDDD;
    #10 switch = 2'b10; input1 = 16'h1010; input2 = 16'h1234; input3 = 16'h4321; input4 = 16'hABCD;
    #10 switch = 2'b11; input1 = 16'h0000; input2 = 16'h2222; input3 = 16'h4321; input4 = 16'hFFFF;
    #10 $finish;
end
endmodule
