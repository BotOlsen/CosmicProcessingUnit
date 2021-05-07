/*
 * Date: 5-07-2021
 * Author: Daniel Olsen
 * Name: forwardingUnit_fixture
 */

`include "forwardingUnit.v"

module forwardingUnit_fixture;

    reg [1:0] exW, mW, wbW; 
    reg [3:0] exRegDest, mRegDest, wbRegDest, idreg1, idreg2;
    wire [1:0] Op1Fwd, Op2Fwd, R0Fwd;

initial
	$vcdpluson;

initial
	$monitor($time, "  exW = %b    mW= %b    wbW = %b     exRegDest= %b    mRegDest = %b    wbRegDest= %b    idreg1 = %b    idreg2 = %b    Op1Fwd= %b    Op2Fwd = %b    R0Fwd = %b    ", exW, mW, wbW, exRegDest, mRegDest, wbRegDest, idreg1,  idreg2, Op1Fwd, Op2Fwd, R0Fwd);

forwardingUnit forwardingUnitInstance(  .exW(exW) , .mW(mW), .wbW(wbW), 
                                        .exRegDest(exRegDest), .mRegDest(mRegDest), .wbRegDest(wbRegDest), .idreg1(idreg1),  .idreg2(idreg2),
                                        .Op1Fwd(Op1Fwd), .Op2Fwd(Op2Fwd), .R0Fwd(R0Fwd)
                                    );

//A inputs every 30 time units
initial
begin
    exW = 2'b00;   mW= 2'b00;   wbW =2'b00;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b01;   mW= 2'b00;   wbW =2'b00;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b00;   mW= 2'b01;   wbW =2'b00;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b00;   mW= 2'b00;   wbW =2'b01;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;

	#30 exW = 2'b01;   mW= 2'b00;   wbW =2'b01;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b01;   mW= 2'b01;   wbW =2'b00;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b00;   mW= 2'b01;   wbW =2'b01;    exRegDest= 4'b0010;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;

    #30 exW = 2'b01;   mW= 2'b00;   wbW =2'b01;    exRegDest= 4'b0011;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b01;   mW= 2'b01;   wbW =2'b00;    exRegDest= 4'b0010;   mRegDest = 4'b0110;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b00;   mW= 2'b01;   wbW =2'b01;    exRegDest= 4'b0010;   mRegDest = 4'b0011;   wbRegDest= 4'b1010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;

    #30 exW = 2'b11;   mW= 2'b11;   wbW =2'b11;    exRegDest= 4'b0111;   mRegDest = 4'b0010;   wbRegDest= 4'b0010;   idreg1 = 4'b0111;   idreg2 = 4'b0010;
	#30 exW = 2'b01;   mW= 2'b11;   wbW =2'b11;    exRegDest= 4'b0010;   mRegDest = 4'b0110;   wbRegDest= 4'b0010;   idreg1 = 4'b0010;   idreg2 = 4'b0010;
	#30 exW = 2'b00;   mW= 2'b01;   wbW =2'b11;    exRegDest= 4'b0010;   mRegDest = 4'b0011;   wbRegDest= 4'b1010;   idreg1 = 4'b0011;   idreg2 = 4'b0010;    

end

//finish at 210
initial
begin
	#450 $finish;
end

endmodule