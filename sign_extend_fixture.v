/*
 * Date: 5-02-2021
 * Author: Daniel Olsen
 * Name: sign_extend_fixture
 */

 `include "sign_extend.v"

 module sign_extend_fixture;

    reg [15:0] Instruction;
    wire [15:0] SignExtendedImmediate;

initial
	$vcdpluson;

initial
	$monitor($time, "  Instruction = %b  sign Extended = %b  ", Instruction[15:0], SignExtendedImmediate[15:0]);

sign_extend sign_extendInstance(.instruction(Instruction), .signExtendedImmediate(SignExtendedImmediate));

//dataMemoryOutput inputs change every 15 time units
initial
begin
	Instruction = 16'hC001;
	#15 Instruction = 16'hA123;
	#15 Instruction = 16'hB598;
    #15 Instruction = 16'hD698;
	#15 Instruction = 16'h5123;
	#15 Instruction = 16'h4598;
    #15 Instruction = 16'h6628;   
    #15 Instruction = 16'h7698;  
    #15 Instruction = 16'h0000; 
end

//finish at 60
initial
begin
	#130 $finish;
end

endmodule