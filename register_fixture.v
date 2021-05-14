/*
 * Date: 05-03-2021
 * Author: Ramsey Alahmad
 * Name: register_fixture
 */

`include "register.v"


module register_fixture;

reg clk, reset_n;
reg [1:0] registerWrite;
reg [3:0] registerRead1, registerRead2, regWriteLocal;
reg [15:0] dataWrite, r0Write;
wire [15:0] dataRead1, dataRead2, r0Read;



initial
    $vcdpluson;

initial
    $monitor($time, " reset_n = %b, registerWrite = %b, \n\t\t registerRead1 = %h, dataRead1 = %h,  \n\t\t registerRead2 = %h, dataRead2 = %h, \n\t\t regWriteLocal = %h, dataWrite = %h, r0Write =%h, r0Read = %h\n", reset_n, registerWrite, registerRead1, dataRead1, registerRead2, dataRead2, regWriteLocal, dataWrite, r0Write, r0Read);



register u1 (
        .clk(clk), .reset_n(reset_n), .registerRead1(registerRead1),
         .registerRead2(registerRead2), .regWriteLocal(regWriteLocal),
          .dataWrite(dataWrite), .r0Write(r0Write), .dataRead1(dataRead1),
           .dataRead2(dataRead2), .r0Read(r0Read), .registerWrite(registerWrite));  

initial // clock assignment 
begin
    clk = 1'b0;
    forever #10 clk = ~clk;
end

initial // Reset and then begin reading the registers 
begin
    reset_n = 1'b0; registerWrite = 2'b0;

    #10 reset_n = 1'b1;
    
    #10 registerWrite = 2'b00;  //read r3 and r4
        registerRead1 = 4'h3;
        registerRead2 = 4'h4;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1234;


    #10 registerWrite = 2'b00;  // read r0 and r3 to make sure writes did not occur
        registerRead1 = 4'h0;
        registerRead2 = 4'h3;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1235;    

    #10 registerWrite = 2'b01; //write to r3 the value of 4020
        registerRead1 = 4'h3;
        registerRead2 = 4'h4;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1236; 

    #10 registerWrite = 2'b00;  // read r3 to make sure 4020 is there
        registerRead1 = 4'h3;
        registerRead2 = 4'h4;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1237;             


    #10 registerWrite = 2'b10; //write to r0 the value of h1239
        registerRead1 = 4'h3;
        registerRead2 = 4'h4;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1239; 

    #10 registerWrite = 2'b00;  // read r0 to make sure h1239 is there
        registerRead1 = 4'h3;
        registerRead2 = 4'h4;
        regWriteLocal = 4'h3;
        dataWrite = 16'h4020;
        r0Write = 16'h1237;                    


end

initial
begin
    #200 $finish;
end

endmodule 
