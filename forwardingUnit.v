/*
 * Date: 5-07-2021
 * Author: Daniel Olsen
 * Name: forwardingUnit
 */

module forwardingUnit(
    input [1:0] exW, mW, wbW, 
    input [3:0] exRegDest, mRegDest, wbRegDest, idreg1, idreg2, 
    output reg [1:0] Op1Fwd, Op2Fwd, R0Fwd
);

	always @(*)
	begin
        if(idreg1 == exRegDest && exW[0] == 1'b1)
            Op1Fwd = 2'b01;
        else if(idreg1 == mRegDest && mW[0] == 1'b1)
            Op1Fwd = 2'b10;
        else if(idreg1 == wbRegDest && wbW[0] == 1'b1)
            Op1Fwd = 2'b11;
        else
            Op1Fwd = 2'b00;

        if(idreg2 == exRegDest && exW[0] == 1'b1)
            Op2Fwd = 2'b01;
        else if(idreg2 == mRegDest && mW[0] == 1'b1)
            Op2Fwd = 2'b10;
        else if(idreg2 == wbRegDest && wbW[0] == 1'b1)
            Op2Fwd = 2'b11;
        else
            Op2Fwd = 2'b00;

        if(exW[1] == 1'b1)
            R0Fwd = 2'b01;
        else if(mW[1] == 1'b1)
            R0Fwd = 2'b10;
        else if(wbW[1] == 1'b1)
            R0Fwd = 2'b11;
        else 
            R0Fwd = 2'b00;    

    end
endmodule