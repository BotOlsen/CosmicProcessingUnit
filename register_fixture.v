/*
 * Date: 05-03-2021
 * Author: Ramsey Alahmad
 * Name: register_fixture
 */

`include "register.v"


module register_fixture;

reg clk, reset_n, registerWrite;
reg [3:0] registerRead1, registerRead2, regWriteLocal;
reg [15:0] dataWrite, r0Write;
wire [15:0] dataRead1, dataRead2, r0Read;



initial
    $vcdpluson;

/*
initial
    $monitor($time, " Clock = %b, Reset_n = %b, registerWrite = %b, \n\t registerRead1 = %h,
     dataRead1 = %h, \n\t registerRead2 = %h, dataRead2 = %h, \n\t regWriteLocal = %h,
      dataWrite = %h, r0Write = %h, r0Read = %h\n", clk, reset_n, registerWrite,
       registerRead1, dataRead1, registerRead2, dataRead2, regWriteLocal, dataWrite,
        r0Write, r0Read);
*/


initial
    $monitor($time, " clk = %b, reset_n = %b, registerWrite = %b, \n\t\t registerRead1 = %h, dataRead1 = %h,  \n\t\t registerRead2 = %h, dataRead2 = %h, \n\t\t regWriteLocal = %h, dataWrite = %h, r0Write =%h, r0Read = %h\n", clk, reset_n, registerWrite, registerRead1, dataRead1, registerRead2, dataRead2, regWriteLocal, dataWrite, r0Write, r0Read);



register u1 (
        .clk(clk), .reset_n(reset_n), .registerRead1(registerRead1),
         .registerRead2(registerRead2), .regWriteLocal(regWriteLocal),
          .dataWrite(dataWrite), .r0Write(r0Write), .dataRead1(dataRead1),
           .dataRead2(dataRead2), .r0Read(r0Read));  

initial // clock assignment 
begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

initial // Reset and then begin reading the registers 
begin
    reset_n = 1'b0; registerWrite = 1'b0;
    #15 reset_n = 1'b1;
    #10 registerRead1 = 1; registerRead2 = 2;
    #10 registerRead1 = 3; registerRead2 = 4;
    #10 registerRead1 = 5; registerRead2 = 6;

    // Reading of registers while writing towards
    registerWrite = 1'b1;
    #10 registerRead1 = 5; registerRead2 = 7;
        regWriteLocal = 7; dataWrite = 16'hABCD;
    #10 registerWrite = 1'b0; 
        registerRead1 = 7; registerRead2 = 8;

    // Write into R0 
    #10 r0Write = 16'hAAAA;

    // Resetting again 
    reset_n = 1'b0;
    #10 registerRead1 = 7; registerRead2 = 0;
    #10 reset_n = 1'b1;
    #10 registerRead1 = 7; registerRead2 = 0;
end

initial
begin
    #200 $finish;
end

endmodule 
