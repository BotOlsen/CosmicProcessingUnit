/*
 * Date : 4-25-2021
 * Author: Ramsey Alahmad
 * Name: mux2to1_fixture
 * About: Testbench for 2 to 1 multiplexor
 * Functional as of 4:50pm 5/13/21 
 */

`include "mux2to1.v"
module mux2to1_fixture;

reg [15:0] input1, input2;
reg switch;
wire [15:0] out;

initial // for waveforms 
    $vcdpluson;

    initial // display 
        $monitor($time, " Switch = %b Input1 = %h Input2 = %h Output = %h", switch, input1[15:0], input2[15:0], out[15:0]);
            
            mux2to1 u1(.switch(switch), .input1(input1), .input2(input2), .out(out)); // instantination

// simulation
initial begin
    switch = 1'b1; input1 = 16'hABCD; input2 = 16'hAAAA;
    $display("When switch is 1\n");
    #10 switch = 1'b0; input1 = 16'hBBBB; input2 = 16'hCCCC;
    $display("When switch is 0\n");

    #10 $finish;
end
endmodule
